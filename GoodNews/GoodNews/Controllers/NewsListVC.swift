//
//  NewsListVC.swift
//  GoodNews
//
//  Created by Hiram Castro on 10/10/20.
//

import UIKit

class NewsListVC: UITableViewController {
    
    private var articlesListVM: ArticleListVM?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        fetchArticles()
    }
    
    private func fetchArticles() {
        getNews { [weak self] (error, articles) in
            guard let self = self else { return }
            if let error = error {
                print("DEBUG error \(error)")
            } else {
                guard let newsArticles = articles else { return }
                self.articlesListVM = ArticleListVM(articles: newsArticles.articles)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    private func getNews(completion: @escaping ((DataError?, Article?) -> Void)) {
        let url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=2bd9df50a6534aefb255a41f91cafda7"
        JSONParser.shared.downloadData(of: Article.self, from: URL(string: url)!) { (result) in
            switch result {
            case .failure(let error):
                completion(error as? DataError, nil)
                break
            case .success(let articles):
                completion(nil, articles as Any as? Article)
                break
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.articlesListVM?.numberOfSections ?? 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.articlesListVM?.numberOfRowsInSection(section) ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as? ArticleCell else { return UITableViewCell() }
        guard let newsListVM = self.articlesListVM?.articleAtIndex(indexPath.row) else { return UITableViewCell() }
        cell.titleLabel.text = newsListVM.title
        cell.descriptionLabal.text = newsListVM.description
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
