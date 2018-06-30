//
//  AlamoFireAPIProxy.swift
//  Ficus
//
//  Created by Yeral Yamil Castillo on 6/30/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import Foundation
import Alamofire

struct AlamofireAPIProxy: APIProxy{
    
    var sessionManager = Alamofire.SessionManager.default
    func request(router: APIRouter, completion: @escaping (APIResponse) -> ()) -> APIRequest {
        let request = sessionManager.request(router).responseJSON { (dataResponse) in
            let apiResponse = APIResponse(response: dataResponse)
            completion(apiResponse)
        }
        return APIRequest (request: request)
    }
    
}
