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
    
    private var singleColor: Color?
    private var schemeColor: Scheme? {
        didSet {
            palleteCollection.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getColor()
        print("didLoad\(singleColor)")
        getScheme()
        palleteCollection.reloadData()
        print("didload \(schemeColor)")
        print("didload \(schemeColor?.colors?.count)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getColor()
        print("willAppear\(singleColor)")
        getScheme()
        palleteCollection.reloadData()
        print(" willappear \(schemeColor)")
        print("willappear \(schemeColor?.colors?.count)")
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

    
    private func getColorFromRGB(for color: Color) -> UIColor {
            guard let rgb = color.rgb, let red = rgb.r, let green = rgb.g, let blue = rgb.b else { return UIColor() }
            return UIColor(red: red, green: green, blue: blue, a: 1)
        }

    
    private func getColor() {
        NetworkManager.shared.fetch(Color.self, from: NetworkManager.shared.getURLString(for: .singleURL, r: 0, g: 0, b: 99)) { [weak self] result in
            switch result {
                case .success(let color):
                    print(color)
                    self?.singleColor = color
                    self?.palleteCollection.reloadData()
                    self?.colorView.backgroundColor = self?.getColorFromRGB(for: color)
                    self?.colorInfoLabel.text = "\(color.name?.value ?? "No data") \nHex: \(color.hex?.value ?? "No data")"
                    
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    private func getScheme() {
        NetworkManager.shared.fetch(Scheme.self, from: NetworkManager.shared.getURLString(for: .schemeURL, r: 44, g: 13, b: 99)) { [weak self] result in
            switch result {
                case .success(let scheme):
                    print(scheme)
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


        print("Ячейка \(cellColor)")
        cell.backgroundColor = UIColor(red: cellColor?.r ?? 0, green: cellColor?.g ?? 0, blue: cellColor?.b ?? 0, a: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Дид селект \(schemeColor)")
    }
    
    
}
