//
//  AppCoordinator.swift
//  PokeApi
//
//  Created by Francesco Leoni on 05/08/22.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get }
    var parentCoordinator: Coordinator? { set get }
    func start()
    func childDidFinish(_ coordinator: Coordinator)
}

final class AppCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    
    private(set) var childCoordinators: [Coordinator] = []
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navController = UINavigationController()
        
        let pokemonListCoorinator = PokemonListCoordinator(navigationController: navController)
        pokemonListCoorinator.parentCoordinator = self
        pokemonListCoorinator.start()
        
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
    
    func childDidFinish(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { item in
            return coordinator === item
        }) {
            childCoordinators.remove(at: index)
        }
    }
    
    
}
