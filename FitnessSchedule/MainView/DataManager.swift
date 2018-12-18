//
//  DataManager.swift
//  FitnessSchedule
//
//  Created by Nazar Prysiazhnyi on 12/18/18.
//  Copyright © 2018 Nazar Prysiazhnyi. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    var arrayOfSchedule: [SchedulerElement] = []{
        didSet{
            let notification = Notification.Name("UpdateTableView")
            NotificationCenter.default.post(name: notification, object: nil)
        }
    }
    
    var tempArray: Scheduler = []
    
    var filter: Int? {
        didSet{
            if filter == 0 {
                arrayOfSchedule = tempArray
            } else {
                arrayOfSchedule = tempArray.filter{
                    $0.weekDay.rawValue == filter
                }
            }
            let notification = Notification.Name("UpdateTableView")
            NotificationCenter.default.post(name: notification, object: nil)
        }
    }     
}
