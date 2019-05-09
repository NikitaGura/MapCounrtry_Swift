//
//  Country.swift
//  Map_Country
//
//  Created by Nikita Gura on 5/8/19.
//  Copyright © 2019 Nikita Gura. All rights reserved.
//

import Foundation


struct Country:Codable {
    let name: String
    let latlng: [Double]
    let area: Double?
}
