//
//  WeatherRequest.swift
//  Weather-Assessment-DVT
//
//  Created by Ajeet Sharma on 02/11/2025.
//

import Foundation

final internal class WeatherRequest: Requestable {
    
    private let lat: String?
    private let lon: String?
    private let appid: String?
    
    init(lat: String?, lon: String?, appid: String?) {
        self.lat = lat
        self.lon = lon
        self.appid = appid
    }
    
    var path: String {
        guard let lat = lat, let lon = lon, let appid = appid else { return "" }
        return "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(appid)"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var headers: [String: String]? {
        ["content-type" : "application/json"]
    }
    
    var parameters: [String : Any]? {
        nil
    }
    
    var responseType: Decodable.Type {
        WeatherResponseDTO.self
    }
    
}

