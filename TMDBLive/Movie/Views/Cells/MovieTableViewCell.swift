//
//  MovieTableViewCell.swift
//  TMDBLive
//
//  Created by Erwan Martin on 04/04/2022.
//

import UIKit
import WebKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse();
        
        titleLabel.text = nil;
        descriptionLabel.text = nil;
        coverImage.image = UIImage(named: "empty");
        // ici qu'on va reset les valeurs
    }
    
    func setupCell(title: String, subtitle: String, imageURL: String, duration: String) {
        titleLabel.text = title
        descriptionLabel.text = subtitle
        durationLabel.text = duration
        coverImage.load(
            url: URL(string: imageURL)!,
            placeholder: UIImage()
        );
    }
}
