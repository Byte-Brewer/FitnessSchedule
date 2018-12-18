//
//  MainController.swift
//  FitnessSchedule
//
//  Created by Nazar Prysiazhnyi on 12/11/18.
//  Copyright © 2018 Nazar Prysiazhnyi. All rights reserved.
//

import UIKit

class MainController: UITableViewController {
    
    @IBOutlet var dataProvider: DataProvider!
    
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSchedule(hall: 1)
        addBackgroundView()
        
        tableView.register(UINib(nibName: "MainTVCell", bundle: nil), forCellReuseIdentifier: "MainTVC")
        tableView.register(UINib(nibName: "DaysTVCell", bundle: nil), forCellReuseIdentifier: "DaysTVC")
        tableView.tableFooterView = UIView()
        
        self.navigationController?.navigationBar.barTintColor = .mainBarColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("UpdateTableView"), object: nil, queue: nil, using: updateTableView)
        NotificationCenter.default.addObserver(forName: NSNotification.Name("GoToDetailVC"), object: nil, queue: nil, using: goToDetailVC)
    
    }
    
    // set activityIndicator
    private func showActivityIndicator() {
        UIApplication.shared.beginIgnoringInteractionEvents()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        self.activityIndicator.color = UIColor.marigold
        self.tableView.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()
    }
    
    private func hideActivityIndicator() {
        UIApplication.shared.endIgnoringInteractionEvents()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        self.activityIndicator.stopAnimating()
    }
    
    fileprivate func addBackgroundView() {
        let view = UIView(frame: CGRect(origin: CGPoint.zero, size: self.tableView.frame.size))
        let imageView = UIImageView(frame: view.frame)
        imageView.image = UIImage(named: "gympickup")
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        tableView.backgroundView = view
    }
    
    private func alert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func updateTableView(notification: Notification) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func goToDetailVC(notification: Notification) {
        if let itemIndex = notification.userInfo!["itemIndex"] as? Int {
            let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
            detailVC.scheduleElement = self.dataProvider.dataManager.arrayOfSchedule[itemIndex - 1]
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    private func getSchedule(hall: Int) {
        self.showActivityIndicator()
        NetworkManager.shared.mainRequest(hall: hall) { (responseAPI) in
            defer { self.hideActivityIndicator() }
            let schedule = responseAPI.parseJson(type: Scheduler.self)
            guard responseAPI.status == "OK" else {
                self.alert(title: "Error", message: responseAPI.status)
                return
            }
            if (schedule?.count)! > 0 {
                self.dataProvider.dataManager.arrayOfSchedule = schedule!
                self.dataProvider.dataManager.tempArray = schedule!
            }
        }
    }
}

