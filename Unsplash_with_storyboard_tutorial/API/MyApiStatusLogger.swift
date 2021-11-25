//
//  MyApiStatusLogger.swift
//  Unsplash_with_storyboard_tutorial
//
//  Created by 장민석 on 2021/11/25.
//  Copyright © 2021 장민석. All rights reserved.
//

import Foundation
import Alamofire

final class MyApiStatusLogger : EventMonitor {
    
    let queue = DispatchQueue(label: "ApiLog")
    
//    func requestDidResume(_ request: Request) {
//
//        print("MyLogger - requestDidResume() called")
//        debugPrint(request)
//    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        
        guard let statusCode = request.response?.statusCode else { return }
        
        print("MyApiStatusLogger - statusCode : \(statusCode)")
        //debugPrint(request)
    }
    
}
