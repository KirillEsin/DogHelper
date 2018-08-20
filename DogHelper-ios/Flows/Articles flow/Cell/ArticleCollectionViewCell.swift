//
//  ItemsCollectionViewCell.swift
//  Malmo
//
//  Created by Кирилл on 22.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import UIKit
import SDWebImage
import Cards

class ArticleCollectionViewCell: UICollectionViewCell {

    @IBOutlet fileprivate weak var containerView: UIView!
    @IBOutlet fileprivate weak var gradientView: UIView!
    @IBOutlet fileprivate weak var imageView: UIImageView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    //@IBOutlet fileprivate weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 6
        containerView.layer.masksToBounds = true
        
        layer.shadowColor = ColorPalette.shadow.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 4.0
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.masksToBounds = false
        
//        gradientView.gradientLayer.colors = [ColorPalette.blackGradientClean.cgColor, ColorPalette.blackGradient.cgColor]
//        gradientView.gradientLayer.gradient = GradientPoint.topBottom.draw()
        
    }
     
    var article: ArticleProtocol? {
        didSet {
            guard let article = article else {
                return
            }
            setupViewModel(article)
        }
    }
    
    func setupViewModel(_ article: ArticleProtocol) {
        titleLabel.text = article.title
        //priceLabel.text = viewModel.price
        imageView.sd_setImage(with: article.coverURL, completed: nil)
    }
}

class ArticleCardCollectionViewCell: BaseCollectionViewCell {
    
    let cardView: CardArticle = {
        
        let cardView = CardArticle()
        cardView.backgroundImage = UIImage(named: "mvBackground")
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.isUserInteractionEnabled = false
        cardView.backgroundIV.isUserInteractionEnabled = false
        return cardView
    }()
    
    override func setupView() {
        contentView.addSubview(cardView)
        contentView.isUserInteractionEnabled = true
        cardView.fillSuperview()
        
        let view = UIView()
        view.isUserInteractionEnabled = true
        cardView.addSubview(view)
        view.fillSuperview()
        
    }
    
    var article: ArticleProtocol? {
        didSet {
            guard let article = article else {
                return
            }
            setupViewModel(article)
        }
    }
    
    func setupViewModel(_ article: ArticleProtocol) {
        cardView.title = article.title
        cardView.backgroundIV.sd_setImage(with: article.coverURL)
        cardView.textColor = .white
        cardView.category = ""
        cardView.subtitle = ""

        //imageView.sd_setImage(with: article.coverURL, completed: nil)
        //cardView.backgroundImage = SDI
    }
}
