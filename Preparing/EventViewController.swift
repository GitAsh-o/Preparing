//
//  ViewController.swift
//  Preparing
//
//  Created by 大沼朝陽 on 2023/09/16.
//

import UIKit
import RealmSwift
import SwiftUI

class EventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var collectionView: UICollectionView!
    
    let realm = try! Realm()
    var events: [Event] = []
    var items: [Item] = []
    var selectedEvent: Event? = nil
    var eventNum: Int!
    var shareArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "FFEED4")
        tableView.backgroundColor = UIColor(hex: "FFEED4")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "EventCell")
        events = readEvents()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        events = readEvents()
        tableView.reloadData()
        let itemView = storyboard?.instantiateViewController(identifier: "ItemView") as! ItemViewController
        self.items = itemView.items
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventTableViewCell
        let event: Event = events[indexPath.row]
        cell.setCell(title: event.title, color: event.color)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        let button = UIButton()
        
        button.frame = CGRect(x: tableView.frame.width * 0.8, y: 0, width: tableView.frame.width * 0.2, height: (cell.frame.height))
        button.setTitle("･･･", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.tag = indexPath.row
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        cell.addSubview(button)
        
        cell.mainBackground.layer.cornerRadius = 8
        cell.mainBackground.layer.masksToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        selectedEvent = events[indexPath.row]
        self.performSegue(withIdentifier: "toItemView", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let marginView = UIView()
        marginView.backgroundColor = .clear
        return marginView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
    
    func readEvents() -> [Event]{
        return Array(realm.objects(Event.self))
    }
    
    func reload(){
        events = readEvents()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toItemView" {
            let itemViewController = segue.destination as! ItemViewController
            itemViewController.selectedEvent = self.selectedEvent!
        } else if segue.identifier == "toNewEventView"{
            let newEventView = segue.destination as! NewEventViewController
            newEventView.viewNum = 1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func buttonTapped(_ sender: UIButton){
        let storyboard: UIStoryboard = self.storyboard!
        let editMenu = UIAction(title: "編集", image: nil) { (action) in
            print("編集")
            let nextView = storyboard.instantiateViewController(identifier: "NewEventView") as! NewEventViewController
            nextView.viewNum = 2
            nextView.thisEvent = self.events[sender.tag]
            self.present(nextView, animated: true, completion: nil)
        }
        let shareMenu = UIAction(title:"共有", image: nil) { [self] (action) in
            print("共有")
            print(self.realm.objects(Item.self).filter("event == %@", self.events[sender.tag]))
            self.items.forEach{ item in
                self.shareArray.append(item.title)
            }
            print(self.shareArray)
            let shareText = "\(self.shareArray)"
            let activityItems = [shareText] as [Any]
            let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }
        let deleteMenu = UIAction(title: "削除", image: nil) { (action) in
            print("削除")
            let alert = UIAlertController(
                title: "イベントを削除",
                message: "カバンの中身も全て削除されます",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(
                title: "削除",
                style: .default,
                handler: {action in
                    print("deleteCell")
                    try! self.realm.write{
                        self.realm.delete(self.events[sender.tag])
                    }
                    self.events.remove(at: sender.tag)
                    self.tableView.reloadData()
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
        let menu = UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [editMenu, shareMenu, deleteMenu])
        sender.menu = menu
        sender.showsMenuAsPrimaryAction = true
    }
}

