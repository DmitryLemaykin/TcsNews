//
//  ViewController.swift
//  TcsNews
//
//  Created by Dmitry L on 22/04/2017.
//  Copyright © 2017 Dmitry L. All rights reserved.
//

import UIKit
import Foundation

class NewsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var navigationBar: XibWrapper!
    @IBOutlet weak var tableView: UITableView!

    private var data: [News]?
    private var selectedNews: News?

    lazy var refreshControl: UIRefreshControl =
    {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)

        return refreshControl
    }()

    func handleRefresh(refreshControl: UIRefreshControl)
    {
        self.getData()

        refreshControl.endRefreshing()
    }

    private func getData()
    {
        TcsServiceManager.sharedInstance.getNews { (news) in
            self.setUpdatedNews(news)
        }
    }

    private func setUpdatedNews(_ updatedNews:[News])
    {
        DispatchQueue.main.async
        {
            [weak self] in
            self?.data = updatedNews

            self?.tableView.reloadData()
        }
    }

    // MARK: Controller lifecycle

    override func viewDidLoad()
    {
        super.viewDidLoad()

        let customNavigationBarView = self.navigationBar.subviews.first as! CustomNavigationBarView
        customNavigationBarView.hideBackArrow()

        self.tableView.addSubview(self.refreshControl)

        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 140

        // MARK: Alternative way via Notifications
        //self.registerForNotifications()
    }

//    private func registerForNotifications()
//    {
//        NotificationCenter.default.addObserver(self, selector: #selector(self.dataLoaded(_:)), name: TcsServiceManager.dataLoadedNotificationName, object: nil)
//    }

    // MARK: Alternative way via Notifications
    public func dataLoaded(_ notification: NSNotification)
    {
        DispatchQueue.main.async
        {
            [weak self] in
            self?.setUpdatedNews((notification.object as? NSDictionary)?["news"] as! [News])
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        print("Error: didReceiveMemoryWarning ");
    }

    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: UITableViewDataSource

    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return data?.count ?? 1;
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if data == nil || data?.count == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier:"pullCellReuseIdentifer")
            if (cell == nil)
            {
                print("Error: no pull cell");
            }

            return cell!
        }

        var cell = tableView.dequeueReusableCell(withIdentifier:"newsCellIdentifier") as? NewsTableViewCell
        if (cell == nil)
        {
            cell = NewsTableViewCell.instatiateFromItsXib();
        }

        // This code here because of dynamic cell height:
        // the table need to know cell hieght befor showing it
        let news = data![indexPath.row]
        cell?.configureWithNews(news)

        return cell!
    }

    // In the table no need to have dynamic height of cells
//    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
//    {
//        let newsCell = cell as? NewsTableViewCell
//
//        let news = data![indexPath.row]
//
//        newsCell?.configureWithNews(news)
//    }

    // MARK: UITableViewDelegate
    static let showContentSegueIdentifer = "showContentSegue"
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if data == nil { return }

        selectedNews = data![indexPath.row]

        self.performSegue(withIdentifier: NewsListViewController.showContentSegueIdentifer, sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == NewsListViewController.showContentSegueIdentifer
        {
            let destinationVC = segue.destination as! NewsDetailesViewController
            destinationVC.selectedNews = self.selectedNews!
        }
    }
}

