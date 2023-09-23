//
//  ItemTableViewCell.swift
//  Preparing
//
//  Created by 大沼朝陽 on 2023/09/18.
//

import UIKit
import RealmSwift

class ItemTableViewCell: UITableViewCell {
    
    let realm = try! Realm()
    var items: [Item] = []
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var checkedButton: UIButton!
    
    var unchecked: UIImage = UIImage(named: "checkbox")!
    var checked: UIImage = UIImage(named: "checkbox1")!
    
    var flg = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        checkedButton.setImage(unchecked, for: UIControl.State())
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(title: String){
        titleLabel.text = title
    }
    
    @IBAction func tappedButton(_ sender: Any) {
        if flg {
            checkedButton.setImage(unchecked, for: UIControl.State())
            flg = false
            print("false")
        } else {
            checkedButton.setImage(checked, for: UIControl.State())
            flg = true
            print("true")
        }
    }
    
}
