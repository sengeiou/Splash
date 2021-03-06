//
//  SearchResults.swift
//  Splash
//
//  Created by Running Raccoon on 2020/05/21.
//  Copyright © 2020 Running Raccoon. All rights reserved.
//

import Foundation

//MARK: - UserResults -
struct UserResult: Decodable {
    let total: Int?
    let totalPages: Int?
    let results: [User]?
    
    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}


//MARK: - PhotoResults -
struct PhotoResult: Decodable {
    let total: Int?
    let totalPages: Int?
    let results: [Photo]?
    
    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

//MARK: - PhotoCollectionResults -
struct PhotoCollectionResult: Decodable {
    let total: Int?
    let totalPages: Int?
    let results: [PhotoCollection]?
    
    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}
