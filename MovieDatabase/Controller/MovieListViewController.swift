//
//  ViewController.swift
//  MovieDatabase
//
//  Created by Kousalya Eripalli on 8/12/21.
//

import UIKit
import NVActivityIndicatorView

class MovieListViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var objMovieModel:modelMovieData?
    var originalMovieData: [Results]?
    
    var searchBarText = ""
    
    @IBOutlet weak var SearchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
 override func viewDidLoad() {
        super.viewDidLoad()
        
    
        //NVActivityIndicatorView()
       // SearchData = modelMovieData()
        objMovieModel = modelMovieData()
        //calling api
    activityIndicator.startAnimating()
        let objNetworking = Networking()
    
        objNetworking.response(url: Constant.baseURL.rawValue + Constant.api_key.rawValue) { modelData in
            print(modelData)
            self.objMovieModel = modelData
            self.originalMovieData = modelData.results
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
         
        }
     
    }
   
   
}
extension MovieListViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objMovieModel?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as? MovieTableViewCell
        movieCell?.titleLabel.text = objMovieModel?.results?[indexPath.row].original_title ??  ""
        movieCell?.ReleaseDate.text = objMovieModel?.results?[indexPath.row].release_date ?? ""
        movieCell?.PopularityLabel.text = "\(objMovieModel?.results?[indexPath.row].popularity ?? 0.0) "
        
        
        //Load Image
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: Constant.image_url_path.rawValue + (self.objMovieModel?.results?[indexPath.row].backdrop_path)!) {
                   let data = try? Data(contentsOf: url)
                   if let datac = data {
                       DispatchQueue.main.async {
                           // moviees depending on search
                        movieCell?.MovieImage.image = UIImage(data: datac)
                          
                       }
                   }
               }
           }
        
        
       

        return movieCell ?? UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
    
    
}
var searchData = [String]()
var SData = false

extension MovieListViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        if searchBar.text?.count ?? 0 < searchBarText.count {
            //Reset movie array before delegate
            objMovieModel?.results = originalMovieData
            self.tableView.reloadData()

        }
        

        searchBarText = searchBar.text ?? ""
        searchData()
    }
    
    func searchData(){

        var movieIndex = 0
        var iterations = 0
        if searchBarText != "" {

            //Operation search and delete
            //Loops thru all movies of movie array
            for movie in objMovieModel?.results ?? [Results]() {
                print("Data Count: \(objMovieModel?.results?.count ?? 0)")
                print("Movie Index Remove @ \(movieIndex)")
                //Reset values upon new movie index
                var letterIndex = 0
                var matching = false

                //Loops thru all letters of movie title
                for searchLetter in searchBarText {

                    //Comparing letters
                    if Array(movie.original_title ?? "")[letterIndex] == searchLetter {

                        matching = true
                    }else{

                        matching = false
                        break

                    }

                    //Dont Increment if index is larger than count
                    if letterIndex < searchBarText.count{

                        letterIndex += 1

                    }
                }

                //If search does not match movie title, remove that movie from array
                if matching == false {
                    if objMovieModel?.results?.count ?? 0 > 0 {
                        objMovieModel?.results?.remove(at: movieIndex)
                        let indexPath = IndexPath(item: movieIndex, section: 0)
                        tableView.deleteRows(at: [indexPath], with: .fade)
                        print("Movie Removed!")

                    }
                    
                }else{

                    //Dont Increment if index is larger than count or not matching
                    if movieIndex + 1 < objMovieModel?.results?.count ?? 0 {

                        movieIndex += 1

                    }
                }
                iterations += 1
                print("Iteraion: \(iterations)")
            }

        }

    }
}
