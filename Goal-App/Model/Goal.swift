//
//  Goal.swift
//  Goal-App
//
//  Created by Abdelrahman Sobhy on 5/8/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import Foundation
import RealmSwift
class Goal: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var type : String = ""
    @objc dynamic var target : Int = 0
    @objc dynamic var progress : Int = 0
}
