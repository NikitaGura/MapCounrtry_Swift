//
//  NetworkProcessor.swift
//  Map_Country
//
//  Created by Nikita Gura on 5/8/19.
//  Copyright © 2019 Nikita Gura. All rights reserved.
//

import Foundation


class NetworkProcessor{
    
    enum API: String {
        case start = "https://restcountries.eu/rest/v2"
        case allCountry = "/all"
    }
    
    typealias getError = (() -> Void)
    typealias completion = (([Country]) -> Void)
    
    public func getJsonAllCoutry(completion: @escaping completion, getError: @escaping getError){
        
        guard let url = URL(string: API.start.rawValue+API.allCountry.rawValue)  else {return}
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if err == nil {
                
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200:
                        guard let data = data else {return}
                        let decoder = JSONDecoder()
                        let model = try? decoder.decode([Country].self, from:
                            data)
                        if let m = model {
                            completion(m)
                        }
                    default:
                        getError()
                    }
                }
                
            } else {
                getError()
            }
            }.resume()
    }
}
