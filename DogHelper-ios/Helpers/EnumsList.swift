//
//  EnumsList.swift
//  G12
//
//  Created by Кирилл on 03.04.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation
enum AuthorizationErrorField {
    case password
    case email
    case username
}

enum SectionItemType {
    case general
    case tasks
    case materials
    case comments
    case customer
    case necessaryMaterials
    case takenMaterials
    case additionalTasks
    case additionlaMaterials
    case driver
}

enum CellItemType {
    case title
    case description
    case address
    case date
    case name
    case email
    case phone
    case logOut
    case material
    case task
    case comment
    case customer
    case user
    case driver
}

enum MaterialsParametrOutput {
    case showOwnMaterials
    case showAllMaterials
}

enum OrderStatus: String, Codable {
    case active = "Активная"
    case inActive = "Завершенная"
}
