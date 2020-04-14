//
//  ViewController.swift
//  p2
//
//  Created by Shuai Zheng on 4/14/20.
//  Copyright © 2020 Shuai Zheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var pokemanView: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemanView.dataSource=self
        pokemanView.delegate=self
        // Do any additional setup after loading the view.
    }


}

extension ViewController:UICollectionViewDelegate, UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {

            return cell
        }
        return UICollectionViewCell();
    }

}