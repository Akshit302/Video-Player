//
//  ViewController.swift
//  VideoPlayer
//
//  Created by Akshit on 08/09/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var videoView: UIView!
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    var url:URL!
    
    var isPlaying: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        url = URL(string : "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8")
        player = AVPlayer(url: url!)
    
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resize
        videoView.layer.addSublayer(playerLayer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer.frame = videoView.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

        

    @IBAction func btnTappedPlay(_ sender: Any) {
    
    
        if isPlaying {
            player.pause()
            btnPlay.setTitle("◉", for: .normal)
            isPlaying = false
        } else {
            player.play()
            btnPlay.setTitle("◎", for: .normal)
            isPlaying = true
        }
    }
    
    @IBAction func btnFastForward(_ sender: Any) {
        guard let duration = player.currentItem?.duration else {
            return
        }
        let currentTime = CMTimeGetSeconds(player.currentTime())
        let newTime = currentTime + 5.0
        if newTime < (CMTimeGetSeconds(duration) - 5.0) {
            let time: CMTime = CMTimeMake(value: Int64(newTime * 1000), timescale: 1000)
            player.seek(to: time)
        }
    }
    @IBAction func btnGoBackwards(_ sender: Any) {
        
        let currentTime = CMTimeGetSeconds(player.currentTime())
        var newTime = currentTime - 5.0
        if newTime < 0 {
            newTime = 0
        }
        let time: CMTime = CMTimeMake(value: Int64(newTime * 1000), timescale: 1000)
        player.seek(to: time)
    }
}

