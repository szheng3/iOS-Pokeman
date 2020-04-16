//
// Created by Shuai Zheng on 4/14/20.
// Copyright (c) 2020 Shuai Zheng. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var titleName: UILabel!
    var pokemon: Pokes!


    override func viewDidLoad() {
        super.viewDidLoad()
//        pokemanView.dataSource = self
//        pokemanView.delegate = self
        // Do any additional setup after loading the view.
        PokesService.shared.getData(pokeId: pokemon.pokedexId) {

            let unwrappedValue = PokesService.shared.pokesDetails?.name ?? "gg"

            self.titleName.text = unwrappedValue

        }

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @IBAction func Dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
