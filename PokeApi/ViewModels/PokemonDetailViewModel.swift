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
    var pokemon: PublishSubject<[Pokemon]> = PublishSubject()
    
    init(coordinator: PokemonDetailCoordinator, pokemonId: Int, pokeApi: PokeApi = PokeApi()) {
        self.coordinator = coordinator
        self.pokemonId = pokemonId
        self.pokeApi = pokeApi
    }
    
    func loadInitialData() {
        
    }
    
    func detailDidFinish() {
        coordinator?.detailDidFinish()
    }
}
