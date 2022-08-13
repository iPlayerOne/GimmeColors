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

}

struct Scheme: Decodable {
    
    let mode: String?
    let count: Int?
    let colors: [Seed]?
    let seed: Seed?

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
    let fraction: colorRGBFraction?
    let r: Int?
    let g: Int?
    let b: Int?
    let value: String?
}

struct colorRGBFraction: Decodable {
    let r: Double?
    let g: Double?
    let b: Double?
}
