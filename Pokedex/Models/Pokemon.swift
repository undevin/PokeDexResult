//
//  Pokemon.swift
//  Pokedex
//
//  Created by Devin Flora on 1/26/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    let name: String
    let id: Int
    let sprites: Sprites
}//End of Struct

struct Sprites: Decodable {
    let front_shiny: URL
}//End of Struct

