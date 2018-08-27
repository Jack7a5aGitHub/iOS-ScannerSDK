//
//  CardCollectionCell.swift
//  LoadScannerDataSample
//
//  Created by Jack Wong on 2018/08/27.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

import UIKit

enum CellType {
    case normal
    case delete
}

class CardCollectionCell: UICollectionViewCell {

    @IBOutlet weak var cardImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static var identifier: String {
        return self.className
    }
    
    static var nibName: String {
        return self.className
    }
    
    var fileName: String? {
        didSet{
            guard let cardFilePath = fileName,
                let image = UIImage(contentsOfFile: cardFilePath),
                let cgImage = image.cgImage  else {
                    return
            }
            cardImageView.image = image
                //UIImage(cgImage: cgImage, scale: image.scale, orientation: .right)
            
        }
    }
}
