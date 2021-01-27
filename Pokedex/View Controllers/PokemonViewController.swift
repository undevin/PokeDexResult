//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Devin Flora on 1/26/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeIDLabel: UILabel!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    // MARK: - Helper Methods
    func fetchSpriteAndUpdateViews(for pokemon: Pokemon) {
        PokemonController.fetchSprite(for: pokemon) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let sprite):
                    self.pokeImageView.image = sprite
                    self.pokeNameLabel.text = pokemon.name.capitalized
                    self.pokeIDLabel.text = String(pokemon.id)
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
}//End of Class

// MARK: - Extension
extension PokemonViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text?.lowercased() else { return }
        
        PokemonController.fetchPokemon(searchTerm: searchTerm) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let pokemon):
                    self.fetchSpriteAndUpdateViews(for: pokemon)
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}//End of Extension
