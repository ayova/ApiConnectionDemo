//
//  Holiday.swift
//  ApiConnectionDemo
//
//  Created by ADMIN on 19/03/2020.
//  Copyright © 2020 ADMIN. All rights reserved.
//

import Foundation

//struct Holiday: Decodable {
//    var holidays: [HolidayDetails]
//}

//struct HolidayDetails: Decodable {
//    let name: String
//    let date: String
//    let localName: String
//
//}

// MARK: - Holiday
struct Holiday: Codable {
    var holidays: [HolidayDetail]
}


struct HolidayDetail: Codable {
    let date, localName, name: String
}

typealias Holidays = [HolidayDetail]
