//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jared Warren on 12/18/19.
//  Copyright © 2019 Warren. All rights reserved.
//

import Foundation

// Our model, based off of the JSON.
struct Pokemon: Decodable {
    
    let name: String
    let id: Int
    let sprites: Sprites
    
    struct Sprites: Decodable {
        
        let classic: URL
        
        // CodingKeys let us use our own naming conventions.
        enum CodingKeys: String, CodingKey {
            case classic = "front_default"
        }
    }
}

