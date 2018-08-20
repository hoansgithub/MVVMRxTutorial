//
//  RepoAPIClient.swift
//  MVVMRxTutorial
//
//  Created by Hoan Nguyen on 8/16/18.
//  Copyright © 2018 Hoan Nguyen. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
protocol RepoAPIClientProtocol {
    var  URL_REPO_LIST : String {get}
    func getRepoList(input : APIInput) -> Observable<[RepoEnt]>
}

class RepoAPIClient : APIClient, RepoAPIClientProtocol {
    
    var URL_REPO_LIST: String = "https://api.github.com/search/repositories?q=language:swift&per_page=10"
    
    func getRepoList(input: APIInput) -> Observable<[RepoEnt]> {
        return self.request(input)
            .observeOn(MainScheduler.instance)
            .map({ (wrapper : RepoListWrapperEnt) -> [RepoEnt] in
            return wrapper.repos ?? []
        })
            .share(replay: 1)
    }
    
}
