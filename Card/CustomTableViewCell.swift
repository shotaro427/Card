//
//  CustomTableViewCell.swift
//  Card
//
//  Created by 田内　翔太郎 on 2019/08/13.
//  Copyright © 2019 原田悠嗣. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    // 顔写真
    @IBOutlet weak var faceImage: UIImageView!
    // 名前
    @IBOutlet weak var nameLabel: UILabel!
    // 職業
    @IBOutlet weak var jobLabel: UILabel!
    // 出身
    @IBOutlet weak var townLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
