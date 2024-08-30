//
//  CGFloat+Extension.swift
//  MyRecipeBook
//
//  Created by Iryna Riabchuk on 28.08.2024.
//

import UIKit

extension CGFloat {
    
    var scalableWidth: CGFloat {
        let baseWidth: CGFloat = 393 // default width, relative to which scaling occurs (iPhone 15 Pro)
        return self * UIScreen.main.bounds.width / baseWidth
    }
    
    var scalableHeight: CGFloat {
        let baseHeight: CGFloat = 852 // default height, relative to which scaling occurs (iPhone 15 Pro)
        return self * UIScreen.main.bounds.height / baseHeight
    }
}
