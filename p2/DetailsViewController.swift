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
        titleName.text = pokemon.name

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @IBAction func Dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
