//
//  CustomNavigationBar.swift
//  TcsNews
//
//  Created by Dmitry L on 22/04/2017.
//  Copyright © 2017 Dmitry L. All rights reserved.
//

import UIKit
import Foundation

@IBDesignable

class XibWrapper: UIView
{
    @IBInspectable var xibName: String?

    override func awakeFromNib()
    {
        guard let name = self.xibName,
              let xib = Bundle.main.loadNibNamed(name, owner: nil),
              let xibView = xib[0] as? UIView
            else { return }

        xibView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(xibView)

        let viewsNames = ["xibView": xibView]
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[xibView]|", options: NSLayoutFormatOptions.alignAllCenterY, metrics: nil, views: viewsNames)
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[xibView]|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: viewsNames)

        self.addConstraints(horizontalConstraints)
        self.addConstraints(verticalConstraints)
    }
}
