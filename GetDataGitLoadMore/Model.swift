//
//  Model.swift
//  GetDataGitLoadMore
//
//
//  
//

import Foundation

struct DataGithub : Decodable {
    var total_count: Int?
    var items: [Items]?
}

struct Items: Decodable {
    var id: Int
    var name: String
    var full_name: String
}
