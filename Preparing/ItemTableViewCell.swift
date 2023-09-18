//
//  ItemTableViewCell.swift
//  Preparing
//
//  Created by 大沼朝陽 on 2023/09/18.
//

import UIKit
import RealmSwift

protocol ItemTableViewCellDelegate: AnyObject {
    func deleteCell(in cell: ItemTableViewCell)
}

class ItemTableViewCell: UITableViewCell {
    
    let realm = try! Realm()
    var items: [Item] = []
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    weak var delegate: ItemTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(title: String){
        titleLabel.text = title
    }
    
    @IBAction func setupButton(){
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
                title: "delete",
                style: .default,
                handler: { action in
                    self.delegate?.deleteCell(in: self)
                }
            ))
            if let viewController = self.window?.rootViewController {
                viewController.present(alert, animated: true, completion: nil)
            }
        }
        let menu = UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [editMenu, deleteMenu])
        button.menu = menu
        button.showsMenuAsPrimaryAction = true
    }
    
}
