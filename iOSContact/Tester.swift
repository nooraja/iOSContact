//
//  Tester.swift
//  iOSContact
//
//  Created by Muhammad Noor on 06/09/2018.
//  Copyright © 2018 Muhammad Noor. All rights reserved.
//

import UIKit

class Tester: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jsonDecoding()
    }
    
    
    
    struct AnimeJsonStuff: Decodable {
        let data: [AnimeDataArray]
    }
    
    struct AnimeLinks: Codable {
        var selfStr   : String?
        
        private enum CodingKeys : String, CodingKey {
            case selfStr     = "self"
        }
    }
    struct AnimeAttributes: Codable {
        var createdAt   : String?
        
        private enum CodingKeys : String, CodingKey {
            case createdAt     = "createdAt"
        }
    }
    struct AnimeRelationships: Codable {
        var links   : AnimeRelationshipsLinks?
        
        private enum CodingKeys : String, CodingKey {
            case links     = "links"
        }
    }
    
    struct AnimeRelationshipsLinks: Codable {
        var selfStr   : String?
        var related   : String?
        
        private enum CodingKeys : String, CodingKey {
            case selfStr     = "self"
            case related     = "related"
        }
    }
    
    struct AnimeDataArray: Codable {
        let id: String?
        let type: String?
        let links: AnimeLinks?
        let attributes: AnimeAttributes?
        let relationships: [String: AnimeRelationships]?
        
        private enum CodingKeys: String, CodingKey {
            case id = "id"
            case type = "type"
            case links = "links"
            case attributes = "attributes"
            case relationships = "relationships"
        }
    }
    
    func jsonDecoding() {
        let jsonUrlString = "https://kitsu.io/api/edge/anime"
        
        guard let url = URL(string: jsonUrlString) else {return} //
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else {return}
            do {
                let animeJsonStuff =  try JSONDecoder().decode(AnimeJsonStuff.self, from: data)
                for anime in animeJsonStuff.data {
                    print(anime.id)
                    print(anime.type)
                    print(anime.links?.selfStr)
                    print(anime.attributes?.createdAt)
                    for (key, value) in anime.relationships! {
                        print(key)
                        print(value.links?.selfStr)
                        print(value.links?.related)
                    }
                }
            } catch let jsonErr {
                print("Error serializing json", jsonErr)
            }
            }.resume()
    }
    
//    jsonDecoding()
    

    
    
}
