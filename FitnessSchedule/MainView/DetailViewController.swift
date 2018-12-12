//
//  DetailViewController.swift
//  FitnessSchedule
//
//  Created by Nazar Prysiazhnyi on 12/12/18.
//  Copyright © 2018 Nazar Prysiazhnyi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var scheduleElement: SchedulerElement?
    
    @IBOutlet weak var teacherImage: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var trainerName: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var group: UILabel!
    @IBOutlet weak var describe: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        self.teacherImage.layer.cornerRadius = 10.0
        self.teacherImage.clipsToBounds = true
    }
    
    private func setUp(){
        guard let schedule = scheduleElement else { return }
        self.navigationItem.title = schedule.weekDay.introduce()
        self.time.text = "\(schedule.startTime) - \(schedule.endTime)"
        self.trainerName.text = schedule.teacher
        self.name.text = schedule.name
        self.group.text = schedule.place.rawValue
        self.describe.text = schedule.description
        self.position.text = schedule.teacherV2.position.rawValue
        NetworkManager.shared.getImage(imageID: schedule.teacherV2.imageURL) { (image) in
            DispatchQueue.main.async {
                self.teacherImage.image = image
            }
        }
    }
    
}
