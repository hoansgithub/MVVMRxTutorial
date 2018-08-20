//
//  RepoCell.swift
//  MVVMRxTutorial
//
//  Created by Hoan Nguyen on 8/16/18.
//  Copyright © 2018 Hoan Nguyen. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SDWebImage
class RepoCell: BaseTableViewCell {

    private(set) var imvAvatar: UIImageView!
    private(set) var lblRepoName : UILabel!
    private(set) var lblStarCount : UILabel!
    private(set) var lblFolkCount : UILabel!
    
    var repoViewModel : RepoViewModel! {
        didSet {
            if (repoViewModel) != nil {
                didBindRepoViewModel()
            }
        }
    }
    
    private func didBindRepoViewModel() {
        //bind data to view
        repoViewModel.avatarURLString.asObservable().bind {[weak self] (url) in
            self?.imvAvatar.sd_setImage(with: URL(string: url), placeholderImage: nil, options: .refreshCached, completed: nil)
        }.disposed(by: self.disposeBag)
    }
    
    override func initViews() {
        
        self.backgroundColor = UIColor.white
        
        imvAvatar = UIImageView()
        imvAvatar.translatesAutoresizingMaskIntoConstraints = false
        imvAvatar.contentMode = .scaleToFill
        imvAvatar.layer.masksToBounds = true
        addSubview(imvAvatar)
        
        lblRepoName = UILabel()
        lblRepoName.font = UIFont.boldSystemFont(ofSize: 10)
        lblRepoName.textColor = UIColor.black
        lblRepoName.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lblRepoName)
        
        lblStarCount = UILabel()
        lblStarCount.font = UIFont.systemFont(ofSize: 8)
        lblStarCount.textColor = UIColor.black
        lblStarCount.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lblStarCount)
        
        lblFolkCount = UILabel()
        lblFolkCount.font = UIFont.systemFont(ofSize: 8)
        lblFolkCount.textColor = UIColor.black
        lblFolkCount.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lblFolkCount)
        
        
        /*
         view constraints
         */
        
        imvAvatar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        imvAvatar.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        imvAvatar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        imvAvatar.widthAnchor.constraint(equalTo: imvAvatar.heightAnchor).isActive = true
        imvAvatar.backgroundColor = UIColor.red
        
    }
    
}
