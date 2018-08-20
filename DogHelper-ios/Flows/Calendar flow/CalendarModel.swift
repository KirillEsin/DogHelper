//
//  CalendarModel.swift
//  DogHelper-ios
//
//  Created by Кирилл on 31.05.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol CalendarModelProtocol: Model {
    
}

class CalendarModel: BaseModel, CalendarModelProtocol {
    
    override init(dataManager: DataManagerProtocol) {
        super.init(dataManager: dataManager)
    }
    
    
}
