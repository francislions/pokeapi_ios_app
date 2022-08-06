//
//  PokemonListViewController.swift
//  PokeApi
//
//  Created by Francesco Leoni on 05/08/22.
//

import UIKit
import RxSwift

class PokemonListViewController: UIViewController, UITableViewDataSource {

    var viewModel: PokemonListViewModel!
    var tableView: UITableView?
    let disposeBag = DisposeBag()
    var pokemons: [PokemonListItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Pokemon List"
        self.view.backgroundColor = UIColor.green
        
        let tableView = UITableView()
        self.tableView = tableView
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PokemonCell")
        
        viewModel.pokemons.subscribe { event in
            if let element = event.element {
                self.pokemons = element
                tableView.reloadData()
            }
        }.disposed(by: disposeBag)
        
        viewModel.loadInitialData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Table view data source and delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "PokemonCell")
        }
        
        let pokemon = pokemons[indexPath.row]
        cell.textLabel?.text = pokemon.name
        
        return cell
    }

}
