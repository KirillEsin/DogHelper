//
//  Constants.swift
//  G12
//
//  Created by Кирилл on 03.04.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

enum Constants {
    enum RestApi {
        enum Request {
            static let question = "question"
        }
        enum Response {
            static let success = "success"
            static let token = "token"
            static let userId = "user_id"
        }
    }
    
    enum Settings {
        static let userID = "id"
        static let token = "token"
        static let materials = "materials"
    }
    
    enum ErrorKey {
        static let Error500 = "Возникли проблемы с сервером. Попробуйте позже."
    }
}

enum Constraints {
    static let defaultCell: CGFloat = 15.0
    static let padding: CGFloat = 8.0
    static let padding2x: CGFloat = 16.0
    static let padding3x: CGFloat = 24.0
    static let padding4x: CGFloat = 32.0
    static let cornerRadius: CGFloat = 8.0
    static let zero: CGFloat = 0.0
    static let defaultCellTopBottom: CGFloat = 10.0
}
