//
//  ProductsCollectionViewController
//  MVVM
//
//  Created by Кирилл on 11.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import UIKit
import Cards

class ArticlesCollectionController: UICollectionViewController, UICollectionViewDelegateFlowLayout, ArticlesView {
    
    var onFinish: (() -> Void)?
    var viewModel: ArticlesViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationBar()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.didUpdate = {[weak self] in
            self?.collectionView?.reloadData()
        }
    }
    
    private func setupCollectionView() {
        collectionView?.register(ArticleCollectionViewCell.self)
        collectionView?.registerClass(ArticleCardCollectionViewCell.self)
        collectionView?.backgroundColor = .white
        collectionView?.allowsSelection = true
        
        if let layout = collectionView?.collectionViewLayout as? GridLayout {
            layout.delegate = self
        }
    }
    
    private func setupNavigationBar() {
        guard let navigationController = self.navigationController else { return }
        let image = #imageLiteral(resourceName: "logo")
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navigationController.navigationBar.frame.size.width
        let bannerHeight = navigationController.navigationBar.frame.size.height
        
        let bannerX = bannerWidth / 2 - image.size.width / 2
        let bannerY = bannerHeight / 2 - image.size.height / 2
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemsCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let article = viewModel.item(at: indexPath.row)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let cardContent = storyboard.instantiateViewController(withIdentifier: "CardContent")

        let cell: ArticleCardCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.article = article
        cell.cardView.shouldPresent(cardContent, from: self, fullscreen: true)

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let cardContent = storyboard.instantiateViewController(withIdentifier: "CardContent")
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? ArticleCardCollectionViewCell else {
            return
        }
        
        cell.cardView.shouldPresent(cardContent, from: self, fullscreen: true)
        cell.cardView.delegate = self
        
        let frame = self.view.convert(cell.cardView.frame, from: cell)
        cell.cardView.didTapOnCard(withRect: frame)
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }

}

extension ArticlesCollectionController: GridLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
}

extension ArticlesCollectionController: CardDelegate {
    
    func cardDidTapInside(card: Card) {
        //        self.setTabBarVisible(visible: false, animated: true) { (bool) in
        //            self.navigationController?.setNavigationBarHidden(true, animated: true)
        //        }
        
    }
    
    func cardIsHidingDetail(card: Card) {
        
        // Delay 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        }
    }
    
}


