//
//  MergedModel.swift
//  GimmeColors
//
//  Created by ikorobov on 13.08.2022.
//

import Foundation

struct Color: Decodable {
    let hex: colorHex?
    let rgb: colorRGB?
    let name: colorName?
    
    init(hex: colorHex, rgb: colorRGB, name: colorName) {
        self.hex = hex
        self.rgb = rgb
        self.name = name
    }
    
    init(single: [String: Any]) {
        hex = single["hex"] as? colorHex
        rgb = single["rgb"] as? colorRGB
        name = single["name"] as? colorName
    }
    

            
    static func getSingleColor(from value: Any) -> Color {
        guard let colorData = value as? [String:Any] else { return Color.init(single: [:]) }
        let colorModel = Color.init(
            hex: colorData["hex"] as? colorHex ?? colorHex.init(value: "", clean: ""),
            rgb: colorData["rgb"] as? colorRGB ?? colorRGB.init(r: 001, g: 011, b: 222, value: ""),
            name: colorData["name"] as? colorName ?? colorName.init(value: "", closestNamedHex: "", exactMatchName: false, distance: 0)
        )
        return colorModel

        
    }
}

struct Scheme: Decodable {
    
    let mode: String?
    let count: Int?
    let colors: [Seed]?
    let seed: Seed?
    
    init(scheme: [String: Any]) {
        mode = scheme["mode"] as? String
        count = scheme["count"] as? Int
        colors = scheme["colors"] as? [Seed]
        seed = scheme["seed"] as? Seed
    }

    
    static func getScheme(from value: Any) -> Scheme {
        guard let scheme = value as? Scheme else { return Scheme.init(scheme: [:]) }
        return scheme
    }

}

struct Seed: Decodable {
    let hex: colorHex?
    let rgb: colorRGB?
}

struct colorHex: Decodable {
    let value: String?
    let clean: String?
}

struct colorName: Decodable {
    let value: String?
    let closestNamedHex: String?
    let exactMatchName: Bool?
    let distance: Int?
    
}

struct colorRGB: Decodable  {
    let r: Int?
    let g: Int?
    let b: Int?
    let value: String?
    
}

