//
//  PreviewViewController.swift
//  LoadScannerDataSample
//
//  Created by Jack Wong on 2018/08/27.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

import UIKit
import QuickLook

final class PreviewViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var normalToolBar: UIToolbar!
    @IBOutlet weak var editToolBar: UIToolbar!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    // MARK: - Properties
    var filePath = ""
    private var editFlag = false
    // MARK: - Factory
    class func make(filePath: String) -> PreviewViewController {
        
        let vcName = PreviewViewController.className
        guard let previewVC = UIStoryboard(name: vcName, bundle: nil).instantiateViewController(withIdentifier: vcName) as? PreviewViewController else {
            fatalError("no file VC")
        }
        previewVC.filePath = filePath
        
        return previewVC
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        editToolBar.isHidden = true
        navigationItem.hidesBackButton = true
        previewImageView.image = UIImage(contentsOfFile: filePath)
    }
    @IBAction func editAction(_ sender: UIBarButtonItem) {
        if editFlag == false {
        normalToolBar.isHidden = true
        editToolBar.isHidden = false
        editButton.title = "Done"
        cancelButton.title = "Cancel"
        editFlag = true
        } else {
        editButton.title = "Edit"
        normalToolBar.isHidden = false
        editToolBar.isHidden = true
        cancelButton.title = "Back"
        editFlag = false
        }
    }
    @IBAction func backOrCancelAction(_ sender: UIBarButtonItem) {
        if editFlag == false {
        navigationController?.popViewController(animated: true)
        } else {
        editButton.title = "Edit"
        normalToolBar.isHidden = false
        editToolBar.isHidden = true
        cancelButton.title = "Back"
        editFlag = false
        }
    }
    
    @IBAction func leftRotation(_ sender: UIBarButtonItem) {
        let image = UIImage(contentsOfFile: filePath)
        previewImageView.image = UIImage(cgImage: (image?.cgImage!)!, scale: (image?.scale)!, orientation: .left)
    }
    
}
