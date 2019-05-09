//
//  AppDelegate.swift
//  Map_Country
//
//  Created by Nikita Gura on 5/8/19.
//  Copyright © 2019 Nikita Gura. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let networkProcessor = NetworkProcessor()
        networkProcessor.getJsonAllCoutry(completion: {
            [weak self] countryModels in
            DispatchQueue.main.async {
                
                self?.window?.rootViewController = CountriesViewController(countries: countryModels)
                self?.window?.makeKeyAndVisible()
            }
            },
            getError: { [weak self] in
                DispatchQueue.main.async {
                    self?.window?.rootViewController = CountriesViewController()
                    self?.window?.makeKeyAndVisible()
                }
            })
        return true
    }
}

