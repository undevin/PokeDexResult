//
//  PokemonError.swift
//  Pokedex
//
//  Created by Jared Warren on 12/20/19.
//  Copyright © 2019 Warren. All rights reserved.
//

import Foundation

enum PokemonError: LocalizedError {
    
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    /// Whatever info you think the user should know.
    var errorDescription: String? {
        switch self {
        case .thrownError(let error):
            return error.localizedDescription
        case .invalidURL:
            return "Unable to reach the server."
        case .noData:
            return "The server responded with no data."
        case .unableToDecode:
            return "The server responded with bad data."
        }
    }
}
