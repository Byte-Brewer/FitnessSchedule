//
//  RsponseAPI.swift
//  FitnessSchedule
//
//  Created by Nazar Prysiazhnyi on 12/11/18.
//  Copyright © 2018 Nazar Prysiazhnyi. All rights reserved.
//

import Foundation
import SwiftyJSON

class ResponseAPI {
    // MARK: - Properties
    var code: Int!
    var status: String!
    var jsonResponse: JSON!
    
    // MARK: - Class Initialization
    init(withError error: Error) {
        self.code = 999
        self.status = error.localizedDescription
        self.jsonResponse = ""
    }
    
    init(fromJSON json: JSON, statusCode: Int) {
        self.code = statusCode
        self.status = "OK"
        self.jsonResponse = json
    }
    
    func parseJson<T: Decodable>(type: T.Type) -> T? {
        guard self.status == "OK" else {
            return nil
        }
        do {
            let myStruct = try JSONDecoder().decode(T.self, from: self.jsonResponse.rawData())
            return myStruct
        } catch let error {
            print("ERROR IN \(T.self)  \n\n \(error)")
            self.status = error.localizedDescription
            return nil
        }
    }
}
