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
    
    @IBAction func colorViewPressed() {
        
    }
    
//    private func setColorValue() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
//        var red: CGFloat = 0
//        var green: CGFloat = 0
//        var blue: CGFloat = 0
//        var alpha: CGFloat = 0
//        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
//        return (red: red, green: green, blue: blue, alpha: alpha)
//    }
    
    private func getColor() {
        NetworkManager.shared.fetch(Color.self, from: NetworkManager.shared.getURLString(for: .singleURL, r: 0, g: 0, b: 99)) { [weak self] result in
            switch result {
                case .success(let color):
                    print(color)
                    self?.singleColor = color
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    private func getScheme() {
        NetworkManager.shared.fetch(Scheme.self, from: NetworkManager.shared.getURLString(for: .schemeURL, r: 0, g: 0, b: 99)) { [weak self] result in
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
    
extension PalleteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        schemeColor?.colors?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "schemeCell", for: indexPath)
        let cellColor = schemeColor?.colors?[indexPath.item].rgb
//        let cellColor = schemeColor?.colors?[indexPath.item].rgb?.value?
//            .components(separatedBy: CharacterSet.letters)
//        let filteredColor = cellColor?.compactMap({Int($0)})
//            .compactMap{Int($0)}
//        let filteredColor = cellColor?.components(separatedBy: CharacterSet.letters).joined()
//        print(filteredColor)
        print("Ячейка \(cellColor)")
        cell.backgroundColor = UIColor(red: cellColor?.r ?? 00, green: cellColor?.g ?? 00, blue: cellColor?.b ?? 99)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Дид селект \(schemeColor)")
    }
    
    
}
