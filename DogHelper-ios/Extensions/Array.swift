//
//  Array.swift
//  DogHelper-ios
//
//  Created by Кирилл on 28.05.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

func createIndex<Key, Element>(elms:[Element], extractKey:(Element) -> Key) -> [Key:Element] where Key : Hashable {
    var dict = [Key:Element]()
    for elm in elms {
        dict[extractKey(elm)] = elm
    }
    return dict
}
