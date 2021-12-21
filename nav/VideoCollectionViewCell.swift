//
//  VideoCollectionViewCell.swift
//  nav
//
//  Created by admin user on 2021-12-21.
//  Copyright © 2021 admin user. All rights reserved.
//

import UIKit
import AVFoundation
protocol VideoCollectionViewCellDelegate:AnyObject {
    func didTapLikeButton(with model: VideoModel)
    func didTapCommentButton(with model: VideoModel)
    func didTapShareButton(with model: VideoModel)
    func didTapProfileButton(with model: VideoModel)
}
class VideoCollectionViewCell: UICollectionViewCell {
    static let identifier = "VideoCollectionViewCell"
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    private let audioLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    private let profileButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        
        return button
        
    }()
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "arrowshape.turn.up.right.fill"), for: .normal)
        return button
    }()
    private let commentButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "bubble.left.fill"), for: .normal)
        return button
    }()
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        return button
    }()
    private let videoContainer = UIView()
    weak var delegate: VideoCollectionViewCellDelegate?
    var player: AVPlayer?
    private var model: VideoModel?
    override init(frame: CGRect) {
        super.init(frame:frame)
        contentView.backgroundColor = .black
        contentView.clipsToBounds = true
        addSubviews()
    }
    private func addSubviews() {
        contentView.addSubview(videoContainer)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(captionLabel)
        contentView.addSubview(audioLabel)
        contentView.addSubview(profileButton)
          contentView.addSubview(likeButton)
          contentView.addSubview(commentButton)
          contentView.addSubview(shareButton)
        likeButton.addTarget(self,action: #selector(didTapLikeButton), for: .touchDown)
           shareButton.addTarget(self,action: #selector(didTapShareButton), for: .touchDown)
           commentButton.addTarget(self,action: #selector(didTapCommetButton), for: .touchDown)
           profileButton.addTarget(self,action: #selector(didTapProfileButton), for: .touchDown)
        self.likeButton.tintColor = .white
        self.commentButton.tintColor = .white
        self.shareButton.tintColor = .white
        self.profileButton.tintColor = .white
        videoContainer.clipsToBounds = true
        contentView.sendSubviewToBack(videoContainer)
    }
    
    @objc private func didTapLikeButton(){
        guard let model = model else{return}
        delegate?.didTapLikeButton(with: model)
    }
    @objc private func didTapCommetButton(){
        guard let model = model else{return}
        delegate?.didTapCommentButton(with: model)
    }
    @objc private func didTapShareButton(){
        guard let model = model else{return}
        delegate?.didTapCommentButton(with: model)
    }
    @objc private func didTapProfileButton(){
        guard let model = model else{return}
        delegate?.didTapCommentButton(with: model)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        videoContainer.frame = contentView.bounds
        let size = contentView.frame.size.width/7
        let width = contentView.frame.size.width
        let height = contentView.frame.size.height-100
        shareButton.frame = CGRect(x: width-size, y: height-(size*4)-30, width: size, height: size)
         commentButton.frame = CGRect(x: width-size, y: height-(size*5)-50, width: size, height: size)
         likeButton.frame = CGRect(x: width-size, y: height-(size*7)-30, width: size, height: size)
         profileButton.frame = CGRect(x: width-size, y: height-(size*9)-30, width: size-2, height: size)
        usernameLabel.frame = CGRect(x: 5, y: height-150, width: width-size-10, height: 50)
         captionLabel.frame = CGRect(x: 5, y: height-80, width: width-size-10, height: 50)
         audioLabel.frame = CGRect(x: 5, y: height-100, width: width-size-10, height: 50)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        captionLabel.text = nil
        audioLabel.text = nil
        usernameLabel.text = nil
    }
    public func configure(with model: VideoModel){
        self.model = model
        configureVideo()
        captionLabel.text = model.caption
        audioLabel.text = model.audioTrackingName
        usernameLabel.text = model.username
    }
    
    private func configureVideo(){
        guard let model = model else {
            return
        }
        guard let path = Bundle.main.path(forResource: model.videoFileName, ofType: model.videoFileFormat) else {
         
              return
              
          }
        
          player = AVPlayer(url: URL(fileURLWithPath: path))
          let playerView = AVPlayerLayer()
          playerView.player = player
        playerView.frame = contentView.bounds
        playerView.videoGravity = .resizeAspectFill
          videoContainer.layer.addSublayer(playerView)
          player?.volume = 0
          player?.play()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
