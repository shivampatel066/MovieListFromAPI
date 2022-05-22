//
//  MovieTableViewCell.swift
//  MovieList
//
//  Created by Shivam Patel on 22/05/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    var movieObject:MovieModel?
    
    @IBOutlet weak var movieNameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    public func configureUI() {
        if let movieObject = movieObject {
            self.movieNameLabel.text = movieObject.title
        }
    }
}
