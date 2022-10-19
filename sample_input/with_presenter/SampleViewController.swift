import RxSwift
import UIKit
import Whatever

protocol SamplePresentableListener: AnyObject {
  func viewDidLoad()
  func publicMethodOne()
  func publicMethodTwo()
  func publicMethodWithPara(para: String)
}

final class SampleViewController: UIViewController,
  SamplePresenterOutput,
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

// MARK: Presenter Output

extension SampleViewController {
  func viewControllerMethodOne() {
    listener?.publicMethodOne()
  }

  func viewControllerMethodTwo() {
    privateMethodOne()
  }

  private func privateMethodOne() {
    listener?.publicMethodTwo()
  }

  func viewControllerMethodWithPara(para: String) {
    listener?.publicMethodWithPara(para: para)
  }
}
