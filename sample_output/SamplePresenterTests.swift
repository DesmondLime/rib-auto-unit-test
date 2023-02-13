import Nimble
import Quick
@testable import Whatever

final class SamplePresenterSpec: QuickSpec {
  override func spec() {
    describe("SamplePresenter") {
      var presenter: SamplePresenter!
      var viewController: SampleViewControllerMock!

      beforeEach {
        viewController = SampleViewControllerMock()
        presenter = SamplePresenter(viewController: viewController)
      }

      context("test set listener") {
        beforeEach {
          let apiService = MockAPIService()
          let interactor = SampleInteractor(
            apiService: apiService,
            presenter: presenter
          )
          presenter.setListener(interactor)
        }

        it("should set listener for viewController") {
          expect(viewController.listener).notTo(beNil())
        }
      }

      context("test presentLoadingView") {
        beforeEach {
          presenter.presentLoadingView()
        }

        it("should let viewController showLoading") {
          expect(viewController.showLoadingCount).to(equal(1))
        }
      }

      context("test dismissLoadingView") {
        beforeEach {
          presenter.dismissLoadingView()
        }

        it("should let viewController stopLoadingView") {
          expect(viewController.stopLoadingCount).to(equal(1))
        }
      }

      context("test presentData") {
        beforeEach {
          presenter.presentData(
            title: "title",
            subtitle: "subtitle"
          )
        }

        it("should let viewController showData") {
          expect(viewController.showDataCount).to(equal(1))
        }
      }

      context("test setEmptyViewFullscreen") {
        beforeEach {
          presenter.setEmptyViewFullscreen(true)
        }

        it("should let viewController setEmptyViewVisibility") {
          expect(viewController.setEmptyViewFullscreenCount).to(equal(1))
        }
      }
    }
  }
}
