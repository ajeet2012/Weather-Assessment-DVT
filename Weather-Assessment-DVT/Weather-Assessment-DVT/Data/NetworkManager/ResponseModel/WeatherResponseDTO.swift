//
//  WeatherResponseDTO.swift
//  Weather-Assessment-DVT
//
//  Created by Ajeet Sharma on 02/11/2025.
//


import Foundation

struct WeatherResponseDTO: Codable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [ForecastItem]
    let city: City
}

struct ForecastItem: Codable, Identifiable {
    var id: TimeInterval { dt }
    let dt: TimeInterval
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int?
    let pop: Double?
    let rain: Rain?
    let snow: Snow?
    let dt_txt: String
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Clouds: Codable { let all: Int }
struct Wind: Codable { let speed: Double; let deg: Int; let gust: Double? }
struct Rain: Codable { let threeH: Double?; enum CodingKeys: String, CodingKey { case threeH = "3h" } }
struct Snow: Codable { let threeH: Double?; enum CodingKeys: String, CodingKey { case threeH = "3h" } }

struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: TimeInterval
    let sunset: TimeInterval
}

struct Coord: Codable { let lat: Double; let lon: Double }
