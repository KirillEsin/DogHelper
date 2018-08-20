//
//  
//  Malmo
//
//  Created by Кирилл on 31.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol ArticlesViewModelProtocol: ViewModelOutput  {
    var itemsCount: Int { get }
    func item(at index: Int) -> ArticleProtocol
}

class ArticlesViewModel: BaseViewModel, ArticlesViewModelProtocol {

    var model: ArticlesModelProtocol
    
    init(model: ArticlesModelProtocol){
        self.model = model
        super.init()
        bindModel()
    }
    
    override func bindModel() {
        model.didUpdate = {[weak self] in
            self?.didUpdate?()
        }
    }
    
    var itemsCount: Int {
        return model.itemsCount
    }
    
    func item(at index: Int) -> ArticleProtocol {
        return model.item(at: index)
    }
    
}
