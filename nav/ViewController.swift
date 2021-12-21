//
//  ViewController.swift
//  nav
//
//  Created by admin user on 2021-12-21.
//  Copyright © 2021 admin user. All rights reserved.
//

import UIKit
struct VideoModel{
    let caption : String
    let username: String
    let audioTrackingName: String
    let videoFileName: String
    let videoFileFormat: String
}
class ViewController: UIViewController {
    private var collectionView: UICollectionView?
    private var data = [VideoModel]()
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
            let model = VideoModel(caption: "Amazing video song", username: "@inder", audioTrackingName: "In Love Again", videoFileName: "video1", videoFileFormat: "mp4")
            data.append(model)
        
        let model1 = VideoModel(caption: "yuppee", username: "@inder", audioTrackingName: "songs", videoFileName: "video3", videoFileFormat: "mp4")
        data.append(model1)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
        collectionView?.isPagingEnabled = true
        collectionView?.dataSource = self
        view.addSubview(collectionView!)
        
        
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }

}
extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return data.count
}
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let model = data[indexPath.row]
        let model1 = data[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identifier, for: indexPath) as! VideoCollectionViewCell
        cell.configure(with: model)
        cell.configure(with: model1)
        return cell
    }
}

 
