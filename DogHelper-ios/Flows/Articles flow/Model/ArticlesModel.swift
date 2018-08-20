//
//  
//  Malmo
//
//  Created by Кирилл on 31.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

protocol ArticlesModelProtocol: Model {
    var itemsCount: Int { get }
    func item(at index: Int) -> ArticleProtocol
}

class ArticlesModel: BaseModel, ArticlesModelProtocol {
    
    var articles: [ArticleProtocol] {
        didSet {
            didUpdate?()
        }
    }
    
    override init(dataManager: DataManagerProtocol) {
        self.articles = []
        super.init(dataManager: dataManager)
        getArticles()
    }
    
    func item(at index: Int) -> ArticleProtocol {
        return articles[index]
    }
    
    var itemsCount: Int {
        return articles.count
    }
    
    func getArticles() {
        dataManager.getArticles(lastId: "") { [weak self] (result) in
            switch result {
            case .success(let articles):
                self?.articles = articles
            case .failure(_):
                break
            }
        }
    }
}
