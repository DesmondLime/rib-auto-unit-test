//
//  SamplePresenter.swift
//  SampleApp
//
//  Created by desmond.zhong on 2022/10/16.
//

import UIKit
import Whatever

protocol SamplePresenterOutput: Presentable {
  var listener: SamplePresentableListener? { get set }
  func viewControllerMethodOne()
  func viewControllerMethodTwo()
  func viewControllerMethodWithPara(para: String)
}

protocol SamplePresentable: Presenter<SamplePresenterOutput> {
  func setListener(_ listener: SamplePresentableListener?)
  func presenterMethodOne()
  func presenterMethodTwo()
  func presenterMethodThree()
  func presenterMethodFour()
  func presenterMethodFifth()
  func presenterMethodSixth()
  func presenterMethodSeventh()
  func presenterMethodWithPara(para: String)
}

final class SamplePresenter: Presenter<SamplePresenterOutput>, SamplePresentable {
  func setListener(_ listener: SamplePresentableListener?) {
    viewController.listener = listener
  }

  func presenterMethodOne() {
    if true {
      viewController.viewControllerMethodOne()
    }
  }

  func presenterMethodWithPara(para: String) {
    viewController.viewControllerMethodWithPara(para: para)
  }

  func presenterMethodTwo() {
    if false {
      privateMethodOne()
    }
  }

  private func privateMethodOne() {
    viewController.viewControllerMethodTwo()
  }
}
