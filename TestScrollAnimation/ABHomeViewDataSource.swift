//
//  ABHomeViewDataSource.swift
//  TestScrollAnimation
//
//  Created by gongliang on 2016/12/28.
//  Copyright © 2016年 GL. All rights reserved.
//

import UIKit

let kFootViewShowHeight: CGFloat = 60

enum ABHomePageSection: Int {
    case mode = 0
    case control = 1
    case start =  2
    
    func rows() -> Int {
        switch self {
        case .control:
            return 2
        default:
            return 1
        }
    }
    
    func rowHeight() -> CGFloat {
        switch self {
        case .mode:
            return 100.0
        case .control:
            return 100.0
        default:
            return SCREEN_HEIGHT - CGFloat(100.0 * 3.0) - KNAVIGATION_BAR_HEIGHT - kFootViewShowHeight
        }
    }
    
    func cellIdentifier() -> String {
        switch self {
        case .mode:
            return "modeCell"
        case .control:
            return "controlCell"
        case .start:
            return "startCell"
        }
    }
}

struct ABHomeViewDataSource {
    func sections() -> [ABHomePageSection] {
        return [ABHomePageSection.mode, ABHomePageSection.control, ABHomePageSection.start]
    }
}
