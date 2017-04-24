//
//  TableViewCell.swift
//  TcsNews
//
//  Created by Dmitry L on 22/04/2017.
//  Copyright © 2017 Dmitry L. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell
{
    @IBOutlet weak var infoTypeImage: UIImageView!
    @IBOutlet weak var shortDescription: UILabel!
    @IBOutlet weak var publicationDate: UILabel!

    private lazy var dateFormatter: DateFormatter =
    {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd hh:mm:ss"
        return f
    }()

    class func instatiateFromItsXib() -> NewsTableViewCell!
    {
        let cell = Bundle.main.loadNibNamed("NewsTableViewCell", owner: self, options: nil)?.first as! NewsTableViewCell

        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero

        return cell
    }

    public func configureWithNews(_ news: News)
    {
        // More simple way, but also working
//        do
//        {
//            self.shortDescription.text = try news.text.convertHtmlSymbols()
//        }
//        catch
//        {
//            self.shortDescription.text = news.text
//        }

        let attributedText = news.text.data(using: String.Encoding.utf8, allowLossyConversion: true)?.attributedString!.mutableCopy() as! NSMutableAttributedString

        let font = UIFont( name: "Helvetica", size: 16.0)!
        let range = NSRange(location:0, length:(attributedText.length))

        attributedText.addAttribute(NSFontAttributeName, value: font, range: range)

        self.shortDescription.attributedText = attributedText

        self.publicationDate.text = self.dateFormatter.string(from: news.publicationDate as Date)

        let image: UIImage?
        switch news.bankInfoTypeId {
        case 1:
            image = #imageLiteral(resourceName: "GLogo130x130")
            break
        case 2:
            image = #imageLiteral(resourceName: "WALogo130x130")
            break
        case 3:
            image = #imageLiteral(resourceName: "TWLogo1300x130")
            break
        case 4:
            image = #imageLiteral(resourceName: "LILogo130x130")
            break
        case 5:
            image = #imageLiteral(resourceName: "ISLogo130x130")
            break
        case 6:
            image = #imageLiteral(resourceName: "YTLogo130x130")
            break
        case 7:
            image = #imageLiteral(resourceName: "FBLogo130x130")
            break
            
        default:
            // Default image
            image = #imageLiteral(resourceName: "UKLogo130x130")
        }

        self.infoTypeImage.image = image
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
