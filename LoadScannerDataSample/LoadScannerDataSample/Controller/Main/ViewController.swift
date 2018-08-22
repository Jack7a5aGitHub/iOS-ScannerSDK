//
//  ViewController.swift
//  LoadScannerDataSample
//
//  Created by Jack Wong on 2018/08/07.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

import UIKit

enum ConnectionStatus: Int {
    case Connecting
    case Connected
    case Disconnecting
    case Disconnected
    
    var status: String {
        switch self {
        case .Connected:
            return "Connecting"
        case .Connecting:
            return "Connected"
        case .Disconnecting:
            return "Disconnecting"
        case .Disconnected:
            return "Disconnected"
        }
    }
}

final class ViewController: UIViewController {
    
    // MARK: - Properties
    private let deviceControl = DeviceControl()
    private var arrSSSDKFiles = [String]()
    private var deviceArray = [String]()
    private var deviceName = ""
    private let deviceProvider = DeviceProvider()
    private var status = 0
    // MARK: - IBOutlet
    @IBOutlet weak var scannerList: UITableView!
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // JPEG format Setting
        SSSDKScanSettings.shared().fileFormat = 0
        deviceControl.delegate = self
        scanButton.isEnabled = false
        refreshScannerList(needAutoConnect: false)
        setupDeviceTable()
        statusLabel.text = "Not Connected"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadSSSDKFileList()
    }
    
    // MARK: - IBAction
    @IBAction func transToFileCollectionVC(_ sender: Any) {
        let fileVC = FileViewController.make(files: arrSSSDKFiles)
        navigationController?.pushViewController(fileVC, animated: true)
    }
    
    private func deviceConnected(deviceName: String) {
        print("device Enable, you can scan now")
        scanButton.isEnabled = true
        
    }
    
    private func setupDeviceTable() {
        scannerList.delegate = self
        scannerList.dataSource = deviceProvider
    }
    private func refreshScannerList(deviceArray: [String]) {
        self.deviceArray = deviceArray
        deviceProvider.getDeviceList(devices: self.deviceArray)
        self.scannerList.reloadData()
    }
    @IBAction func refreshAction(_ sender: Any) {
        deviceArray.removeAll()
        scannerList.reloadData()
        refreshScannerList(needAutoConnect: false)
        print("refresh")
    }
    @IBAction func scan(_ sender: Any) {
 
        if Int(deviceControl.device.scanStatus.rawValue) == 3 {
            self.deviceControl.scanAction(SSSDKScanSettings.shared().settingsDictionary())
            
            status = Int(deviceControl.device.scanStatus.rawValue)
            statusLabel.text = ConnectionStatus.init(rawValue: status)?.status
        } else {
            connectDeviceAndStartScan()
        }
        print("scan Status", deviceControl.device.scanStatus)
    }
    @IBAction func disconnect(_ sender: Any) {
        self.deviceControl.disconnectScanner()
    }
    @IBAction func scanAction(_ sender: Any) {
        
    }
}

extension ViewController: DeviceCtrlDelegate {
    func didDisconnectToTheDevice() {
        print("disconnected gogogo")
        status = Int(deviceControl.device.scanStatus.rawValue)
        statusLabel.text = ConnectionStatus.init(rawValue: status)?.status
    }
    
    private func refreshScannerList(needAutoConnect: Bool) -> Error? {
        
        let error = self.deviceControl.searchDevices { deviceList in
            
            var deviceArray = [String]()
            
            for device in deviceList! {
                deviceArray.append((device as! PFUDevice).deviceName)
            }
            self.refreshScannerList(deviceArray:deviceArray)
        }
        return error
    }
    
    func device(_ deviceInfo: PFUSSDevice!, connectSuccessfully error: Error!) {
        if error == nil {
            self.deviceControl.scanAction(SSSDKScanSettings.shared().settingsDictionary())
            
            status = Int(deviceControl.device.scanStatus.rawValue)
            statusLabel.text = ConnectionStatus.init(rawValue: status)?.status
        } else {
            
            let alert = SSSDKAlert.sharedAlertController()
            if (error.localizedDescription == String(ERR_WRONG_PASSWORD.rawValue) ||
                error.localizedDescription == String(ERR_INVALID_PASSWORD.rawValue) ) {
                alert?.show(SSSDKScanAlertTypeWrongPassword, errorCode: 0, withCallBack: { buttonIndex in
                    if buttonIndex == BUTTON_INDEX_DEFAULT {
                        var textField = UITextField()
                        textField = (alert?.alertController as AnyObject).textField(at: 0)!
                        self.deviceControl.connect(withPassword: textField.text!)
                    }
                })
            } else {
                alert?.show(SSSDKScanAlertTypeConnectError, errorCode: 0, withCallBack: { buttonIndex in
                    self.refreshScannerList(needAutoConnect:false)
                })
            }
        }
    }
    
