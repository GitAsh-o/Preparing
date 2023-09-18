//
//  EventTableViewCell.swift
//  Preparing
//
//  Created by 大沼朝陽 on 2023/09/16.
//

import UIKit
import RealmSwift

/*protocol EventTableViewCellDelegate: AnyObject {
    func deleteCell(in cell: EventTableViewCell)
}*/

class EventTableViewCell: UITableViewCell {
    
    let realm = try! Realm()
    var events: [Event] = []
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var backColor: UIColor!
    @IBOutlet weak var button: UIButton!
    
    /*weak var delegate: EventTableViewCellDelegate?*/

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(title: String, color: String){
        titleLabel.text = title
        if color == "red"{
            backColor = UIColor(hex: "EFC0C0")
        }else if color == "purple"{
            backColor = UIColor(hex: "DDBCE9")
        }else if color == "blue"{
            backColor = UIColor(hex: "B6C0E7")
        }else if color == "green"{
            backColor = UIColor(hex: "C4E7B7")
        }else if color == "yellow"{
            backColor = UIColor(hex: "EBEEBC")
        }else if color == "glay"{
            backColor = UIColor(hex: "EFEFEF")
        }
        self.backgroundColor = backColor
    }
    
    /*@IBAction func setupButton(){
        let editMenu = UIAction(title: "編集", image: nil) { (action) in
            print("編集")
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
                    self.delegate?.deleteCell(in: self)
                }
            ))
            alert.addAction(UIAlertAction(
                title: "キャンセル",
                style: .default,
                handler: {action in
                }
            ))
            if let viewController = self.window?.rootViewController {
                viewController.present(alert, animated: true, completion: nil)
            }
        }
        let menu = UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [editMenu, deleteMenu])
        button.menu = menu
        button.showsMenuAsPrimaryAction = true
    }*/
}

