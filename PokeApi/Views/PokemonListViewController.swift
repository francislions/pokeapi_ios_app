//
//  PokemonListViewController.swift
//  PokeApi
//
//  Created by Francesco Leoni on 05/08/22.
//

import UIKit
import RxSwift
import SDWebImage
import MBProgressHUD

class PokemonListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

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
        tableView.delegate = self
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
        
        viewModel.isLoading.subscribe { event in
            if let isLoading = event.element {
                if isLoading {
                    MBProgressHUD.showAdded(to: self.view, animated: true)
                } else {
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        let pokemon = pokemons[indexPath.row]
        cell.textLabel?.text = pokemon.name
        let imageIndex = indexPath.row + 1
        let imageURL = URL(string: "\(Constants.PokemonAPI.SpriteURL)/\(imageIndex).png")
        cell.imageView?.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "question_mark"))
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let pokemonId = indexPath.row + 1
        viewModel.showPokemonDetail(pokemonId: pokemonId)
    }
}
