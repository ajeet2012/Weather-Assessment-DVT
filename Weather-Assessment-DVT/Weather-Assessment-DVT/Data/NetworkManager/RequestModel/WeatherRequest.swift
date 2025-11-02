//
//  WeatherRequest.swift
//  Weather-Assessment-DVT
//
//  Created by Ajeet Sharma on 02/11/2025.
//

import Foundation


enum Units: String {
    case metric
    case imperial
}

final internal class WeatherRequest: Requestable {
    
    private let lat: String?
    private let lon: String?
    private let appid: String?
    private let units: Units?
    
    init(lat: String?, lon: String?, appid: String?, units: Units? = .metric) {
        self.lat = lat
        self.lon = lon
        self.appid = appid
        self.units = units
    }
    
    var endpoint: String { "/data/2.5/forecast" }
    var method: HTTPMethod { .get }
    var headers: [String : String]? { nil }
    var queryType: NetworkQueryType {
        .path([
            "lat": "\(lat ?? "")",
            "lon": "\(lon ?? "")",
            "appid": "\(appid ?? "")",
            "units": "\(units?.rawValue ?? "metric")"
        ])
    }
    
    
    var responseType: Decodable.Type {
        WeatherResponseDTO.self
    }
    
}

