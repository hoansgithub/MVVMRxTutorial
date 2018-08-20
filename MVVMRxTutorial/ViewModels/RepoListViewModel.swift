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
        
        loadDataAction = Action(workFactory: {[weak self] (input) -> Observable<[RepoViewModel]> in
            self?.isLoadingData.accept(true)
            guard let theSelf = self else { return Observable.never()}
            return theSelf.loadData()
        })
        
        loadDataAction.elements.subscribe {[weak self] (repoViewModels) in
            if let elements = repoViewModels.element {
                self?.repoViewModelList.accept(elements)
            } else {
                self?.repoViewModelList.accept([])
            }
            self?.isLoadingData.accept(false)
        }.disposed(by: bag)
        
        loadDataAction.errors.subscribe {[weak self](error) in
            print(error)
            self?.isLoadingData.accept(false)
        }.disposed(by: bag)
    }
    
    private func loadData() -> Observable<[RepoViewModel]> {
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
    
}
