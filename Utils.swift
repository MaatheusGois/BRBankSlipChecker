//
//  CustomPageControl.swift
//  BTGMicroFeatures
//
//  Created by Ramon Dias on 05/05/22.
//

import Foundation

enum Utils {
    static func clearMask(_ codigo: String) -> String {
        let charactersToRemove: Set<Character> = [" ", ".", "-"]
        return String(codigo.filter { !charactersToRemove.contains($0) })
    }
}
