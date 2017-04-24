//
//  String+Html.swift
//  TcsNews
//
//  Created by Dmitry L on 23/04/2017.
//  Copyright © 2017 Dmitry L. All rights reserved.
//

import UIKit
import Foundation

extension String
{
    func convertHtmlSymbols() throws -> String?
    {
        guard let data = data(using: .utf8) else { return nil }

        return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil).string
    }
}
