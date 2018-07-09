//
//  APIProxy.swift
//  Ficus
//
//  Created by Yeral Yamil Castillo on 6/30/18.
//  Copyright © 2018 Yeral Yamil. All rights reserved.
//

import Foundation
import Alamofire

protocol APIProxy{
    func request(router: APIRouter, completion: @escaping (_ response: APIResponse) -> ()) -> APIRequest
}

protocol APIRouter: URLRequestConvertible{
    var baseUrl: String {get set}
    func asURLRequest() throws -> URLRequest
}

struct APIResponse {
    var response: DataResponse<Any>
}

struct APIRequest {
    var request: DataRequest
}
