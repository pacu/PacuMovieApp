//
//  DetailModels.swift
//  movieDB
//
//  Created by Francisco Gindre on 7/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import Foundation


public struct Genre: Decodable {
    var id: Int?
    var name: String?
    
}

public struct Companies: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
    
    var name: String?
    var id: Int?
    var logoPath: String?
    var originCountry: String?
}

public struct ProductionCountries: Decodable {
    enum CodingKeys: String, CodingKey {
        case iso = "iso_3166_1"
        case name
    }
    var iso: String?
    var name: String?
}

public enum ItemStatus: String, Decodable {
    case rumored = "Rumored"
    case planned = "Planned"
    case inProduction = "In Production"
    case postProduction = "Post Production"
    case released = "Released"
    case cancelled = "Cancelled"
    case ended = "Ended"
}

public struct CreditItem: Decodable {
    enum CodingKeys: String,CodingKey {
        case id
        case creditId = "credit_id"
        case name
        case gender
        case profilePath = "profile_path"
    }
    
    var id: Int?
    var creditId: String
    var name: String?
    var gender: Int?
    var profilePath: String?
}

public struct ItemDetail: Decodable {
    enum CodingKeys: String, CodingKey {
        
        case adult
        case backdropPath = "backdrop_path"
        case budget
        case genres
        case id
        case homepage
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case status
        case tagline
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
        case name
        case firstAirDate = "first_air_date"
        
        // TV Specific
        case createdBy = "created_by"
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case episodeRunTime = "episode_run_time"        
        case inProduction = "in_production"
        case languages
        case lastEpisodeAired = "last_episode_to_air"
        case networks
        case originalName = "original_name"
        case seasons
        case type
    }
    var adult: Bool?
    var voteCount: Int?
    var backdropPath: String?
    var budget: Int?
    var genres: [Genre]?
    var homepage: String?
    var id: Int?
    var imdbId: String?
    var originalLanguage: String?
    var originalTitle: String?
    var overview: String?
    var popularity: Float?
    var posterPath: String?
    var productionCompanies: [Companies]?
    var productionCountries: [ProductionCountries]?
    var status: ItemStatus?
    var tagline: String?
    var title: String?
    var video: Bool?
    var voteAverage: Float?
    var releaseDate: String?
    
    // TV Specific
    var createdBy: [CreditItem]?
    var numberOfEpisodes: Int?
    var numberOfSeasons: Int?
    var episodeRunTime: [Int]?
    var name: String?
    var firstAirDate: String?
    var inProduction: Bool?
    var languages: [String]?
    var lastEpisodeAired: Episode?
    var networks: [Companies]?
    var originalName: String?
    var seasons: [Season]?
    var type: String?
    

    
    
    var year: String? {
        let dateString = self.releaseDate ?? self.firstAirDate ?? nil
        
        guard let string = dateString, let date = DateFormatter.moviedb_formatter().date(from: string) else {
            return nil
        }
        
        return String(describing: date.year())
    }
    var genericName: String? {
        if name != nil { return name }
        return title
    }
    

}

public struct Season: Decodable {
    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case id
        case name
        case overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
    
    var airDate: String?
    var episodeCount: Int?
    var id: Int?
    var name: String?
    var overview: String?
    var posterPath: String?
    var seasonNumber: Int?
}

public struct Episode: Codable {
    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case id
        case name
        case overview
        case productionCode = "production_code"
        case seasonNumber = "season_number"
        case showId = "show_id"
        case stillPath = "still_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    var airDate: String?
    var episodeNumber: Int?
    var id: Int?
    var name: String?
    var overview: String?
    var productionCode: String?
    var seasonNumber: Int?
    var showId: Int?
    var stillPath: String?
    var voteAverage: Float?
    var voteCount:Int?
}




