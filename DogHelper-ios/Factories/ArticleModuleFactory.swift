//
//  ArticleModuleFactory.swift
//  DogHelper-ios
//
//  Created by Кирилл on 22.05.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol ArticleModuleFactory {
    func makeArticlesOutput() -> ArticlesView
}
