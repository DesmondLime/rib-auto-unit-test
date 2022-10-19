import RxSwift
import UIKit
import Whatever

protocol SampleRouting: ViewableRouting {
  func routeMethodWithPara(para1: String)
  func routeMethodWithoutPara()
}

protocol SampleListener: AnyObject {
  func listenerMethod()
}

final class SampleInteractor: PresentableInteractor<SamplePresentable>,
  SampleInteractable,
  SamplePresentableListener,
  SampleActionableItem {
  private var apiService: APIService
  weak var listener: SampleListener?

  init(
    apiService: APIService,
    listener: SampleListener,
    presenter: SamplePresentable
  ) {
    self.apiService = apiService
    self.listener = listener
    super.init(presenter: presenter)
    presenter.setListener(self)
  }

  override func didBecomeActive() {
    super.didBecomeActive()
  }

  override func willResignActive() {
    super.willResignActive()
  }
}

// MARK: some comments

extension SampleInteractor {
  func viewDidLoad() {
    privateMethodOne()
  }

  private func privateMethodOne() {
    presenter.presenterMethodOne()
    let request = SampleAPIRequest(
      para: "test"
    )
    apiService.send(request).subscribe(
      onNext: { [weak self] response in
        guard let self = self else { return }
        self.presenter.presenterMethodTwo()
        self.presenter.presenterMethodThree()

        self.presenter.presenterMethodWithPara(
          para: "test"
        )
      },
      onError: { [weak self] error in
        guard let self = self else { return }
        self.presenter.presenterMethodTwo()
        self.presenter.presenterMethodThree()
        self.presenter.presenterMethodFour()
      }
    ).disposeOnDeactivate(interactor: self)
  }

  func publicMethodOne() {
    presenter.presenterMethodFifth()
  }

  func publicMethodTwo(flag: Bool) {
    privateMethodTwo(flag: flag)
  }

  private func privateMethodTwo(flag: Bool) {
    if flag {
      presenter.presenterMethodSixth()
    } else {
      presenter.presenterMethodSeventh()
    }
  }
}

extension SampleInteractor {
  func publicMethodThree(para: Int) {
    switch para {
      case 1: listener?.listenerMethod();
      case 2: router?.routeMethodWithoutPara();
      default: break;
    }
  }
}
