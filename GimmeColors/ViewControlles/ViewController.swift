//
//  ViewController.swift
//  GimmeColors
//
//  Created by ikorobov on 09.08.2022.
//

import UIKit

class PalleteViewController: UIViewController {
    
    private let randomURL = "https://www.colourlovers.com/api/palettes/random?format=json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRandomPallete()
    }
    
    private func getRandomPallete() {
        guard let url = URL(string: randomURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let pallete = try JSONDecoder().decode([Pallete].self, from: data)
                print(pallete)
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
}

