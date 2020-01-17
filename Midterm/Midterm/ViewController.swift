//
//  ViewController.swift
//  Midterm
//
//  Created by POYEH on 2020/1/17.
//  Copyright © 2020 POYEH. All rights reserved.
//

import UIKit
import KKBOXOpenAPISwift
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    
    var playlistNameArray = [String]()
    
    var pictureArray = [URL?]()
    
    let mainPictureUrl = URL(string: "https://i.kfs.io/playlist/global/26541395v266/cropresize/600x600.jpg")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableview.dataSource = self
        
        tableview.delegate = self
        
        mainImageView.kf.setImage(with: mainPictureUrl!)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        KKboxManager.getToken()
        
        getKkboxPlaylist()
        
    }
    
    func getKkboxPlaylist() {
        
        KKboxManager.fetchList(completion: { (result) in
        
            switch result {
                
            case.success(let playlists):
                
                
                for i in 0...19 {
                    
                    self.playlistNameArray.append(playlists.tracks[i].name)
                    
                    guard let album = playlists.tracks[i].album else { return }
                    
                    self.pictureArray.append(album.images[0].url)
                    
                }
                
                self.tableview.reloadData()
                
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
        
        guard let url = pictureArray[indexPath.row] else { return cell }
        
        cell.coverImageView.kf.setImage(with: url)
    
        return cell
        
    }
    
    
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
        
    }
    
}



