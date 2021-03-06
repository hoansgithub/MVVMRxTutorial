//
//  RepoListViewController.swift
//  MVVMRxTutorial
//
//  Created by Hoan Nguyen on 8/16/18.
//  Copyright © 2018 Hoan Nguyen. All rights reserved.
//

import UIKit
import Action
import RxSwift
import RxCocoa
class RepoListViewController: BaseViewController {

    private var tblRepo : UITableView!
    private var refreshControl: UIRefreshControl!
    fileprivate var viewModel : RepoListViewModel!
    
    
    static func createInstance(viewModel : RepoListViewModel) -> RepoListViewController {
        let controller = RepoListViewController()
        controller.viewModel = viewModel
        controller.automaticallyAdjustsScrollViewInsets = false
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "REPO"
        bindUIActions()
        viewModel.loadDataAction.execute("FIRST")
    }

    override func initViews() {
        super.initViews()
        tblRepo = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), style: .plain)
        tblRepo.contentInset = UIEdgeInsets.zero
        tblRepo.contentOffset = CGPoint.zero
        tblRepo.sectionHeaderHeight = 0.0
        self.view.addSubview(tblRepo)
        tblRepo.register(RepoCell.self, forCellReuseIdentifier: RepoCell.cellIdentifier)
        tblRepo.rowHeight = 92
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        tblRepo.addSubview(refreshControl)
        tblRepo.sendSubviewToBack(refreshControl)
        
        //constraints
        tblRepo.translatesAutoresizingMaskIntoConstraints = false
        tblRepo.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tblRepo.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tblRepo.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tblRepo.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    private func bindUIActions() {
        
        viewModel.repoViewModelList.asObservable().bind(to: tblRepo.rx.items(cellIdentifier: RepoCell.cellIdentifier, cellType: RepoCell.self)) { row, element, cell in
            cell.repoViewModel = element
        }.disposed(by: disposeBag)
        
        
        viewModel.isLoadingData.asDriver().drive(refreshControl.rx.isRefreshing).disposed(by: disposeBag)
        
        refreshControl.rx.bind(to: viewModel.loadDataAction, controlEvent: refreshControl.rx.controlEvent(.valueChanged)) { _ in
            return "REFRESH"
        }
        
        tblRepo.rx.itemSelected.subscribe(
            onNext : { [weak self] indexPath in
                self?.tblRepo.deselectRow(at: indexPath, animated: true)
        }
            ).disposed(by: disposeBag)
    }
}

