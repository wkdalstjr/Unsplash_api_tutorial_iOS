//
//  Photo.swift
//  Unsplash_with_storyboard_tutorial
//
//  Created by 장민석 on 2021/11/29.
//  Copyright © 2021 장민석. All rights reserved.
//

import Foundation

struct Photo : Codable {
    var thumbnail : String
    var username : String
    var likesCount : Int
    var createdAt : String
}
