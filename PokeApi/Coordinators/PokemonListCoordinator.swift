//
//  PokemonListCoordinator.swift
//  PokeApi
//
//  Created by Francesco Leoni on 05/08/22.
//

import UIKit

final class PokemonListCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = PokemonListViewController()
        let viewModel = PokemonListViewModel(coordinator: self)
        viewController.viewModel = viewModel
        self.navigationController.setViewControllers([viewController], animated: false)
    }
    
    func childDidFinish(_ coordinator: Coordinator) {
        
    }
    
    
}
