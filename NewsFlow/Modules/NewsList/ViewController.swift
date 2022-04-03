//
//  ViewController.swift
//  NewsFlow
//
//  Created by Yeskendir Salgara on 30.03.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    var customView: NewsListView = NewsListView()
    
    var news: [News] = []
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        fetchNews()
    }

}

private extension ViewController {
    
    func configureView() {
        customView.tableView.dataSource = self
    }
    
    func fetchNews() {
        let baseURL = "https://newsapi.org/v2"
        let apiKey = "2d0dc8266d2e484b9b77d3f3b1d12372"
        let endPoint = "/top-headlines"
        let params = "?apiKey=\(apiKey)&country=US"
        let url = URL(string: "\(baseURL)\(endPoint)\(params)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                self.show(error: error)
                return
            }
            guard let data = data else { return }
            do {
                let news: NewsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                self.news = news.articles
                DispatchQueue.main.async {
                    self.customView.tableView.reloadData()    
                }
            } catch(let error) {
                self.show(error: error)
            }
        }
        session.resume()
    }
    
    func show(error: Error) {
        let alerVC = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        self.present(alerVC, animated: true)
    }
    
}


extension ViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableCell.reuseID) as! NewsTableCell
        let newsItem = news[indexPath.row]
        cell.set(data: newsItem)
        return cell
    }
    
    
}
