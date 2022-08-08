//
//  PokemonDetailCoordinator.swift
//  PokeApi
//
//  Created by Francesco Leoni on 08/08/22.
//

import UIKit

final class PokemonDetailCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    private let navigationController: UINavigationController
    private let pokemonId: Int
    
    init(navigationController: UINavigationController, pokemonId: Int) {
        self.navigationController = navigationController
        self.pokemonId = pokemonId
    }
    
    func start() {
        let viewController = PokemonDetailViewController()
        let viewModel = PokemonDetailViewModel(coordinator: self, pokemonId: pokemonId)
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func childDidFinish(_ coordinator: Coordinator) {
        
    }
    
    func detailDidFinish() {
        parentCoordinator?.childDidFinish(self)
    }
}
