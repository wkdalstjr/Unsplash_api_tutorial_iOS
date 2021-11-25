//
//  MyAlamofireManager.swift
//  Unsplash_with_storyboard_tutorial
//
//  Created by 장민석 on 2021/11/25.
//  Copyright © 2021 장민석. All rights reserved.
//

import Foundation
import Alamofire

final class MyAlamofireManager {

    // 싱글턴 적용
    static let shared = MyAlamofireManager()
    
    // 인터셉터
    let interceptors = Interceptor(interceptors:
                        [
                            BaseInterceptor()
                        ])
    
    // 로거 설정
    let monitors = [MyLogger(), MyApiStatusLogger()] as [EventMonitor]
    
    // 세션 설정
    var session : Session
    
    private init() {
        session = Session(interceptor: interceptors, eventMonitors: monitors)
    }
    
    
    
}
