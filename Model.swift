//
//  model.swift
//  Users
//
//  Created by Edgar Sargsyan on 20.07.23.
//

import Foundation
struct Holiday {
    let countries: [String]
    let countryCode: String
    let date: String
    let fixed: Bool
    let global: Bool
    let launchYear: Int?
    let localName: String
    let name: String
    let type: String
    
    var description: String {
        return """
        countries: \(countries)
        countryCode: \(countryCode)
        date: \(date)
        fixed: \(fixed)
        global: \(global)
        launchYear: \(launchYear ?? nil)
        localName: \(localName)
        name: \(name)
        type: \(type)
        """
    }
}
