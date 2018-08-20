//
//  DeviceProvider.swift
//  LoadScannerDataSample
//
//  Created by Jack Wong on 2018/08/20.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

import UIKit

final class DeviceProvider: NSObject {
    var deviceList = [String]()
    
    func getDeviceList(devices: [String]) {
        self.deviceList = devices
    }
}

extension DeviceProvider: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deviceList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomCell else {
            fatalError("no cell")
        }
        
        cell.deviceName = deviceList[indexPath.row]
        return cell
    }
}
