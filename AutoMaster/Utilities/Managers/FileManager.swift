//
//  FileManager.swift
//  AutoMaster
//
//  Created by Anton on 11.11.2021.
//

import Foundation

class FileManager {
    static let shared = Utilities()

    func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8)
            {
                return jsonData
            }
        } catch {
            print(error)
        }

        return nil
    }

    func parse(jsonData: Data) -> [ManufacturerModel] {
        do {
            let decodedData = try JSONDecoder().decode([ManufacturerModel].self, from: jsonData)
            return decodedData
        } catch {
            print(error)
        }
        return []
    }

    func loadJson(fromURLString urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            URLSession(configuration: .default).dataTask(with: url) { data, _, error in
                if let error = error {
                    completion(.failure(error))
                }
                if let data = data {
                    completion(.success(data))
                }
            }
            .resume()
        }
    }
}
