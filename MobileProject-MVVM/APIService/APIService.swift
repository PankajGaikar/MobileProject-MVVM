//
//  APIService.swift
//  MobileProject-MVVM
//
//  Created by Pankaj Gaikar on 30/06/20.
//  Copyright © 2020 Pankaj Gaikar. All rights reserved.
//

import Foundation

/*
 * Custom error class
 * Error triggered will either be network error or parsing error.
 */
enum DataError: Error {
    case networkError
    case parsing
    case invalidURI
}

/*
 * This class is written for network interaction.
 * This class can be made more generic for future use cases, for now only request specific.
 */
class APIservice {
    
    /*
     * This API fetched the server data.
     * This API directly uses URI to fetch data and converts the response to DataModel array.
     */
    func getData(completion: @escaping(Result<[DataModel], DataError>) -> Void) {
        
        // The URI can be accepted from ViewModel if API has to be written more generic.
        // Same goes for API response parsing and model class array generation.
        let urlString = Constants.DataURI

        guard let dataURI = URL(string: urlString) else {
            completion(.failure(.invalidURI))
            return
        }

        let dataTask = URLSession.shared.dataTask(with: dataURI, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil, response != nil else {
                completion(.failure(.networkError))
                return
            }

            do {
                // Decode the json data.
                let decoder = JSONDecoder()
                let response = try decoder.decode([DataModel].self, from: data)
                completion(.success(response))
            } catch {
                print(error)
                completion(.failure(.parsing))
            }
        })

        dataTask.resume()
    }
    
}
