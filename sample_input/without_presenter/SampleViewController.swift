import RxSwift
import UIKit
import Whatever

protocol SamplePresentableListener: AnyObject {
  func viewDidLoad()
  func publicMethodOne()
  func publicMethodTwo()
  func publicMethodWithPara(para: String)
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

final class SampleViewController: UIViewController,
  SamplePresentable,
  SampleViewControllable {
  weak var listener: SamplePresentableListener?

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    listener?.viewDidLoad()
  }

  private func setupUI() {
    // Do something
  }

  // MARK: - @objc

  @objc
  private func objcMethod() {
    listener?.publicMethodOne()
  }
}

// MARK: Presentable

extension SampleViewController {
  func presenterMethodOne() {
    listener?.publicMethodOne()
  }

  func presenterMethodTwo() {
    privateMethodOne()
  }

  private func privateMethodOne() {
    listener?.publicMethodTwo()
  }

  func presenterMethodWithPara(para: String) {
    listener?.publicMethodWithPara(para: para)
  }
}
