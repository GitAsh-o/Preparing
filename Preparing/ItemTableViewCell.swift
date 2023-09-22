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
    @IBOutlet weak var button: UIButton!

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
    
}
