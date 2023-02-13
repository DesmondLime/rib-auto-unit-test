import Nimble
import Quick
@testable import Whatever

final class SampleInteractorSpec: QuickSpec {
  override func spec() {
    describe("SampleInteractor") {
      var interactor: SampleInteractor!
      var apiService: MockAPIService!
      var presenter: SamplePresentableMock!
      var viewController: SampleViewControllerMock!
      var listener: SampleListenerMock!

      beforeEach {
        apiService = MockAPIService()
        viewController = SampleViewControllerMock()
        listener = SampleListenerMock()
        presenter = SamplePresentableMock(
          viewController: viewController)
        interactor = SampleInteractor(
          apiService: apiService,
          presenter: presenter
        )
        interactor.listener = listener
      }

      it("should set set interactor as the listener of presenter output") {
        expect(presenter.setListenerCount)
          .to(equal(1))
      }

      context("test viewWillAppear") {
        context("fetch data success") {
          beforeEach {
            apiService.sendRequestCallsCount = 0
            apiService.requestHandler = { _ in
              return MockAPIService.WrappedResponse(
                response: SampleAPIResponse(
                  title: "title",
                  subtitle: "subtitle"
                ),
                error: nil
              )
            }
            interactor.viewWillAppear()
          }

          it("should send API request") {
            expect(presenter.presentLoadingViewCount).to(equal(1))
            expect(apiService.sendRequestCallsCount).to(equal(1))
          }

          it("should present data") {
            expect(presenter.dismissLoadingViewCount).to(equal(1))
            expect(presenter.presentDataCount).to(equal(1))
          }
        }

        context("fetch data twice success") {
          beforeEach {
            apiService.sendRequestCallsCount = 0
            apiService.requestHandler = { _ in
              return MockAPIService.WrappedResponse(
                response: SampleAPIResponse(
                  title: "title",
                  subtitle: "subtitle"
                ),
                error: nil
              )
            }
            interactor.viewWillAppear()
            interactor.viewWillAppear()
          }

          it("should send API request twice") {
            expect(presenter.presentLoadingViewCount).to(equal(2))
            expect(apiService.sendRequestCallsCount).to(equal(2))
          }

          it("should present data twice") {
            expect(presenter.dismissLoadingViewCount).to(equal(2))
            expect(presenter.presentDataCount).to(equal(2))
          }
        }

        context("fetch data failed") {
          beforeEach {
            apiService.sendRequestCallsCount = 0
            apiService.requestHandler = { _ in
              return MockAPIService.WrappedResponse(
                response: nil,
                error: MockAPIService.defaultError
              )
            }
            interactor.viewWillAppear()
          }

          it("should send API request") {
            expect(presenter.presentLoadingViewCount).to(equal(1))
            expect(apiService.sendRequestCallsCount).to(equal(1))
          }

          it("should present empty view") {
            expect(presenter.dismissLoadingViewCount).to(equal(1))
            expect(presenter.setEmptyViewFullscreenCount).to(equal(1))
          }
        }
      }

      context("test routing") {
        var router: SampleRoutingMock!

        beforeEach {
          router = SampleRoutingMock(
            interactor: interactor,
            viewController: viewController
          )
          interactor.router = router
        }

        context("test didExitSubRIB") {
          beforeEach {
            interactor.didExitSubRIB()
          }

          it("should detach current child") {
            expect(router.detachCurrentChildCount).to(equal(1))
            expect(router.children.count).to(equal(0))
          }
        }

        context("test exit current RIB page") {
          beforeEach {
            interactor.viewDidClose()
          }

          it("should notify listener") {
            expect(listener.sampleRIBDidEndOnExitCallCount).to(equal(1))
          }
        }
      }
    }
  }
}
