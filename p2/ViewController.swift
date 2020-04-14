//
//  ViewController.swift
//  p2
//
//  Created by Shuai Zheng on 4/14/20.
//  Copyright © 2020 Shuai Zheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var pokemanView: UICollectionView!


    override func viewDidLoad() {
        super.viewDidLoad()
        pokemanView.dataSource = self
        pokemanView.delegate = self
        // Do any additional setup after loading the view.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {

            return cell
        }
        return UICollectionViewCell();
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("ggg")
        let a = "gg"
        performSegue(withIdentifier: "DetailsViewController", sender: a)


    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////        if segue.identifier == "PokemonDetailVC" {
////            if let detailsVC = segue.destination as? PokemonDetailVC {
////                if let poke = sender as? Pokemon {
////                    detailsVC.pokemon = poke
////                }
////            }
////        }
//
//    }


}

