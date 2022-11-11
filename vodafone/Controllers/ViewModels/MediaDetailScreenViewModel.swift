//
//  MediaDetailScreenViewModel.swift
//  vodafone
//
//  Created by canberk çığ on 9.11.2022.
//

import Foundation
import UIKit
import TrailerPlayer

class MediaDetailScreenViewModel: NSObject {
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var movieCoverImage: UIImageView!
    @IBOutlet weak var trailerView: UIView!

    var vc: UIViewController?
    var mediaData: Results?
    var segmentType: String? = "movie"
    
    @AutoLayout
    var playerView: TrailerPlayerView = {
        let view = TrailerPlayerView()
        view.enablePictureInPicture = true
        return view
    }()
    
    @AutoLayout
    private var controlPanel: ControlPanel = {
        let view = ControlPanel()
        return view
    }()
    
    @AutoLayout
    private var replayPanel: ReplayPanel = {
        let view = ReplayPanel()
        return view
    }()
    
    private let autoPlay = false
    private let autoReplay = false
    
    func setLayouts(vc: UIViewController, data: Results) {
        self.mediaData = data
        self.vc = vc
        vc.title = data.trackCensoredName
        
        if let price = data.collectionPrice {
            priceLabel.text = "\(price)" + " " + (data.currency ?? "")
        } else {
            priceLabel.text = "FREE"
        }
        
        if data.collectionArtistViewUrl != nil {
            artistName.underline(color: .systemGreen, font: .systemFont(ofSize: 15))
            artistName.isUserInteractionEnabled = true
            let addArtistNameTap = UITapGestureRecognizer(target: self, action: #selector(artistNameTapped))
            artistName.addGestureRecognizer(addArtistNameTap)
        }
        
        if data.collectionViewUrl != nil {
            movieName.underline(color: .systemGreen, font: .systemFont(ofSize: 15))
            movieName.isUserInteractionEnabled = true
            let addMovieNameTap = UITapGestureRecognizer(target: self, action: #selector(movieNameTapped))
            movieName.addGestureRecognizer(addMovieNameTap)
        }
        
        artistName.text = data.artistName
        movieName.text = data.trackName
        genreLabel.text = "\(data.primaryGenreName ?? "")" + " - " + "\(data.country ?? "")"
        movieDescription.text = data.longDescription
        if let image = data.artworkUrl100 {
            movieCoverImage.sd_setImage(with: URL(string: image))
        } else {
            movieCoverImage.image = UIImage()
        }
        
        trailerView.addSubview(playerView)
        playerView.leadingAnchor.constraint(equalTo: trailerView.leadingAnchor).isActive = true
        playerView.trailingAnchor.constraint(equalTo: trailerView.trailingAnchor).isActive = true
        playerView.heightAnchor.constraint(equalTo: playerView.widthAnchor, multiplier: 0.65).isActive = true
        if #available(iOS 11.0, *) {
            playerView.topAnchor.constraint(equalTo: trailerView.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            playerView.topAnchor.constraint(equalTo: trailerView.topAnchor).isActive = true
        }
        
        controlPanel.delegate = self
        playerView.addControlPanel(controlPanel)
        
        if !autoReplay {
            replayPanel.delegate = self
            playerView.addReplayPanel(replayPanel)
        }
        
        if !autoPlay {
            let button = UIButton()
            button.tintColor = .white
            button.setImage(UIImage(named: "play")?.withRenderingMode(.alwaysTemplate), for: .normal)
            playerView.manualPlayButton = button
        }
        
        self.playVideo()
    }
    
    @objc func artistNameTapped() {
        GlobalHelper.openLinkInSafari(self.vc ?? UIViewController(), url: mediaData?.collectionArtistViewUrl ?? "")
    }
    
    @objc func movieNameTapped() {
        GlobalHelper.openLinkInSafari(self.vc ?? UIViewController(), url: mediaData?.collectionViewUrl ?? "")
    }
    
    
    func playVideo() {
   
        guard let url = URL(string: mediaData?.previewUrl ?? "") else { return }
        let item = TrailerPlayerItem(
            url: url,
            thumbnailUrl: URL(string: mediaData?.artworkUrl100 ?? ""),
            autoPlay: autoPlay,
            autoReplay: autoReplay,
            mute: false)
        playerView.playbackDelegate = self
        playerView.set(item: item)
    }
    
}

extension MediaDetailScreenViewModel: TrailerPlayerPlaybackDelegate {
    
    func trailerPlayer(_ player: TrailerPlayer, didUpdatePlaybackTime time: TimeInterval) {
        controlPanel.setProgress(withValue: time, duration: playerView.duration)
    }
    
    private func trailerPlayer(_ player: TrailerPlayer, didChangePlaybackStatus status: TrailerPlayerPlaybackStatus) {
        controlPanel.setPlaybackStatus(status)
    }
}

extension MediaDetailScreenViewModel: ControlPanelDelegate {
    
    func controlPanel(_ panel: ControlPanel, didTapMuteButton button: UIButton) {
        playerView.toggleMute()
        playerView.autoFadeOutControlPanelWithAnimation()
    }
    
    func controlPanel(_ panel: ControlPanel, didTapPlayPauseButton button: UIButton) {
        if playerView.status == .playing {
            playerView.pause()
        } else {
            playerView.play()
        }
        playerView.autoFadeOutControlPanelWithAnimation()
    }
    
    func controlPanel(_ panel: ControlPanel, didTapFullscreenButton button: UIButton) {
        playerView.fullscreen(enabled: button.isSelected,
                              rotateTo: button.isSelected ? .landscapeRight: .portrait)
        playerView.autoFadeOutControlPanelWithAnimation()
    }
    
    func controlPanel(_ panel: ControlPanel, didTouchDownProgressSlider slider: UISlider) {
        playerView.pause()
        playerView.cancelAutoFadeOutAnimation()
    }
    
    func controlPanel(_ panel: ControlPanel, didChangeProgressSliderValue slider: UISlider) {
        playerView.seek(to: TimeInterval(slider.value))
        playerView.play()
        playerView.autoFadeOutControlPanelWithAnimation()
    }
}

extension MediaDetailScreenViewModel: ReplayPanelDelegate {
    
    func replayPanel(_ panel: ReplayPanel, didTapReplayButton: UIButton) {
        playerView.replay()
    }
}
