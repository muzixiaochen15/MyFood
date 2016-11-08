//
//  SwiftWritePractice.swift
//  MyFood
//
//  Created by qunlee on 16/10/17.
//  Copyright © 2016年 qunlee. All rights reserved.
//

import UIKit

class SwiftWritePractice: NSObject {
    //常量和变量的名字不能包含空白字符、数学符号、箭头、保留的（或者无效的）Unicode 码位、连线和制表符。也不能以数字开头，尽管数字几乎可以使用在名字其他的任何地方
    var hello: String = "hello world"
    func log(string: String) {
        //元素//分离器 //结束符
        print("items", separator: "separator", terminator: "terminator")
    }
}
