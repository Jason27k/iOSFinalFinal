//
//  ArtistCell.swift
//  MusicDiscovery
//
//  Created by Jason Morales on 11/14/23.
//

import UIKit

class ArtistCell: UITableViewCell {

    @IBOutlet weak var artistRank: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var artistImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
