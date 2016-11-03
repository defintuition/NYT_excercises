//
//  ApiRequestManager.swift
//  NYT
//
//  Created by Amber Spadafora on 11/2/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

class APIRequestManager {
    
    static let manager = APIRequestManager()
    private init() {}
    
    let apiEndPoint: URL = URL(string: "https://api.nytimes.com/svc/movies/v2/critics/all.json?api-key=e23afd8c16ff4c458cb0cc9cce9d815e")!
    
    func getData(callback: @escaping ((Data?) -> Void)) {
        
        let currentUrlSession = URLSession(configuration: URLSessionConfiguration.default)
        
        currentUrlSession.dataTask(with: APIRequestManager.manager.apiEndPoint) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil {
                print("There was an error during session: \(error)")
            }
            
            if data != nil {
                callback(data)
            }
            }
            .resume()
    }
    
    
}
