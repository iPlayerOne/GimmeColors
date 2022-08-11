//
//  Scheme.swift
//  GimmeColors
//
//  Created by ikorobov on 11.08.2022.
//

import Foundation

struct Scheme {
    let mode: String?
    let count: Int?
    let colors: [Seed]?
    let seed: Seed?

}

struct Seed {
    let hex: Hex?
    let rgb: RGB?
}

struct Hex {
    let value: String?
    let clean: String?
}

struct Name {
    let value: String?
    let closestNamedHex: String?
    let exactMatchName: Bool?
    let distance: Int?
}

struct RGB {
    let fraction: RGBFraction?
    let r: Int?
    let g: Int?
    let b: Int?
    let value: String?
}

struct RGBFraction {
    let r: Double?
    let g: Double?
    let b: Double?
}

// Xyz.swift


