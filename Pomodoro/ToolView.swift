//
//  ToolView.swift
//  Pomodoro
//
//  Created by yongyou on 2020/9/15.
//  Copyright © 2020 yongyou. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

extension UIView {
    func allSubviews() -> [UIView] {
        var res = self.subviews
        for subview in self.subviews {
            let riz = subview.allSubviews()
            res.append(contentsOf: riz)
        }
        return res
    }
}


struct Tool {
    static func showTabBar() {
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.allSubviews().forEach({ (v) in
            if let view = v as? UITabBar {
                view.isHidden = false
            }
        })
    }

    static func hiddenTabBar() {
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.allSubviews().forEach({ (v) in
            if let view = v as? UITabBar {
                view.isHidden = true
            }
        })
    }
}
struct ShowTabBar: ViewModifier {
    func body(content: Content) -> some View {
        return content.padding(.zero).onDisappear {
            Tool.showTabBar()
        }
    }
}

struct HiddenTabBar: ViewModifier {
    func body(content: Content) -> some View {
        return content.padding(.zero).onDisappear {
            Tool.hiddenTabBar()
        }
    }
}

extension View {
    func showTabBar() -> some View {
        return self.modifier(ShowTabBar())
    }
    func hiddenTabBar() -> some View {
        return self.modifier(HiddenTabBar())
    }
}
