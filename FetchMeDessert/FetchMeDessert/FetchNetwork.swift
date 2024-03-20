//
//  FetchNetwork.swift
//  FetchMeDessert
//
//  Created by Adrian Eves on 3/12/24.
//

import Foundation

enum DetailStates {
    case loading
    case loaded
    case failed
}

// The following extension was developed by my friend, Paul, at
// https:www.hackingwithswift.com/
// example-code/system/how-to-decode-json-from-your-app-bundle-the-easy-way
//
// While I understand the principles used here, I know this exists
// as a resource and have therefore elected to use it.

extension URLSession {
    func decode<T: Decodable>(
        _ type: T.Type = T.self,
        from url: URL,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
        dataDecodingStrategy: JSONDecoder.DataDecodingStrategy = .deferredToData,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate
    ) async throws  -> T {
        let (data, _) = try await data(from: url)

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        decoder.dataDecodingStrategy = dataDecodingStrategy
        decoder.dateDecodingStrategy = dateDecodingStrategy

        let decoded = try decoder.decode(T.self, from: data)
        return decoded
    }
}

// There's no real reason I'd use the URL extension like this in an
// organized project. It's purely for convenience while I work on this.
extension URL {
    static func invokeDesserts() -> URL? {
        guard let dessertUrl = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            return nil
        }
        return dessertUrl
    }
    
    static func invokeDetailUrl(id: String) -> URL? {
        guard let detailedUrl = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else {
            return nil
        }
        return detailedUrl
    }
}
