//
//  ViewController.swift
//  GimmeColors
//
//  Created by ikorobov on 09.08.2022.
//

import UIKit

class PalleteViewController: UIViewController {
    
    @IBOutlet weak var backgroundColorSwitch: UISwitch!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorInfoLabel: UILabel!
    @IBOutlet weak var palleteCollection: UICollectionView!
    @IBOutlet weak var palleteLayout: UICollectionViewFlowLayout!
    
    private var singleColor: Color?
    private var schemeColor: Scheme? {
        didSet {
            palleteCollection.reloadData()
        }
    }
    
    private var red: Int?
    private var green: Int?
    private var blue: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRandom()
        palleteLayout.minimumLineSpacing = 5
        getColor()
        getScheme()

    }
    
    @IBAction func backgoundColorSwitchPressed(_ sender: UISwitch) {
        if sender.isOn {
            view.backgroundColor = .black
            colorInfoLabel.textColor = .white
        } else {
            view.backgroundColor = .systemGray5
            colorInfoLabel.textColor = .black
        }
    }
    
    @IBAction func colorViewPressed() {
        performSegue(withIdentifier: "toSetColorVC", sender: nil)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let colorSettingsVC = segue.destination as? SetColorViewController else { return }
            
        colorSettingsVC.viewColor = colorView.backgroundColor
        }

    @IBAction func unwindTo(_ unwindSegue: UIStoryboardSegue) {
            guard let colorSettingsVC = unwindSegue.source as? SetColorViewController else { return }
            red = Int(colorSettingsVC.redSlider.value)
            green = Int(colorSettingsVC.greenSlider.value)
            blue = Int(colorSettingsVC.blueSlider.value)
        colorView.backgroundColor = UIColor(red: red ?? 00, green: green ?? 00, blue: blue ?? 00, a: 1)
            getColor()
            getScheme()
        }
    
    private func getRandom() {
        red = Int.random(in: 1...255)
        green = Int.random(in: 1...255)
        blue = Int.random(in: 1...255)
    }
    
    private func getColorFromRGB(for sender: colorRGB) -> UIColor {
            guard let red = sender.r, let green = sender.g, let blue = sender.b else { return UIColor() }
            return UIColor(red: red, green: green, blue: blue, a: 1)
            
        }


    
    private func getColor() {
        NetworkManager.shared.fetch(Color.self, from: NetworkManager.shared.getURLString(for: .singleURL, r: red ?? 00, g: green ?? 00, b: blue ?? 99)) { [weak self] result in
            switch result {
                case .success(let color):
                    print(color)
                    self?.singleColor = color
                    self?.palleteCollection.reloadData()
                    guard let rgb = color.rgb else { return }
                    self?.colorView.backgroundColor = self?.getColorFromRGB(for: rgb)
                    
                    self?.colorInfoLabel.text = """
\(color.name?.value ?? "No data")
Hex: \(color.hex?.value ?? "No data")
"""
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    private func getScheme() {
        NetworkManager.shared.fetch(Scheme.self, from: NetworkManager.shared.getURLString(for: .schemeURL, r: red ?? 00 , g: green ?? 00, b: blue ?? 00)) { [weak self] result in
            switch result {
                case .success(let scheme):
                    self?.schemeColor = scheme
                case .failure(let error):
                    print(error)
            }
        }
        
    }
}
    
extension PalleteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        schemeColor?.colors?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "schemeCell", for: indexPath)
        let cellColor = schemeColor?.colors?[indexPath.item].rgb
        cell.backgroundColor = UIColor(red: cellColor?.r ?? 0, green: cellColor?.g ?? 0, blue: cellColor?.b ?? 0, a: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cellColor = schemeColor?.colors?[indexPath.row].rgb as? colorRGB else { return }
        red = cellColor.r
        green = cellColor.g
        blue = cellColor.b
        colorView.backgroundColor = getColorFromRGB(for: cellColor)
        getColor()
        getScheme()
        
    }
    
    
}
