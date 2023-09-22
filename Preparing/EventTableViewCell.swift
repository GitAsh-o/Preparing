//
//  EventTableViewCell.swift
//  Preparing
//
//  Created by 大沼朝陽 on 2023/09/16.
//

import UIKit
import RealmSwift

class EventTableViewCell: UITableViewCell {
    
    let realm = try! Realm()
    var events: [Event] = []
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var backColor: UIColor!
    @IBOutlet weak var button: UIButton!

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
            backColor = UIColor(hex: "D3D3D3")
        }
        self.backgroundColor = backColor
    }
    
}

