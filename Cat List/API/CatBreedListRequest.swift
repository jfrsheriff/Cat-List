//
//  CatBreedListRequest.swift
//  Cat List
//
//  Created by Jaffer Sheriff U on 22/10/22.
//

import Foundation

struct CatBreedListRequest : APIRequestProtocol {
    
    var page: Int = 0
        
    var path: String{
        "/v1/breeds"
    }
    
    var shouldIncludeAuthenticationToken: Bool{
        false
    }
    
    var urlQuery : [String : String]{
        var dict : [String : String] = [:]
        dict[APIConstants.apiKey] = APIConstants.apiValue
        return dict
    }
    
}
