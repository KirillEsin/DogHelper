//
//  SelectBreedModuleFactory.swift
//  DogHelper-ios
//
//  Created by Кирилл on 28.05.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol SelectBreedModuleFactory {
    func makeSelectBreedOutput() -> SelectBreedView
    func makeMLBreedOutput() -> MLBreedView
}
