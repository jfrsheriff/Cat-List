//
//  CatBreeds.swift
//  Cat List
//
//  Created by Jaffer Sheriff U on 22/10/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let catBreeds = try? newJSONDecoder().decode(CatBreeds.self, from: jsonData)

import Foundation

// MARK: - CatBreed
struct CatBreed: Codable {
    
    let weight: Weight
    let id, name: String
    let cfaUrl: String?
    let vetstreetUrl: String?
    let vcahospitalsUrl: String?
    let temperament, origin, countryCodes, countryCode: String
    let description, lifeSpan: String
    let indoor: Int
    let lap: Int?
    let altNames: String?
    let adaptability, affectionLevel, childFriendly, dogFriendly: Int
    let energyLevel, grooming, healthIssues, intelligence: Int
    let sheddingLevel, socialNeeds, strangerFriendly, vocalisation: Int
    let experimental, hairless, natural, rare: Int
    let rex, suppressedTail, shortLegs: Int
    let wikipediaUrl: String?
    let hypoallergenic: Int
    let referenceImageId: String?
    let image: Image?
    let catFriendly, bidability: Int?
    
    
    // MARK: - Image
    struct Image: Codable {
        let id: String
        let width, height: Int
        let url: String
    }
    
    
    // MARK: - Weight
    struct Weight: Codable {
        let imperial, metric: String
    }
}

typealias CatBreeds = [CatBreed]
