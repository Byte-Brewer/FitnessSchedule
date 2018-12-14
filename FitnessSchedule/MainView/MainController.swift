//
//  MainController.swift
//  FitnessSchedule
//
//  Created by Nazar Prysiazhnyi on 12/11/18.
//  Copyright © 2018 Nazar Prysiazhnyi. All rights reserved.
//

import UIKit

class MainController: UITableViewController {
    
    var arrayOfSchedule: [SchedulerElement] = []{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
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
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
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
    }
    
     
    // MARK: tableViewDelegate, tableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfSchedule.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DaysTVC", for: indexPath) as! DaysTVCell
            cell.daysArray.filter{$0.tag == self.filter ?? 0}.first?.backgroundColor = UIColor.marigold
            cell.callback = { dayIndex in
                self.filter = dayIndex
            }
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainTVC", for: indexPath) as! MainTVCell
            let schedule = arrayOfSchedule[indexPath.row - 1]
            cell.setup(schedule: schedule)
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor.marigold
            cell.selectedBackgroundView = backgroundView
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 50
        } else {
            return 190.0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row != 0 {
            let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
            detailVC.scheduleElement = arrayOfSchedule[indexPath.row - 1]
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
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
    
    private func getSchedule(hall: Int) {
        self.showActivityIndicator()
        NetworkManager.shared.mainRequest(hall: hall) { (responseAPI) in
            defer { self.hideActivityIndicator() }
            guard responseAPI.status == "OK" else {
                self.alert(title: "Error", message: responseAPI.status)
                return }
            do {
                //here dataResponse received from a network request
                let decoder = JSONDecoder()
                let model = try decoder.decode(Scheduler.self, from: responseAPI.jsonResponse.rawData()) //Decode JSON Response Data
                if model.count > 0 {
                    self.arrayOfSchedule = model
                    self.tempArray = model
                }
            } catch let parsingError {
                self.alert(title: "Error", message: String(parsingError.localizedDescription))
            }
        }
    }
}

