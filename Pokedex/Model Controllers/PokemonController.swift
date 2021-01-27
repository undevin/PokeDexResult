//
//  PokemonController.swift
//  Pokedex
//
//  Created by Devin Flora on 1/26/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import UIKit

class PokemonController {
    
    static let baseURL = URL(string: "https://pokeapi.co/api/v2/")
    static let pokemonEndpoint = "pokemon"
    
    static func fetchPokemon(searchTerm: String, completion: @escaping (Result<Pokemon,PokemonError>) -> Void) {
        
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        let pokemonURL = baseURL.appendingPathComponent(pokemonEndpoint)
        let finalURL = pokemonURL.appendingPathComponent(searchTerm)
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("===== ERROR =====")
                print("Function: \(#function)")
                print(error)
                print("Description: \(error.localizedDescription)")
                print("===== ERROR =====")
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                print("===== ERROR =====")
                print("Function: \(#function)")
                print(error)
                print("Description: \(error.localizedDescription)")
                print("===== ERROR =====")
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchSprite(for pokemon: Pokemon, completion: @escaping (Result<UIImage, PokemonError>) -> Void) {
        
        let url = pokemon.sprites.front_shiny
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("===== ERROR =====")
                print("Function: \(#function)")
                print(error)
                print("Description: \(error.localizedDescription)")
                print("===== ERROR =====")
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            guard let sprite = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            completion(.success(sprite))
            
        }.resume()
    }
}//End of Class
