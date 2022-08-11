//
//  Scheme.swift
//  GimmeColors
//
//  Created by ikorobov on 11.08.2022.
//

import Foundation

struct Scheme: Decodable {
    
    let mode: String?
    let count: Int?
    let colors: [Seed]?
    let seed: Seed?

}

struct Seed: Decodable {
    let hex: schemeHex?
    let rgb: schemeRGB?
}

struct schemeHex: Decodable {
    let value: String?
    let clean: String?
}

struct schemeName: Decodable {
    let value: String?
    let closestNamedHex: String?
    let exactMatchName: Bool?
    let distance: Int?
}

struct schemeRGB: Decodable  {
    let fraction: schemeRGBFraction?
    let r: Int?
    let g: Int?
    let b: Int?
    let value: String?
}

struct schemeRGBFraction: Decodable {
    let r: Double?
    let g: Double?
    let b: Double?
}



