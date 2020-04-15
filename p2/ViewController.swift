//
//  ViewController.swift
//  p2
//
//  Created by Shuai Zheng on 4/14/20.
//  Copyright © 2020 Shuai Zheng. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var pokemanView: UICollectionView!
    var pokemon = [Pokes]()

    var musicPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        pokemanView.dataSource = self
        pokemanView.delegate = self
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
        performSegue(withIdentifier: "DetailsViewController", sender: pokemon[indexPath.row])


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


}

