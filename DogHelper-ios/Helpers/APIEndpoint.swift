//
//  APIEndpoint.swift
//  G12
//
//  Created by Кирилл on 03.04.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation
import SwiftyJSON
import Moya

enum APIEndpoint {
    case sendQuestion(question: String)
}

extension APIEndpoint: TargetType {
    
    fileprivate var keys: Constants.RestApi.Request.Type {
        return Constants.RestApi.Request.self
    }
    
    fileprivate var endpointKey: String {
        return "b4aca810-8127-499f-ab68-8a7dc7769016"
    }
    
    fileprivate var kb: String {
        return "5ee5c367-6f49-4fea-ac9e-05d3a7e09aea"
    }
    
    var baseURL: URL {
        return URL(string: "https://doghelpermaker.azurewebsites.net")!
    }
    
    var path: String {
        var path = ""
        switch self {
        case .sendQuestion:
            path = "/qnamaker/knowledgebases/\(kb)/generateAnswer"
        }
        return path
    }
    
    var method: Moya.Method {
        switch self {
        case .sendQuestion:
            return .post
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        default:
            return URLEncoding.default
        }
    }
    
    var task: Task {
        switch self {
        case .sendQuestion(let question):
            let dict: [String: Any] = [keys.question: question]
            do {
                let json = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
                return .requestData(json)
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        return .requestParameters(parameters: [:], encoding: parameterEncoding)
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-type": "application/json", "Authorization": "EndpointKey \(endpointKey)"]
        }
    }
}
