//
//  DaysTVCell.swift
//  FitnessSchedule
//
//  Created by Nazar Prysiazhnyi on 12/12/18.
//  Copyright © 2018 Nazar Prysiazhnyi. All rights reserved.
//

import UIKit

class DaysTVCell: UITableViewCell {
    
    @IBOutlet var daysArray: [UIButton]!
    
    var callback: ((_ selectedDay:Int)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        daysArray.forEach{$0.backgroundColor = UIColor.clear}
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func selectDayAction(_ sender: UIButton) {
        daysArray.forEach{$0.backgroundColor = UIColor.clear}
        let selectedDayIndex = sender.tag
        for day in daysArray {
            if day.tag == sender.tag {
                day.backgroundColor = UIColor.marigold
                self.callback!(selectedDayIndex)
            } 
        }
    }
}
