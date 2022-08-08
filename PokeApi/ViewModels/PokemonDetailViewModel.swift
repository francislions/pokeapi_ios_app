//
//  PokemonDetailViewModel.swift
//  PokeApi
//
//  Created by Francesco Leoni on 08/08/22.
//

import Foundation
import RxSwift

final class PokemonDetailViewModel {
    private weak var coordinator: PokemonDetailCoordinator?
    let pokemonId: Int
    let pokeApi: PokeApi
    var pokemon: PublishSubject<Pokemon> = PublishSubject()
    var isLoading: PublishSubject<Bool> = PublishSubject()
    
    init(coordinator: PokemonDetailCoordinator, pokemonId: Int, pokeApi: PokeApi = PokeApi()) {
        self.coordinator = coordinator
        self.pokemonId = pokemonId
        self.pokeApi = pokeApi
        self.isLoading.onNext(false)
    }
    
    func loadInitialData() {
        self.isLoading.onNext(true)
        pokeApi.getPokemon(pokemonId) { pokemon in
            if let pokemon = pokemon {
                self.pokemon.onNext(pokemon)
            }
            self.isLoading.onNext(false)
        }
    }
    
    func detailDidFinish() {
        coordinator?.detailDidFinish()
    }
}
