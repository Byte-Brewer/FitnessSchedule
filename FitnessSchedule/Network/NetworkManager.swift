//
//  NetworkManager.swift
//  FitnessSchedule
//
//  Created by Nazar Prysiazhnyi on 12/11/18.
//  Copyright © 2018 Nazar Prysiazhnyi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    static var shared = NetworkManager()
    private init () {}
    let urlString = "https://sample.fitnesskit-admin.ru/schedule/get_group_lessons_v2/"
    
    func mainRequest(hall: Int, withComplition completionHandler: @escaping (ResponseAPI) -> ()) {
        // create get request
        let startTime = CFAbsoluteTimeGetCurrent()
        let url = urlString + "\(hall)/"
        Alamofire.request(url)
            .debugLog()
            .responseJSON { response in
                
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
                    print("\nTime for main : \(String(format: "%.3f", timeElapsed)) second.")
                    let responseAPI = ResponseAPI(fromJSON: json, statusCode: (response.response?.statusCode)!)
                    completionHandler(responseAPI)
                case .failure(let error):
                    let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
                    print("\nTime for main with error : \(String(format: "%.3f", timeElapsed)) second.")
                    let responseAPI = ResponseAPI(withError: error)
                    completionHandler(responseAPI)
                }
        }
    }
    
    // MARK: Get Image end imageCash
    let imageCash = NSCache<AnyObject, AnyObject>()
    func getImage(imageID: String, completionHandler: @escaping (UIImage) -> Void ) {
        
        if let image = self.imageCash.object(forKey: imageID as AnyObject) as? UIImage {
            print("I take image from cash", imageID)
            completionHandler(image)
        } else {
            let url = URL(string: imageID)!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                
                if let image = UIImage(data: data) {
                    self.imageCash.setObject(image, forKey: imageID as AnyObject)
                    completionHandler(image)
                }
            }
            task.resume()
        }
    }
}

// alamofire extansion
extension Request {
    public func debugLog() -> Self {
        #if DEBUG
        debugPrint(self)
        #endif
        return self
    }
}

