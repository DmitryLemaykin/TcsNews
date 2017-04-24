//
//  NewsDetailesViewController.swift
//  TcsNews
//
//  Created by Dmitry L on 24/04/2017.
//  Copyright © 2017 Dmitry L. All rights reserved.
//

import UIKit

class NewsDetailesViewController: UIViewController, CustomNavigationBarDelegate
{
    @IBOutlet weak var navigationBar: XibWrapper!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var content: UILabel!

    public var selectedNews: News?

    override func viewDidLoad()
    {
        super.viewDidLoad()

        let customNavigationBarView = self.navigationBar.subviews.first as! CustomNavigationBarView
        customNavigationBarView.delegate = self

        self.getData()
    }

    private func getData()
    {
        TcsServiceManager.sharedInstance.getContentFor((selectedNews?.id)!, callBackClosure:
        {
            datalis in

            DispatchQueue.main.async
                {
                    [weak self] in

                    let attributedTextTitle = datalis?.title.data(using: String.Encoding.utf8, allowLossyConversion: true)?.attributedString!.mutableCopy() as! NSMutableAttributedString

                    let titleParagraphStyle = NSMutableParagraphStyle()
                    titleParagraphStyle.alignment = .center

                    attributedTextTitle.addAttribute(NSFontAttributeName,  value: UIFont( name: "Helvetica-Bold", size: 20.0)!, range: NSRange(location:0, length:(attributedTextTitle.length)))

                    attributedTextTitle.addAttribute(NSParagraphStyleAttributeName, value:titleParagraphStyle, range: NSRange(location:0, length:(attributedTextTitle.length)))

                    self?.titleLabel.attributedText = attributedTextTitle

                    let attributedTextContent = datalis?.content.data(using: String.Encoding.utf8, allowLossyConversion: true)?.attributedString!.mutableCopy() as! NSMutableAttributedString

                    attributedTextContent.addAttribute(NSFontAttributeName, value: UIFont( name: "Helvetica", size: 16.0)!, range: NSRange(location:0, length:(attributedTextContent.length)))
                    
                    self?.content.attributedText = attributedTextContent
            }

        })
    }

    func backButtonTap()
    {
        navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
