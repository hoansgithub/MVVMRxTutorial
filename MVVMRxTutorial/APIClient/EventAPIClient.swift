//
//  EventAPIClient.swift
//  MVVMRxTutorial
//
//  Created by Hoan Nguyen on 8/16/18.
//  Copyright © 2018 Hoan Nguyen. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
protocol EventAPIClientProtocol {
    func eventList(input : APIInput) -> Observable<[EventEnt]>
}

class EventAPIClient:APIClient ,EventAPIClientProtocol {
    func eventList(input: APIInput) -> Observable<[EventEnt]> {
        return self.requestArray(input)
            .observeOn(MainScheduler.instance)
            .share(replay: 1)
    }
}
