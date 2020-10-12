//
//  JSONParser.swift
//  GoodNews
//
//  Created by Hiram Castro on 10/10/20.
//

import Foundation

enum DataError:Error {
    case invalidResponse
    case invalidData
    case decodingError
    case serverError
}

enum resultType {
    case single
    case list
}

class JSONParser {
    
    static let shared = JSONParser()
    
    private init() {}
    
    typealias resultList<T> = (Result<[T], Error>) -> Void
    typealias result<T> = (Result<T, Error>) -> Void
    
    func downloadDataList<T: Decodable>(of type: T.Type, from url:URL, resultType:resultType, completion: @escaping resultList<T>) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(DataError.invalidResponse))
                return
            }
            
            if 200 ... 299 ~= response.statusCode {
                if let data = data {
                    do {
                        let decodedData: [T] = try JSONDecoder().decode([T].self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(DataError.decodingError))
                    }
                } else {
                    completion(.failure(DataError.invalidData))
                }
            } else {
                completion(.failure(DataError.serverError))
            }
            
        }.resume()
    }
    
    func downloadData<T: Decodable>(of type: T.Type, from url:URL, completion: @escaping result<T>) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(DataError.invalidResponse))
                return
            }
            
            if 200 ... 299 ~= response.statusCode {
                if let data = data {
                    do {
                        let decodedData: T = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(DataError.decodingError))
                    }
                } else {
                    completion(.failure(DataError.invalidData))
                }
            } else {
                completion(.failure(DataError.serverError))
            }
            
        }.resume()
    }
    
    func decodeFile<T: Decodable>(of type: T.Type, with fileName:String, completion: @escaping resultList<T>) {
        if let jsonData = loadJSONData(filename: fileName) {
            do {
                let decodedData: [T] = try JSONDecoder().decode([T].self, from: jsonData)
                completion(.success(decodedData))
            } catch {
                completion(.failure(DataError.decodingError))
            }
        }
    }
    
    func loadJSONData(filename: String) -> Data? {
        guard
            let fileURL = Bundle.main.url(forResource: filename, withExtension: "json"),
            let data = try? Data(contentsOf: fileURL)
        else { return nil }
        return data
    }
    
}
