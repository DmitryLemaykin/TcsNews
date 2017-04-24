//
//  CustomNavigationBarUIView.swift
//  TcsNews
//
//  Created by Dmitry L on 22/04/2017.
//  Copyright © 2017 Dmitry L. All rights reserved.
//

import UIKit

protocol CustomNavigationBarDelegate
{
    func backButtonTap()
}

class CustomNavigationBarView: UIView
{
    
    @IBOutlet weak var backTapArea: UIView!

    public var delegate: CustomNavigationBarDelegate?

    @IBAction func backArrowTap(_ sender: Any) {
        delegate?.backButtonTap()
    }

    public func hideBackArrow()
    {
        backTapArea.isHidden = true
    }
}
