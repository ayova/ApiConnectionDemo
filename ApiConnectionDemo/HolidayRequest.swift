//
//  HolidayRequest.swift
//  ApiConnectionDemo
//
//  Created by ADMIN on 19/03/2020.
//  Copyright © 2020 ADMIN. All rights reserved.
//

import Foundation

enum HolidayError: Error {
    case canNotAccessData
    case dataIsNotAvailable
}

struct HolidayRequest {
    let resourceURL: URL
    
    init(year: Int, countryCode: String) {
        let resourceString = "https://date.nager.at/api/v2/PublicHolidays/\(year)/\(countryCode)"
        
        guard let resourceURL = URL(string: resourceString) else { fatalError() }
        self.resourceURL = resourceURL
    }
    
    func getHolidays(completion: @escaping(Result<[HolidayDetail], HolidayError>)->Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.dataIsNotAvailable))
                return
            }
            do {
                let decoder = JSONDecoder()
                let holidaysResponse = try decoder.decode(Holidays.self, from: jsonData)
                
                completion(.success(holidaysResponse))
            } catch {
                completion(.failure(.canNotAccessData))
            }
        }
        dataTask.resume()
    }
}
