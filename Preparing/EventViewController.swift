//
//  ViewController.swift
//  Preparing
//
//  Created by 大沼朝陽 on 2023/09/16.
//

import UIKit
import RealmSwift

class EventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate/*, EventTableViewCellDelegate*/ {
    
    @IBOutlet var tableView: UITableView!
    
    let realm = try! Realm()
    var events: [Event] = []
    var selectedEvent: Event? = nil
    
    var indexPath: IndexPath!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "EventCell")
        events = readEvents()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        events = readEvents()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventTableViewCell
        let event: Event = events[indexPath.row]
        cell.setCell(title: event.title, color: event.color)
        /*cell.delegate = self*/
        
        let button = UIButton()
        
        button.frame = CGRect(x: tableView.frame.width * 0.8, y: 0, width: tableView.frame.width * 0.2, height: (cell.frame.height))
        button.setTitle("･･･", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button.tag = indexPath.row
        cell.addSubview(button)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        selectedEvent = events[indexPath.row]
        self.performSegue(withIdentifier: "toItemView", sender: nil)
    }
    
    func readEvents() -> [Event]{
        return Array(realm.objects(Event.self))
    }
    
    /*func deleteCell(in cell: EventTableViewCell) {
        print("Cellを削除しました")
        if let indexPath = tableView.indexPath(for: cell) {
            try! realm.write{
                realm.delete(events[indexPath.row])
            }
            events.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }*/
    
    func reload(){
        events = readEvents()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toItemView" {
            let itemViewController = segue.destination as! ItemViewController
            itemViewController.selectedEvent = self.selectedEvent!
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton){
        let editMenu = UIAction(title: "編集", image: nil) { (action) in
            print("編集")
            let storyboard: UIStoryboard = self.storyboard!
            let nextView = storyboard.instantiateViewController(identifier: "NewEventView") as! NewEventViewController
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
                    if let indexPath = tableView.indexPath {
                        try! realm.write{
                            realm.delete(events[sender.tag])
                        }
                        events.remove(at: sender.tag)
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                        tableView.reloadData()
                    }
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
}
