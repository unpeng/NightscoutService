//
//  Image.swift
//  DashKitUI
//
//  Created by Pete Schwamb on 2/7/20.
//  Copyright © 2020 LoopKit Authors. All rights reserved.
//

import SwiftUI

extension Image {
    init(frameworkImage name: String, decorative: Bool = false) {
        if decorative {
            self.init(decorative: name, bundle: Bundle.module)
        } else {
            self.init(name, bundle: Bundle.module)
        }
    }
}
