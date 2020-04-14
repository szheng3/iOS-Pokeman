//
// Created by Shuai Zheng on 4/14/20.
// Copyright (c) 2020 Shuai Zheng. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var avatar: UIImageView!

    var pokemon: Pokes!;
//
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)

        layer.cornerRadius = 5.0
    }


    func configureCell(_ pokemon: Pokes) {

        self.pokemon = pokemon

        name.text = self.pokemon.name.capitalized
        avatar.image = UIImage(named: "\(self.pokemon.pokedexId)")

    }

//    func configureCell(_ pokemon: Int) {
//
//
//        name.text = "\(pokemon)"
//        avatar.image = UIImage(named: "\(pokemon)")
//
//    }
}
