//
//  Networking.swift
//  MovieDatabase
//
//  Created by Kousalya Eripalli on 8/12/21.
//

import UIKit
import Foundation

// Networking functionaliy for grapping the Model subject to Codable Protocool /
class Networking {

    func response (url: String  , completion: @escaping (modelMovieData) -> ()) {
        guard let url = URL(string: url) else {return}
        URLSession.shared.dataTask(with: url, completionHandler: { (data , response , error ) in
            self.urlCompletionHandler(data: data, response: response, error: error, completion: completion)
            }).resume()
    }
    
    func urlCompletionHandler (data: Data?  , response : URLResponse? , error : Error? , completion: (modelMovieData) -> ()) {
        guard let data = data else {return}
        do {
            let jsondecoder = JSONDecoder()
            let movies = try jsondecoder.decode(modelMovieData.self, from: data)
            completion(movies)
        
        } catch {
            print("Error \(error)")
        }
    }

}
