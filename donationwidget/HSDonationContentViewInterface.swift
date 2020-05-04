//
//  ContentViewInterface.swift
//  SwiftUI-Test
//
//  Created by Tr1Fecta on 04/05/2020.
//  Copyright © 2020 Tr1Fecta. All rights reserved.
//

import Foundation
import SwiftUI

struct ViewMaker : View {
    var body: some View {
        HSDonationContentView()
    }
}

@objcMembers public class HSDonationContentViewInterface: NSObject {
    @objc public func makeContentView() -> UIViewController {
        let contentView = ViewMaker()
        return UIHostingController(rootView: contentView);
    }
}
