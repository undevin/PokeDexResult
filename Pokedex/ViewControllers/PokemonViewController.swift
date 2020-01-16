//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Jared Warren on 12/18/19.
//  Copyright © 2019 Warren. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var pokeSearchBar: UISearchBar!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeIDLabel: UILabel!
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Lets the search bar notify us on certain events.
        pokeSearchBar.delegate = self
    }
    
    // MARK: - Private Methods
    
    private func fetchSpriteAndUpdateViews(for pokemon: Pokemon) {
        
        // Request an image from PokemonController
        PokemonController.fetchSprite(for: pokemon) { [weak self] (result) in
            
            // Return to main thread after fetch
            DispatchQueue.main.async {
                
                // Handle both possible "results"
                switch result {
                    
                // If success, we now have everything we need to update the UI
                case .success(let sprite):
                    self?.pokeImageView.image = sprite
                    self?.pokeNameLabel.text = pokemon.name
                    self?.pokeIDLabel.text = String(pokemon.id)
                    
                // If failure, notify the user
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}

// MARK: - UISearchBar Delegate

extension PokemonViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // Pull text off the search bar
        guard let searchTerm = searchBar.text,
            !searchTerm.isEmpty else { return }
        
        // Request a pokemon from the PokemonController. Remember to use a capture list because the closure is @escaping.
        PokemonController.fetchPokemon(searchTerm: searchTerm) { [weak self] (result) in
            
            // Return to main thread after a fetch
            DispatchQueue.main.async {
                
                // Handle both possible "results"
                switch result {
                    
                    // If success, get the pokemon's sprite
                case .success(let pokemon):
                    self?.fetchSpriteAndUpdateViews(for: pokemon)
                    
                    // If failure, notify the user
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}
