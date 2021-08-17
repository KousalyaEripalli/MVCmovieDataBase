//
//  MovieTableViewCell.swift
//  MovieDatabase
//
//  Created by Kousalya Eripalli on 8/12/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var MovieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var ReleaseDate: UILabel!
    
    @IBOutlet weak var PopularityLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
