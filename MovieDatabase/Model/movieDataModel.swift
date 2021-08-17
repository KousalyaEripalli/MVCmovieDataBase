//
//  movieDataModel.swift
//  MovieDatabase
//
//  Created by Kousalya Eripalli on 8/12/21.
//

import UIKit

struct modelMovieData: Codable{
    var results:[Results]?
    
}

struct Results: Codable {
    var original_title:String?
    var backdrop_path: String?
    var release_date:String?
    var popularity:Double?
}
