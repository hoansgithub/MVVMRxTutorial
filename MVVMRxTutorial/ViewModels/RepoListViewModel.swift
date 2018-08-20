//
//  RepoListViewModel.swift
//  MVVMRxTutorial
//
//  Created by Hoan Nguyen on 8/17/18.
//  Copyright © 2018 Hoan Nguyen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Action

class RepoListViewModel {
    
    private let bag = DisposeBag()
    
    private(set) var isLoadingData = BehaviorRelay(value: false)
    private let apiClient : RepoAPIClientProtocol
    private(set) var repoViewModelList : BehaviorRelay<[RepoViewModel]>
    private(set) var loadDataAction: Action<String, [RepoViewModel]>!
    
    init(apiClient : RepoAPIClientProtocol) {
        self.apiClient = apiClient
        self.repoViewModelList = BehaviorRelay<[RepoViewModel]>(value: [])
    }
    
    func loadData() -> Observable<[RepoViewModel]> {
        isLoadingData.accept(true)
        let input = APIInput(urlString: apiClient.URL_REPO_LIST, params: nil, extHeaders: nil, requestType: .get)
        let  observable = apiClient.getRepoList(input: input).map { (repos) -> [RepoViewModel] in
            var res = [RepoViewModel]()
            for repo in repos {
                res.append(RepoViewModel(repo: repo))
            }
            
            return res
        }
        
        return observable
    }
    
    func fetchData() {
        isLoadingData.accept(true)
        let input = APIInput(urlString: apiClient.URL_REPO_LIST, params: nil, extHeaders: nil, requestType: .get)
        let  observable = apiClient.getRepoList(input: input).map { (repos) -> [RepoViewModel] in
            var res = [RepoViewModel]()
            for repo in repos {
                res.append(RepoViewModel(repo: repo))
            }
            
            return res
        }
        
        let disposable = observable.subscribe(onNext: { [weak self](repoViewModels) in
            self?.repoViewModelList.accept(repoViewModels)
            self?.isLoadingData.accept(false)
        }, onError: { [weak self](error) in
            self?.isLoadingData.accept(false)
            print(error)
        })
        
        disposable.disposed(by: self.bag)

    }
    
}
