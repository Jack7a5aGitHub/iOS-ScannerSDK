//
//  FileCell.swift
//  LoadScannerDataSample
//
//  Created by Jack Wong on 2018/08/20.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

import UIKit

final class FileCell: UITableViewCell {
    
    @IBOutlet weak var fileNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    static var identifier: String {
        return self.className
    }
    
    var fileName: String? {
        didSet{
            fileNameLabel.text = fileName
        }
    }
}
