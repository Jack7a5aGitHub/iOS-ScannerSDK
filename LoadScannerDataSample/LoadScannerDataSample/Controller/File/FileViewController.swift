//
//  FileViewController.swift
//  LoadScannerDataSample
//
//  Created by Jack Wong on 2018/08/20.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

import UIKit
import QuickLook

struct Card {
    var front = ""
    var back = ""
}

final class FileViewController: UIViewController {
    
    // MARK: - Properties
    private let fileProvider = FileProvider()
    private var docInteractionController = UIDocumentInteractionController()
    private var frontList = [String]()
    private var backList = [String]()
    private var correctedFiles = [Card]()
    var arrSSSDKFiles = [String]()
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var cardsCollectionView: UICollectionView!
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
        setupCardCollection()
    }
    
}

// MARK: - Private func for CollectionView
extension FileViewController {
    private func setupCardCollection() {
        cardsCollectionView.delegate = self
        cardsCollectionView.dataSource = fileProvider
        for index in 0..<arrSSSDKFiles.count {
            if index % 2 == 0 {
                frontList.append(arrSSSDKFiles[index])
            } else {
                backList.append(arrSSSDKFiles[index])
            }
        }
        for index in 0..<frontList.count{
            correctedFiles.append(Card(front: frontList[index], back: backList[index]))
        }
        fileProvider.fetchFileList(files: correctedFiles)
        registerNib()
    }
    private func registerNib() {
        let cardCollectionCellNib = UINib(nibName: CardCollectionCell.nibName, bundle: nil)
        cardsCollectionView.register(cardCollectionCellNib, forCellWithReuseIdentifier: CardCollectionCell.identifier)
    }
    
}

// MARK: - Private func for read Documents file
extension FileViewController {
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

// MARK: - UICollectionViewDelegate
extension FileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionCell,
            let path = cell.fileName else {
                print("return")
                return
        }
        //let url = URL(fileURLWithPath: path)
        let previewVC = PreviewViewController.make(filePath: path)
        navigationController?.pushViewController(previewVC, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowlayout
extension FileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = cardsCollectionView.bounds.width
        let height = width * 3 / 4
        return CGSize(width: width, height: height)
    }
}
