//
//  BaseVC.swift
//  Unsplash_with_storyboard_tutorial
//
//  Created by 장민석 on 2021/11/24.
//  Copyright © 2021 장민석. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    
    var vcTitle : String = "" {
        didSet {
            print("UserListVC - vcTitle didSet() called / vcTitle : \(vcTitle)")
            self.title = vcTitle
        }
    }
    
}
