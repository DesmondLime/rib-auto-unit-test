import UIKit
@testable import Whatever

// MARK: - SamplePresentableMock -

final class SamplePresentableMock: Presenter<SamplePresenterOutput>,
  SamplePresentable {
  var setListenerCount = 0
  func setListener(_ listener: SamplePresentableListener?) {
    setListenerCount += 1
  }

  var presentLoadingViewCount = 0
  func presentLoadingView() {
    presentLoadingViewCount += 1
  }

  var dismissLoadingViewCount = 0
  func dismissLoadingView() {
    dismissLoadingViewCount += 1
  }

  var presentDataCount = 0
  func presentData(
    title: String,
    subtitle: String
  ) {
    presentDataCount += 1
  }

  var setEmptyViewFullscreenCount = 0
  func setEmptyViewFullscreen(_ fullscreen: Bool) {
    setEmptyViewFullscreenCount += 1
  }
}

// MARK: - SampleViewControllerMock -

final class SampleViewControllerMock: SamplePresenterOutput,
  SampleViewControllable {
  var uiviewController: UIViewController = UIViewController()

  func viewDidClose() {}

  var listener: SamplePresentableListener?

  var showLoadingCount = 0
  func showLoading() {
    showLoadingCount += 1
  }

  var stopLoadingCount = 0
  func stopLoading() {
    stopLoadingCount += 1
  }

  var showDataCount = 0
  func showData(title: String,
                subtitle: String) {
    showDataCount += 1
  }

  var setEmptyViewFullscreenCount = 0
  func setEmptyViewFullscreen(_ fullscreen: Bool) {
    setEmptyViewFullscreenCount += 1
  }
}

// MARK: - SampleRoutingMock -

final class SampleRoutingMock: ViewableRouter<SampleInteractable, SampleViewControllable>,
  SampleRouting {
  var routeToSubRIBCount = 0
  func routeToSubRIB() {
    rrouteToSubRIBCount += 1
  }

  var detachCurrentChildCount = 0
  func detachCurrentChild() {
    detachCurrentChildCount += 1
  }
}

// MARK: - SampleDependencyMock -

final class SampleDependencyMock: SampleDependency {
  var apiService: APIService
  var taskIconProvider: TaskIconProviding

  init() {
    self.apiService = StubAPIService(configuration: NetworkConfiguration.mock)
    self.taskIconProvider = MockTaskIconProvider()
  }
}

// MARK: - SampleListenerMock -

final class SampleListenerMock: SampleListener {
  var sampleRIBDidEndOnExitCallCount = 0
  func sampleRIBDidEndOnExit() {
    sampleRIBDidEndOnExitCallCount += 1
  }
}
