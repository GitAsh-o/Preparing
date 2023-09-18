//
//  NewEventViewController.swift
//  Preparing
//
//  Created by 大沼朝陽 on 2023/09/16.
//

import UIKit
import RealmSwift

class NewEventViewController: UIViewController {
    
    @IBOutlet var titleTextField: UITextField!
    
    let realm = try! Realm()
    let event = Event()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction private func didTapNumberButton(_ sender: UIButton){
        if sender.tag == 1{
            event.color = "red"
        }else if sender.tag == 2{
            event.color = "purple"
        }else if sender.tag == 3{
            event.color = "blue"
        }else if sender.tag == 4{
            event.color = "green"
        }else if sender.tag == 5{
            event.color = "yellow"
        }else if sender.tag == 6{
            event.color = "glay"
        }
    }
    
    @IBAction func save(){
        event.title = titleTextField.text ?? ""
        createEvent(event: event)
        
        let preNC = self.presentingViewController as! UINavigationController
        let preVC = preNC.viewControllers[preNC.viewControllers.count - 1] as! EventViewController
        preVC.reload()
        
        self.dismiss(animated: true)
    }
    
    func createEvent(event: Event){
        try! realm.write {
            realm.add(event)
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
