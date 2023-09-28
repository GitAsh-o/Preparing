//
//  NewEventViewController.swift
//  Preparing
//
//  Created by 大沼朝陽 on 2023/09/16.
//

import UIKit
import RealmSwift

class NewEventViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var purple: UIButton!
    @IBOutlet var red: UIButton!
    @IBOutlet var yellow: UIButton!
    @IBOutlet var green: UIButton!
    @IBOutlet var blue: UIButton!
    @IBOutlet var glay: UIButton!
    
    let realm = try! Realm()
    let event = Event()
    
    var viewNum: Int!
    var thisEvent: Event!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "FFEED4")
        titleTextField.delegate  = self
        event.color = "red"
        if viewNum == 2{
            titleTextField.text = thisEvent.title
        }
        doneButton.layer.cornerRadius = 25
        doneButton.layer.borderColor = UIColor.darkGray.cgColor
        doneButton.layer.borderWidth = 1.0
        purple.layer.cornerRadius = 15
        purple.backgroundColor = UIColor(hex: "DDBCE9")
        red.layer.cornerRadius = 15
        red.backgroundColor = UIColor(hex: "EFC0C0")
        yellow.layer.cornerRadius = 15
        yellow.backgroundColor = UIColor(hex: "EBEEBC")
        green.layer.cornerRadius = 15
        green.backgroundColor = UIColor(hex: "C4E7B7")
        blue.layer.cornerRadius = 15
        blue.backgroundColor = UIColor(hex: "B6C0E7")
        glay.layer.cornerRadius = 15
        glay.backgroundColor = UIColor(hex: "D3D3D3")
        // Do any additional setup after loading the view.
    }
    
    @IBAction private func didTapNumberButton(_ sender: UIButton){
        sender.layer.borderColor = UIColor.black.cgColor
        sender.layer.borderWidth = 1.0
        if viewNum == 1{
            print("make")
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
        }else if viewNum == 2{
            print("edit")
            try! realm.write{
                if sender.tag == 1{
                    thisEvent.color = "red"
                }else if sender.tag == 2{
                    thisEvent.color = "purple"
                }else if sender.tag == 3{
                    thisEvent.color = "blue"
                }else if sender.tag == 4{
                    thisEvent.color = "green"
                }else if sender.tag == 5{
                    thisEvent.color = "yellow"
                }else if sender.tag == 6{
                    thisEvent.color = "glay"
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            sender.layer.borderColor = UIColor.clear.cgColor
            sender.layer.borderWidth = 0.0
        }
    }
    
    @IBAction func save(){
        if titleTextField.text?.isEmpty == false{
            if viewNum == 1{
                event.title = titleTextField.text ?? ""
                createEvent(event: event)
                let preNC = self.presentingViewController as! UINavigationController
                let preVC = preNC.viewControllers[preNC.viewControllers.count - 1] as! EventViewController
                preVC.reload()
                
                self.dismiss(animated: true)
            }else if viewNum == 2{
                try! realm.write{
                    thisEvent.title = titleTextField.text ?? ""
                }
                let preNC = self.presentingViewController as! UINavigationController
                let preVC = preNC.viewControllers[preNC.viewControllers.count - 1] as! EventViewController
                preVC.reload()
                self.dismiss(animated: true)
            }
        }
    }
    
    func createEvent(event: Event){
        try! realm.write {
            realm.add(event)
        }
    }
    
    func textFieldShouldReturn(_ titleTextField: UITextField) -> Bool {
            titleTextField.resignFirstResponder()
            return true
    }
    
    @IBAction func back(){
        self.dismiss(animated: true)
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
