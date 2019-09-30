//
//  Dataservice.swift
//  GetDataGitLoadMore
//
//
//  
//

import Foundation


class DataService {
    
    static let instance: DataService = DataService()
    
    var currentPage = 0
    var isLoadingData = false
    var totalPage : Int?
    
    func getDataApi(completedHandle: @escaping([Items]) -> Void) {
        if isLoadingData == true {return}
        if totalPage != nil && currentPage > totalPage! { return }
        isLoadingData = true
        
        guard let url = URL(string: "https://api.github.com/search/repositories?q=android&page=\(currentPage)&per_page=50&sort=stars") else { return }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            guard let aData = data else { return }
            do {
                let dataApi = try JSONDecoder().decode(DataGithub.self, from: aData)
                DispatchQueue.main.async {
                    self.totalPage = dataApi.total_count
                    self.currentPage += 1
                    self.isLoadingData = false
                    if let items = dataApi.items {
                        completedHandle(items)
                    }
                }
            } catch {
                print(error)
                self.isLoadingData = false
            }
        }.resume()
    }
}
