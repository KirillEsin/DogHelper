//
//  Vaccination.swift
//  DogHelper-ios
//
//  Created by Кирилл on 31.05.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation
protocol VaccinationProtocol {
    var name: String { get set }
    var firstDate: Date { get set }
    var dates: [Date] { get set }
}

class Vaccination: VaccinationProtocol {
    var name: String = ""
    var firstDate: Date = Date()
    var dates: [Date] = []    
}
