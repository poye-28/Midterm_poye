//
//  DetailTableViewCell.swift
//  Midterm
//
//  Created by POYEH on 2020/1/17.
//  Copyright © 2020 POYEH. All rights reserved.
//

import UIKit
import Kingfisher

class DetailTableViewCell: UITableViewCell {
    
    var status = false

    var toggleHandler: ((Bool) -> Void)?
    
    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBAction func toggleAction(_ sender: UIButton) {
        
        toggleHandler?(status)
        
        status = !status
        
    }
    
    
}
