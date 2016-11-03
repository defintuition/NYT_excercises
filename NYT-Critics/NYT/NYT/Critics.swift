//
//  Critics.swift
//  NYT
//
//  Created by Amber Spadafora on 11/2/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

internal enum DataParseError: Error {
    case results
    case name
}

class Critic {

    var name: String
    var image: String

    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
    convenience init?(from dictionary: [String:AnyObject]) throws {
        var imageString = String()
        
        guard let name = dictionary["display_name"] as? String else {
            throw DataParseError.name
        }
        
        if let multimedia = dictionary["multimedia"] as? [String: AnyObject],
            let resource = multimedia["resource"] as? [String: AnyObject] {
            imageString = resource["src"] as! String
        }
        
        self.init(name: name, image: imageString)
    }
    
    static func createCriticList(from data: Data) -> [Critic]? {
        
        var criticsList: [Critic]? = []
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let response: [String: AnyObject] = jsonData as? [String: AnyObject],
            let results = response["results"] as? [[String: AnyObject]]
                else {
                    throw DataParseError.results
            }
            
            for critic in results {
                let validCritic: Critic = try Critic(from: critic)!
                criticsList?.append(validCritic)
            }
        }
        
        catch DataParseError.results {
            print("Error encountered with parsing 'results' key")
        }
            
        catch DataParseError.name {
            print("Error encountered with parsing 'names' key")
        }
 
        catch {
            print("Error encountered with parsing: \(error)")
        }
        
        return criticsList
    }
}
