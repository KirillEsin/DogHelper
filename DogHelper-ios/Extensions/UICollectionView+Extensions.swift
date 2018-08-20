//
//  UICollectionView+Extensions.swift
//  TestProject
//
//  Created by Mac user on 09.04.17.
//  Copyright © 2017 pavlyukova.ekaterina. All rights reserved.
//

import Foundation
import UIKit


extension UICollectionView {
	
	func register<T: UICollectionViewCell>(_: T.Type) {
		let nib = UINib(nibName: T.nibName, bundle: nil)
		register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
	}
    func registerClass<T:UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

	
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
		guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
			fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
		}
		return cell
	}
	

}
