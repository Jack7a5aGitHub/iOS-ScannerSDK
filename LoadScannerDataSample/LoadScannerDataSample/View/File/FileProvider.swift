//
//  FileProvider.swift
//  LoadScannerDataSample
//
//  Created by Jack Wong on 2018/08/20.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

import UIKit

final class FileProvider: NSObject {
    var fileList = [Card]()
    
    func fetchFileList(files: [Card]) {
        self.fileList = files
    }
}

extension FileProvider: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FileCell.identifier, for: indexPath) as? FileCell else {
            fatalError("no cell")
        }
        
        if indexPath.section == 0 {
            cell.fileName = fileList[indexPath.row].front
        } else {
             cell.fileName = fileList[indexPath.row].back
        }
        return cell 
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "表"
        } else {
            return "裏"
        }
    }
}
