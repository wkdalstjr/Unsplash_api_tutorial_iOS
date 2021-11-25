//
//  Constants.swift
//  Unsplash_with_storyboard_tutorial
//
//  Created by 장민석 on 2021/11/24.
//  Copyright © 2021 장민석. All rights reserved.
//

import Foundation

enum SEGUE_ID {
    static let USER_LIST_VC = "gotoUserListVC"
    static let PHOTO_COLLECTION_VC = "gotoPhotoCollectionVC"
}

enum API {
    static let BASE_URL : String = "https://api.unsplash.com/"
    
    static let CLIENT_ID : String = "2aohKprWQi90JvA8SStFHCELWbSWTuCHR0mqdCvioP8"
    
    
}

enum NOTIFICATION {
    enum API {
        static let AUTH_FAIL = "authentication_fail"
    }
}
