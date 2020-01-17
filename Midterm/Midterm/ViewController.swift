//
//  ViewController.swift
//  Midterm
//
//  Created by POYEH on 2020/1/17.
//  Copyright © 2020 POYEH. All rights reserved.
//

import UIKit
import KKBOXOpenAPISwift

class ViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    var playlistNameArray = [String]()
    
    var pictureArray = [URL?]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableview.dataSource = self
        
        tableview.delegate = self
        
        KKboxManager.getToken()
        
        getKkboxPlaylist()
        
    }
    
    func getKkboxPlaylist() {
        
        KKboxManager.fetchList(completion: { (result) in
        
            switch result {
                
            case.success(let playlists):
                
                
                for i in 0...19 {
                    
                    self.playlistNameArray.append(playlists.tracks[i].name)
                    
                    self.pictureArray.append(playlists.tracks[i].url)
                    
                }
                
                print(self.playlistNameArray)
                
                print(self.pictureArray)
                
            case .failure(let error): print(error)
                
            }
        
        })
        
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return playlistNameArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! DetailTableViewCell
        
        cell.nameLabel.text = playlistNameArray[indexPath.row]
        
        return cell
        
    }
    
    
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
        
    }
    
}



