//
//  Array+shuffled.swift
//  meowsterhits
//
//  Created by Justin Lawrence Hester on 5/23/16.
//  Copyright © 2016 danlyG. All rights reserved.
//

import Foundation

extension Array {
    func shuffled() -> Array {
        if count < 2 { return self }
        var list = self
        for i in 0..<(list.count - 1) {
            let j = Int(arc4random_uniform(UInt32(list.count - i))) + i
            if i != j { // Check if you are not trying to swap an element with itself
                swap(&list[i], &list[j])
            }
        }
        return list
    }
}