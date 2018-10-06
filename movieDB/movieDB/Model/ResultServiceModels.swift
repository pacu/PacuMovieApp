//
//  ServiceModels.swift
//  movieDB
//
//  Created by Francisco Gindre on 4/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import Foundation

/**
 {
 "vote_count": 93,
 "id": 335983,
 "video": false,
 "vote_average": 6.1,
 "title": "Venom",
 "popularity": 324.891,
 "poster_path": "/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg",
 "original_language": "en",
 "original_title": "Venom",
 "genre_ids": [
 27,
 878,
 28,
 53
 ],
 "backdrop_path": "/VuukZLgaCrho2Ar8Scl9HtV3yD.jpg",
 "adult": false,
 "overview": "When Eddie Brock acquires the powers of a symbiote, he will have to release his alter-ego “Venom” to save his life.",
 "release_date": "2018-10-03"
 }
 
 
 */
public struct ResultItem: Decodable {
    var voteCount: Int?
    var id: Int?
    var video: Bool?
    var voteAverage: Float?
    var title: String?
    var popularity: Float?
    var posterPath: String?
    var originalLanguage: String?
    var originalTitle: String?
    var genreIds: [Int]?
    var adult: Bool?
    var overview: String?
    var releaseDate: String?
    
}

public struct ResultsResponse: Decodable {
    var totalPages: Int?
    var totalResults: Int?
    var page: Int?
    var results: [ResultItem]?
}