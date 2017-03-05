//
//  ChartElement.swift
//  sandbox
//
//  Created by omochimetaru on 2017/03/06.
//  Copyright © 2017年 sonson. All rights reserved.
//

import CoreGraphics

public enum ChartElement {
    case line(LineGraph)
    case scatter(ScatterGraph)
    
    func computeViewport() -> CGRect {
        switch self {
        case .line(let line):
            return line.computeViewport()
        case .scatter(let scatter):
            return scatter.computeViewport()
        }
    }
}
