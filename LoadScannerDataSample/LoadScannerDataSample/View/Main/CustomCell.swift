//
//  CustomCell.swift
//  LoadScannerDataSample
//
//  Created by Jack Wong on 2018/08/08.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBOutlet weak var deviceLabel: UILabel!
    
    var deviceName: String? {
        didSet {
            deviceLabel.text = deviceName
        }
    }
}
