//
//  Data+Html.swift
//  TcsNews
//
//  Created by Dmitry L on 23/04/2017.
//  Copyright © 2017 Dmitry L. All rights reserved.
//

import Foundation
import UIKit

extension Data
{
    var attributedString: NSAttributedString?
    {
        do {
            return try NSAttributedString(data: self, options:[NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
        }

        return nil
    }
}
