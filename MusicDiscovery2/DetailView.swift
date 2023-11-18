//
//  DetailViewController.swift
//  MusicDiscovery
//
//  Created by Jason Morales on 11/14/23.
//

import UIKit
import Alamofire
import Nuke

class DetailViewController: UIViewController {
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var songImageView: UIImageView!

    var song: Song!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let imageURL = URL(string: song.imageURL) {
            Nuke.loadImage(with: imageURL, into: songImageView)
        } else {
            songImageView.image = UIImage(named: "placeholder")
        }

        titleLabel.text = song.name
        artistLabel.text = song.artists
        rankLabel.text = song.id
        playTrack(matching: song)
    }

    private func playTrack(matching song: Song) {
        print(Linker.appRemote!.isConnected)
        print("In here trying to play")
        let trackURI = song.songURI
        
        // Start playback using the player API
        Linker.appRemote?.playerAPI?.play(trackURI) { (_, error) in
            print("Made it in here")
            if let error = error {
                print("Error playing track: \(error.localizedDescription)")
            } else {
                print("Playing track with URI: \(trackURI)")
            }
        }
    }
}
