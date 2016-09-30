//
//  GithubUsersViewControllerProvider.swift
//  PagingDataController
//
//  Created by FOLY on 8/12/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import PagingDataController
import Alamofire

struct GithubUsersProvider: PagingProviderProtocol {
    
    //custom pageSize here
    var pageSize: Int = 36
    
    
    /*******************************************************************************************************
     * Replace type of Parameters and Return model to custom type in your app
     * Example:
     * func loadData(_ parameters: <#ParamterType#>?, page: Int, completion: (([<#ReturnType#>], Error?) -> ())?)
     *******************************************************************************************************/
    
    func loadData(_ parameters: AnyObject?, page: Int, completion: (([Dictionary<String, AnyObject>], Error?) -> ())?) {
        
        let apiPath = "https://api.github.com/search/users?q=apple&page=\(page+1)&per_page=\(pageSize)"
        Alamofire.request(apiPath, method: .get).responseJSON { (response) in
            var error: Error? = response.result.error
            var result: [[String: AnyObject]] = []
            
            defer {
                completion?(result, error)
            }
            
            guard let data = (response.result.value as? [String: AnyObject]) else {
                return
            }
            result = data["items"] as! [[String: AnyObject]]
        }
    }
    
}
