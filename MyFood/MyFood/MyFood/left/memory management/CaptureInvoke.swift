//
//  CaptureInvoke.swift
//  MyFood
//
//  Created by qunlee on 16/8/24.
//  Copyright © 2016年 qunlee. All rights reserved.
//

import Foundation

class Parent {
    var name: String
    var child: Child?
    init(name: String) {
        self.name = name
    }
}
class Child {
    var name: String
    weak var parent: Parent!
    init(name: String, parent: Parent) {
        self.name = name
        self.parent = parent
    }
}