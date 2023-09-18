//
//  ItemViewController.swift
//  Preparing
//
//  Created by 大沼朝陽 on 2023/09/17.
//

import UIKit
import RealmSwift

class ItemViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ItemTableViewCellDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    let realm = try! Realm()
    var items: [Item] = []
    var selectedEvent: Event!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        navigationItem.title = selectedEvent.title
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        items = readItems()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
        let item: Item = items[indexPath.row]
        cell.setCell(title: item.title)
        cell.delegate = self
        
        return cell
    }
    
    func readItems() -> [Item]{
        return Array(realm.objects(Item.self).filter("event == %@", selectedEvent!))
    }
    
    func deleteCell(in cell: ItemTableViewCell) {
        print("Cellを削除しました")
        if let indexPath = tableView.indexPath(for: cell) {
            try! realm.write{
                realm.delete(items[indexPath.row])
            }
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNewItemView" {
            let newItemViewController = segue.destination as! NewItemViewController
            newItemViewController.event = self.selectedEvent
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
