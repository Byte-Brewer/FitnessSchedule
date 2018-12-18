//
//  DataProvider.swift
//  FitnessSchedule
//
//  Created by Nazar Prysiazhnyi on 12/18/18.
//  Copyright © 2018 Nazar Prysiazhnyi. All rights reserved.
//

import UIKit

class DataProvider: NSObject {
    var dataManager = DataManager()
}

extension DataProvider: UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.arrayOfSchedule.count + 1
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DaysTVC", for: indexPath) as! DaysTVCell
            cell.daysArray.filter{$0.tag == dataManager.filter ?? 0}.first?.backgroundColor = UIColor.marigold
            cell.callback = { dayIndex in
                self.dataManager.filter = dayIndex
            }
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainTVC", for: indexPath) as! MainTVCell
            let schedule = dataManager.arrayOfSchedule[indexPath.row - 1]
            cell.setup(schedule: schedule)
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor.marigold
            cell.selectedBackgroundView = backgroundView
            return cell
        }
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 50
        } else {
            return 190.0
        }
    }
}

extension DataProvider: UITableViewDelegate {
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row != 0 {
            NotificationCenter.default.post(name: NSNotification.Name("GoToDetailVC"), object: nil, userInfo: ["itemIndex" : indexPath.row])
        }
    }
}
