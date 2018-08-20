//
//  BaseViewController.swift
//  MVVMRxTutorial
//
//  Created by Hoan Nguyen on 5/30/18.
//  Copyright © 2018 Hoan Nguyen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    }
    
    func initViews() {
        
    }

}
