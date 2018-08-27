//
//  FileProvider.swift
//  LoadScannerDataSample
//
//  Created by Jack Wong on 2018/08/20.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

import UIKit
import QuickLook

final class FileProvider: NSObject {
    var fileList = [Card]()
    
    func fetchFileList(files: [Card]) {
        self.fileList = files
    }
}

extension FileProvider: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fileList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionCell.identifier, for: indexPath) as? CardCollectionCell else {
            fatalError("no cells")
        }
        cell.fileName = fileList[indexPath.item].front
        return cell
    }
}
