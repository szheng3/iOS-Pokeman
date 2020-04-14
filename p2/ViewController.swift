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
    var pokemon = [Pokes]()


    override func viewDidLoad() {
        super.viewDidLoad()
        pokemanView.dataSource = self
        pokemanView.delegate = self
        parsePokemonCSV()

        // Do any additional setup after loading the view.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return pokemon.count
    }

    func parsePokemonCSV() {

        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!

        do {

            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows

            for row in rows {

                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!

                let poke = Pokes(name: name, pokedexId: pokeId)
                pokemon.append(poke)

            }

        } catch let err as NSError {

            print(err.debugDescription)
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {


            cell.configureCell(pokemon[indexPath.row]);
            return cell
        }
        return UICollectionViewCell();
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailsViewController", sender: self)


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

