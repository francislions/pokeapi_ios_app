//
//  PokemonDetailViewController.swift
//  PokeApi
//
//  Created by Francesco Leoni on 08/08/22.
//

import UIKit
import RxSwift
import MBProgressHUD

class PokemonDetailViewController: UIViewController {
    
    var viewModel: PokemonDetailViewModel!
    let disposeBag = DisposeBag()
    var stackView: UIStackView?
    var pokemonPicture: UIImageView?
    var typeLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        edgesForExtendedLayout = .bottom
        
        let stackView = UIStackView()
        self.stackView = stackView
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 4
        view.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        let pokemonPicture = UIImageView()
        self.pokemonPicture = pokemonPicture
        pokemonPicture.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(pokemonPicture)
        let aspectRatioConstraint = NSLayoutConstraint(item: pokemonPicture ,attribute: .height, relatedBy: .equal,toItem: pokemonPicture, attribute: .width, multiplier: 0.5,constant: 0)
        aspectRatioConstraint.isActive = true
        pokemonPicture.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: 0).isActive = true
        pokemonPicture.addConstraint(aspectRatioConstraint)
        pokemonPicture.contentMode = .scaleAspectFit
        
        let typeLabel = UILabel()
        self.typeLabel = typeLabel
        stackView.addArrangedSubview(typeLabel)
        
        viewModel.pokemon.subscribe { event in
            if let element = event.element {
                self.setupUIWith(pokemon: element)
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        viewModel.detailDidFinish()
    }
    
    private func setupUIWith(pokemon: Pokemon) {
        title = pokemon.name
        pokemonPicture?.sd_setImage(with: URL(string: pokemon.sprites.frontDefault), placeholderImage: UIImage(named: "question_mark"))
        var types: [String] = []
        pokemon.types.forEach { slotType in
            types.append(slotType.type.name)
        }
        typeLabel?.text = "Type: \(types.joined(separator: ","))"
        
        for stat in pokemon.stats {
            let label = UILabel()
            label.text = "\(stat.stat.name): \(stat.baseStat)"
            stackView?.addArrangedSubview(label)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
