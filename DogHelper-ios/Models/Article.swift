//
//  Articles.swift
//  DogHelper-ios
//
//  Created by Кирилл on 22.05.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol ArticleProtocol {
    
    var title: String { get set }
    var description: String { get set }
    var cover: String { get set }
    
    var coverURL: URL? { get }
}

extension ArticleProtocol {
    var coverURL: URL? {
        return URL(string: cover)
    }
}

class Article: ArticleProtocol {
    
    var title: String = ""
    var description: String = ""
    var cover: String = ""
    
    init(dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.cover = dictionary["image"] as? String ?? ""
        self.description = dictionary["desc"] as? String ?? ""
    }
}
