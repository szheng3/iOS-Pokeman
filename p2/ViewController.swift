//
//  ViewController.swift
//  p2
//
//  Created by Shuai Zheng on 4/14/20.
//  Copyright © 2020 Shuai Zheng. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UISearchBarDelegate {
    @IBOutlet weak var pokemanView: UICollectionView!
    @IBOutlet weak var search: UISearchBar!
    var pokemon = [Pokes]()

    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false
    var filteredPokemon = [Pokes]()



    override func viewDidLoad() {
        super.viewDidLoad()
        pokemanView.dataSource = self
        pokemanView.delegate = self
        search.delegate = self

        parsePokemonCSV()
        initAudio()

        // Do any additional setup after loading the view.
    }

    @IBAction func playSound(_ sender: Any) {
        if musicPlayer.isPlaying {

            musicPlayer.pause()
//            sender.alpha = 0.2

        } else {

            musicPlayer.play()
//            sender.alpha = 1.0
        }
    }


    func initAudio() {

        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!

        do {

            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()

        } catch let err as NSError {

            print(err.debugDescription)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if inSearchMode {

            return filteredPokemon.count
        }

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

            let poke: Pokes!

            if inSearchMode {

                poke = filteredPokemon[indexPath.row]
                cell.configureCell(poke)

            } else {

                poke = pokemon[indexPath.row]
                cell.configureCell(poke)

            }

            return cell
        }
        return UICollectionViewCell();
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var poke: Any!


        if inSearchMode {

            poke = filteredPokemon[indexPath.row]

        } else {

            poke = pokemon[indexPath.row]
        }
        performSegue(withIdentifier: "DetailsViewController", sender: poke)


    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsViewController" {
            if let detailsVC = segue.destination as? DetailsViewController {
                if let poke = sender as? Pokes {
                    detailsVC.pokemon = poke
                }
            }
        }

    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchBar.text == nil || searchBar.text == "" {

            inSearchMode = false
            pokemanView.reloadData()
            view.endEditing(true)

        } else {

            inSearchMode = true

            let lower = searchBar.text!.lowercased()

            filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil})
            pokemanView.reloadData()

        }

    }
}

