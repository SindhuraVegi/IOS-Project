//
//  RandomUser.swift
//  RandomUserSwift
//
//  Created by Sindhura VEGI on 23/01/19.
//  Copyright © 2019 Sindhura VEGI. All rights reserved.
//

import Foundation
import UIKit

/// Class that interacts with the RandomUser API to generate random users
public class RandomUser {

    /// Singleton
    public static let shared = RandomUser()

    /// API Version Number
    private static var apiVersion = 1.2

  
    public func getUsers(results: Int = 33,
                         gender: String = "both",
                         _ completionHandler: @escaping (_ data: Users?, _ error: Error?) -> Void) {

        guard let url = createUrl(results: results, gender: gender) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil, let data = data else {
                completionHandler(nil, error)
                let alertController = UIAlertController(title: "Alert", message: "No internet Connection.", preferredStyle: .alert)
                let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
                }
                    alertController.addAction(action1)
                    let rootViewController = UIApplication.shared.keyWindow?.rootViewController
                    rootViewController!.present(alertController, animated: true, completion: nil)
                    
                return
                }

            let users = try? JSONDecoder().decode(Users.self, from: data)
            completionHandler(users, nil)
        }

        task.resume()
    }

    /// Create URL with config query parameters to use for RandomUser API
    private func createUrl(results: Int, gender: String) -> URL? {
        return URL(string: "https://randomuser.me/api/?results=\(results)&gender=\(gender)&seed=VEGI")
        
    }

}
