//
//  Model.swift
//  AstonWeatherApp
//
//  Created by Artem Tkachev on 31.08.23.
//

import Foundation

struct WeatherDetail: Codable, Identifiable {
    
    let main: Main?
    let id: Int?
    
    static var placeholder: Self {
        return WeatherDetail(main: nil, id: nil)
    }
}

struct Main: Codable {
    let temp: Double?
    let pressure, humidity: Int?
    let tempMin, tempMax: Double?

    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}
