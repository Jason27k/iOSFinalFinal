//
//  SongCell.swift
//  MusicDiscovery
//
//  Created by Jason Morales on 11/11/23.
//

import UIKit

class SongCell: UITableViewCell {

    @IBOutlet weak var rankView: UILabel!
    @IBOutlet weak var artistView: UILabel!
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var labelView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
