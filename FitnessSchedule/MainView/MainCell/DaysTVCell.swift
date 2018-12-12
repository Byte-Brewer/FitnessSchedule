//
//  DaysTVCell.swift
//  FitnessSchedule
//
//  Created by Nazar Prysiazhnyi on 12/12/18.
//  Copyright © 2018 Nazar Prysiazhnyi. All rights reserved.
//

import UIKit

class DaysTVCell: UITableViewCell {

    @IBOutlet weak var daysSegment: UISegmentedControl!
    
    var callback: ((_ selectedDay:Int)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        daysSegment.tintColor = .black
        daysSegment.layer.cornerRadius = 3.0
        daysSegment.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func segmentedAction(_ sender: UISegmentedControl) {
        let selectedDayIndex = sender.selectedSegmentIndex
        self.callback!(selectedDayIndex)
    }
}
