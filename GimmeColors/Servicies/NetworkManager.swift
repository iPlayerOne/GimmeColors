//
//  NetworkManager.swift
//  GimmeColors
//
//  Created by ikorobov on 11.08.2022.
//

import Foundation

enum Link: String {
    case singleURL = "https://www.thecolorapi.com/id?rgb=\(r),\(g),\(b)"
    case schemeURL = "https://www.thecolorapi.com/scheme?rgb=\(r),\(g),\(b)"
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    
}
