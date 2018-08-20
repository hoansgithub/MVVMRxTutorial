//
//  RepoViewModel.swift
//  MVVMRxTutorial
//
//  Created by Hoan Nguyen on 8/17/18.
//  Copyright © 2018 Hoan Nguyen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RepoViewModel {
    
    private var repo : RepoEnt
    
    private(set) var avatarURLString : BehaviorRelay<String>
    private(set) var repoName : BehaviorRelay<String>
    private(set) var starCount : BehaviorRelay<Int>
    private(set) var folkCount : BehaviorRelay<Int>
    
    init(repo : RepoEnt) {
        self.repo = repo
        
        self.avatarURLString = BehaviorRelay<String>(value: self.repo.avatarURLString ?? "")
        self.repoName = BehaviorRelay<String>(value: self.repo.name ?? "")
        self.starCount = BehaviorRelay<Int>(value: self.repo.starCount)
        self.folkCount = BehaviorRelay<Int>(value: self.repo.folkCount)
    }
}