    func connectDeviceAndStartScan() {
        let error = self.deviceControl.connectScanner() as NSError?
        
        if error != nil {
            SSSDKAlert.sharedAlertController().show(SSSDKScanAlertTypeConnectError, errorCode: (error?.code)!) { buttonIndex in
            }
        }
        status = Int(deviceControl.device.scanStatus.rawValue)
        statusLabel.text = ConnectionStatus.init(rawValue: status)?.status
    }
    
    func connectDevice(with indexPath: IndexPath!) {
        self.deviceControl.connectDevice(with: indexPath.row)
        self.deviceConnected(deviceName: deviceControl.device.deviceName)
        deviceName = deviceControl.device.deviceName
    }
    
    func doDisconnection(_ indexPath: IndexPath!) {
        self.deviceControl.device.disconnect()
        print("Disconnected")
        //scanButton.isEnabled = false
    }
    
    func continueScan(_ scanSetting: [AnyHashable : Any]!) {
        self.deviceControl.continueScanAction(scanSetting)
    }
    
    func showScanAlert() {
        SSSDKAlert.sharedAlertController().show(SSSDKScanAlertTypeScanning, errorCode: 0, withCallBack: nil)
    }
    
    func scanFinish() {
        
        SSSDKAlert.sharedAlertController().dismiss(Int(BUTTON_INDEX_CANCEL.rawValue))
        self.deviceControl.finishScanAction()
        status = Int(deviceControl.device.scanStatus.rawValue)
        statusLabel.text = ConnectionStatus.init(rawValue: status)?.status
    }
    
    func showScanErrorOccurWithErrorCode(_ errorCode: Int) {
        SSSDKAlert.sharedAlertController().dismiss(Int(BUTTON_INDEX_CANCEL.rawValue))
        SSSDKAlert.sharedAlertController().show(SSSDKScanAlertTypeError, errorCode: errorCode, withCallBack: nil)
        //error keep exists so cant scan again
    }
    private func reloadSSSDKFileList() {
        arrSSSDKFiles = []
        let saveFolder = SSSDKScanSettings.shared().saveFolderFullPath()
        guard let filesPath = SSSDKUtil.getFilesInDirectory(saveFolder, allowedFileSuffixes: ["jpg", "jpeg", "pdf"], createDirectories: true) as? [String] else {
            return
        }
        arrSSSDKFiles = filesPath
    }
    
    //    private func removeNewestScanFile() {
    //        let fileManager = FileManager.default
    //        try? fileManager.removeItem(atPath: self.arrSSSDKFiles.lastObject as! String)
    //        arrSSSDKFiles.removeLastObject()
    //        if SSSDKScanSettings.shared().fileFormat == Int(PFUFileFormatOptionJpeg.rawValue) {
    //            try? fileManager.removeItem(atPath: arrSSSDKFiles.lastObject as! String)
    //            arrSSSDKFiles.removeLastObject()
    //        }
    //
    //    }
    
    func showMultiFeedOccur() {
        self.scanFinish()
        SSSDKAlert.sharedAlertController().show(SSSDKScanAlertTypeMultiFeed, errorCode: 0) { buttonIndex in
            if buttonIndex == BUTTON_INDEX_DEFAULT {
                // self.removeNewestScanFile()
            }
        }
    }
    
    func deliverScanFile(_ pageInfo: Any!) {
        print("files", pageInfo)
        guard let path = pageInfo as? String else {
            return
        }
        arrSSSDKFiles.append(path)
        
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let cell = tableView.cellForRow(at: indexPath) as? CustomCell else {
            fatalError()
        }
        connectDevice(with: indexPath)
        return indexPath
    }
}
