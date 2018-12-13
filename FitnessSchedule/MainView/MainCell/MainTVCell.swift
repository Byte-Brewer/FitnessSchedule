//
//  MainTVCell.swift
//  FitnessSchedule
//
//  Created by Nazar Prysiazhnyi on 12/11/18.
//  Copyright © 2018 Nazar Prysiazhnyi. All rights reserved.
//

import UIKit

class MainTVCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var teacher: UILabel!
    @IBOutlet weak var colorBorder: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.colorBorder.layer.cornerRadius = 8
        self.colorBorder.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(schedule:SchedulerElement) {
        self.name.text = schedule.name
        self.place.text = schedule.place
        self.time.text = schedule.startTime 
        self.teacher.text = schedule.teacher
        self.colorBorder.backgroundColor = UIColor(hexString: schedule.color)
    }
}
