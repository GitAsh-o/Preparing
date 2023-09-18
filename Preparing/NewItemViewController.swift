//
//  NewItemViewController.swift
//  Preparing
//
//  Created by 大沼朝陽 on 2023/09/17.
//

import UIKit
import RealmSwift

class NewItemViewController: UIViewController {
    
    @IBOutlet var titleTextField: UITextField!
    
    let realm = try! Realm()
    var event: Event!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func save(){
        let item = Item()
        item.title = titleTextField.text ?? ""
        item.event = event
        createItem(item: item)
        
        self.dismiss(animated: true)
    }
    
    func createItem(item: Item){
        try! realm.write{
            realm.add(item)
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
