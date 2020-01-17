//
//  KKboxManager.swift
//  Midterm
//
//  Created by POYEH on 2020/1/17.
//  Copyright © 2020 POYEH. All rights reserved.
//

import Foundation
import KKBOXOpenAPISwift


enum Result<T> {
    
    case success(T)
    
    case failure(Error)
    
}

class KKboxManager {
    
    class func getToken() {
        
        let API = KKBOXOpenAPI(clientID: "c75d3f804056bb58c2ba76138eaf0c4d", secret: "52adc55686012cc6ce8039a13c790a0f")
    
        _ = try? API.fetchAccessTokenByClientCredential(callback: { (result) in
            
            switch result {
                
            case .error(let error):
                
                print(error)
                
            case .success(let kkboxToken):
                
                UserToken.share.kkboxToken = kkboxToken.accessToken
                
            }
        })
    }
    
    class func fetchList(completion: @escaping (Result<KKTrackList>) -> Void) {
        
        let API = KKBOXOpenAPI(clientID: "c75d3f804056bb58c2ba76138eaf0c4d", secret: "52adc55686012cc6ce8039a13c790a0f")
        
        _ = try? API.fetch(tracksInPlaylist: "DZrC8m29ciOFY2JAm3", territory: .taiwan, offset: 0, limit: 20, callback: { (result) in
            
            switch result {
                
            case .error(let error): completion(.failure(error))
                
            case.success(let playLists):
                    
                completion(.success(playLists))
                
            }
        })
        
    }
    
}


struct PostContent {
    
    var grant_type = "client_credentials"
    
    var client_id = "c75d3f804056bb58c2ba76138eaf0c4d"
    
    var client_secret = "52adc55686012cc6ce8039a13c790a0f"
    
    
}
