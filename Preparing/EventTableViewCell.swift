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
    @IBOutlet var mainBackground: UIView!

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
            mainBackground.backgroundColor = UIColor(hex: "EFC0C0")
        }else if color == "purple"{
            mainBackground.backgroundColor = UIColor(hex: "DDBCE9")
        }else if color == "blue"{
            mainBackground.backgroundColor = UIColor(hex: "B6C0E7")
        }else if color == "green"{
            mainBackground.backgroundColor = UIColor(hex: "C4E7B7")
        }else if color == "yellow"{
            mainBackground.backgroundColor = UIColor(hex: "EBEEBC")
        }else if color == "glay"{
            mainBackground.backgroundColor = UIColor(hex: "D3D3D3")
        }
        self.backgroundColor = UIColor(hex: "FFEED4")
        mainBackground.layer.borderWidth = 1.0
        mainBackground.layer.borderColor = UIColor(hex: "606060").cgColor
    }
    
}

