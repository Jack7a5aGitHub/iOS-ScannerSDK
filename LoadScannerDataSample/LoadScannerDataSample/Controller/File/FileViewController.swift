//
//  FileViewController.swift
//  LoadScannerDataSample
//
//  Created by Jack Wong on 2018/08/20.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

import UIKit

final class FileViewController: UIViewController {
    
    // MARK: - Properties
    private let fileProvider = FileProvider()
    private var docInteractionController = UIDocumentInteractionController()
    var arrSSSDKFiles = [String]()
    // MARK: - IBOutlet
    @IBOutlet weak var fileListTableView: UITableView!
    
    // MARK: - Factory
    class func make(files: [String]) -> FileViewController {
        
        let vcName = FileViewController.className
        guard let fileVC = UIStoryboard(name: vcName, bundle: nil).instantiateViewController(withIdentifier: vcName) as? FileViewController else {
            fatalError("no file VC")
        }
        fileVC.arrSSSDKFiles = files
        
        return fileVC
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFileTable()
    }
    
}

// MARK: - Private func
extension FileViewController {
    private func setupFileTable() {
        fileListTableView.delegate = self
        fileListTableView.dataSource = fileProvider
        print("filesFetched", arrSSSDKFiles)
        fileProvider.fetchFileList(files: arrSSSDKFiles)
    }
    private func setupDocumentControllerWithPath(path: String) {
        let url = URL(fileURLWithPath: path)
        docInteractionController = UIDocumentInteractionController.init(url: url)
        docInteractionController.delegate = self
        docInteractionController.presentPreview(animated: true)
    }
}

// MARK: - UIDocumentInteractionControllerDelegate
extension FileViewController: UIDocumentInteractionControllerDelegate {
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
}

// MARK: - UITableViewDelegate
extension FileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? FileCell,
              let path = cell.fileName  else {
            return
        }
        setupDocumentControllerWithPath(path: path)
    }
}
