//
//  HomeTableTableViewController.swift
//  Twitter
//
//  Created by Jonah Tjandra on 3/11/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class HomeTableTableViewController: UITableViewController {
    
    var tweetArray = [NSDictionary]()
    var numberOfTweets: Int!
    let myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 120
        getTweets()
        myRefreshControl.addTarget(self, action: #selector(getTweets), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
    }
    
    @objc func getTweets() {
        let getTweetPath = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numberOfTweets = 20
        let params = ["count" : numberOfTweets]
        TwitterAPICaller.client?.getDictionariesRequest(url: getTweetPath, parameters: params as [String : Any], success: { (tweets: [NSDictionary]) in
            self.tweetArray.removeAll()
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
            self.myRefreshControl.endRefreshing()
        }, failure: { Error in
            print(Error)
        })
    }
    
    func getMoreTweets() {
        let getTweetPath = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numberOfTweets += 10
        let params = ["count" : numberOfTweets]
        TwitterAPICaller.client?.getDictionariesRequest(url: getTweetPath, parameters: params as [String : Any], success: { (tweets: [NSDictionary]) in
            self.tweetArray.removeAll()
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
        }, failure: { Error in
            print(Error)
        })
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetArray.count {
            getMoreTweets()
        }
    }

    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
        self.dismiss(animated: true, completion: nil)
    }
     
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCellTableViewCell
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        cell.tweetName.text = user["name"] as? String
        cell.tweetLabel.text = tweetArray[indexPath.row]["text"] as? String
        let imagePath = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imagePath!)
        if let imageData = data {
            cell.tweetImage.image = UIImage(data: imageData)
        }
        cell.configure()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetArray.count
    }
}
