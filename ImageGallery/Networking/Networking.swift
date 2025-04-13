//
//  Networking.swift
//  ImageGallery
//
//  Created by Abhinav Soni on 12/04/25.
//

import Foundation

class Networking{
    static let shared = Networking()
    private let apiKey = Constants.apiKey
    private let baseUrl = Constants.baseUrl

    private init(){}
    
    // MARK: - Fetch Movie List
    func hitApiGetRequest<T:Decodable>(type:T.Type ,endPoint: String) async throws -> T {
        let url = URL(string: "\(baseUrl)\(endPoint)")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            // MARK: - Debugging: Print Raw API Response
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw API Response: \(jsonString)")
            }
            let decoder = JSONDecoder()
            let response = try decoder.decode(type, from: data)
//            print("movieResponse-----: \(response)")
            return response

        } catch {
            print("Error fetching movies: \(error)")
            throw error
        }
    }
}
