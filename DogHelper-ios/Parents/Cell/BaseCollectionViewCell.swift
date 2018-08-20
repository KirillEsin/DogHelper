//
//  BaseCollectionViewCell.swift
//  MVVM
//
//  Created by Кирилл on 11.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
    }
}
