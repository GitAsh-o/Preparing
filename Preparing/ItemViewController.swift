//
//  ItemViewController.swift
//  Preparing
//
//  Created by 大沼朝陽 on 2023/09/17.
//

import UIKit
import RealmSwift

class ItemViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    let realm = try! Realm()
    var items: [Item] = []
    var selectedEvent: Event!
    
    var unchecked: UIImage = UIImage(named: "checkbox")!
    var checked: UIImage = UIImage(named: "checkbox1")!
    var checkCount: Int = 0
    var checkArray: [Bool] = []
    var shareArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "FFEED4")
        tableView.backgroundColor = UIColor(hex: "FFEED4")
    
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        navigationItem.title = selectedEvent.title
        
        let button = UIButton()
        button.frame = CGRect(x: 275, y: 625, width: 100,height: 100)
        button.setImage(UIImage(named: "reset"), for: .normal)
        button.addTarget(self, action: #selector(reset), for: .touchUpInside)
        tableView.addSubview(button)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        items = readItems()
        tableView.reloadData()
        checkArray.removeAll()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
        let item: Item = items[indexPath.row]
        cell.setCell(title: item.title)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        shareArray.append("\(item.title)")
        checkArray += [false]
        
        let button = UIButton()
        let button2 = UIButton()
        
        button.frame = CGRect(x: tableView.frame.width * 0.8, y: 0, width: tableView.frame.width * 0.2, height: (cell.frame.height))
        button.setTitle("･･･",for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button.tag = indexPath.row
        
        button2.frame = CGRect(x: tableView.frame.width * 0.05, y: 10, width: 30, height: 30)
        button2.setImage(unchecked, for: .normal)
        button2.addTarget(self, action: #selector(button2Tapped(_:)), for: .touchUpInside)
        button2.tag = indexPath.row
        
        cell.addSubview(button)
        cell.addSubview(button2)
        
        return cell
    }
    
    func readItems() -> [Item]{
        return Array(realm.objects(Item.self).filter("event == %@", selectedEvent!))
    }
    
    func reload(){
        items = readItems()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNewItemView" {
            let newItemViewController = segue.destination as! NewItemViewController
            newItemViewController.event = self.selectedEvent
            newItemViewController.viewNum = 1
        }
    }
    
    @objc func reset(){
        checkArray.removeAll()
        tableView.reloadData()
        print(shareArray)
    }
    
    @objc func buttonTapped(_ sender: UIButton){
        let editMenu = UIAction(title: "編集", image: nil) { (action) in
            print("編集")
            let storyboard: UIStoryboard = self.storyboard!
            let nextView = storyboard.instantiateViewController(identifier: "NewItemView") as! NewItemViewController
            nextView.viewNum = 2
            nextView.thisItem = self.items[sender.tag]
            self.present(nextView, animated: true, completion: nil)
        }
        let deleteMenu = UIAction(title: "削除", image: nil) { (action) in
            print("削除")
            let alert = UIAlertController(
                title: "イベントを削除",
                message: "このイベントは削除されます",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(
                title: "削除",
                style: .default,
                handler: {action in
                    print("deleteCell")
                    try! self.realm.write{
                        self.realm.delete(self.items[sender.tag])
                    }
                    self.items.remove(at: sender.tag)
                    self.checkArray.removeAll()
                    self.reload()
                }
            ))
            alert.addAction(UIAlertAction(
                title: "キャンセル",
                style: .default,
                handler: {action in
                }
            ))
            self.present(alert, animated: true, completion: nil)
        }
        let menu = UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [editMenu, deleteMenu])
        sender.menu = menu
        sender.showsMenuAsPrimaryAction = true
    }
    
    @objc func button2Tapped(_ sender: UIButton){
        print(checkArray)
        if checkArray[sender.tag] == false{
            checkArray[sender.tag] = true
            sender.setImage(checked, for: .normal)
            if checkArray.allSatisfy({$0 == true}) == true{
                print("allChecked")
                let alert = UIAlertController(
                    title: "You are ready!",
                    message: "Let's go!",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(
                    title: "OK",
                    style: .default,
                    handler: {action in
                    }
                ))
                present(alert, animated: true, completion: nil)
            }
        } else if checkArray[sender.tag] == true {
            checkArray[sender.tag] = false
            sender.setImage(unchecked, for: .normal)
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
