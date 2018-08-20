//
//  FileProvider.swift
//  LoadScannerDataSample
//
//  Created by Jack Wong on 2018/08/20.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

import UIKit

final class FileProvider: NSObject {
    var fileList = [String]()
    
    func fetchFileList(files: [String]) {
        self.fileList = files
    }
}

extension FileProvider: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FileCell.identifier, for: indexPath) as? FileCell else {
            fatalError("no cell")
        }
        cell.fileName = fileList[indexPath.row]
        return cell 
    }
}
