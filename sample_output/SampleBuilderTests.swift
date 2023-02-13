import Nimble
import Quick
@testable import Whatever

final class SampleBuilderTests: QuickSpec {
  override func spec() {
    describe("SampleBuilder") {
      var builder: SampleBuilder!

      beforeEach {
        let dependency = SampleDependencyMock()
        builder = SampleBuilder(dependency: dependency)
      }

      context("test build") {
        var listener: SampleListenerMock!
        var router: SampleRouting!
        var actionableItem: SampleActionableItem!
        var interactor: Interactable?

        beforeEach {
          listener = SampleListenerMock()
          let summary = builder.build(withListener: listener)
          router = summary.router
          actionableItem = summary.actionableItem
          interactor = router.interactable
        }

        it("should return a router") {
          expect(router).to(beAKindOf(SampleRouter.self))
        }

        it("should have a interactor with right type") {
          expect(interactor).toNot(beNil())
          expect(interactor).to(beAKindOf(SampleInteractor.self))
        }

        it("should return the interactor as an actionable item") {
          expect(actionableItem).to(beAKindOf(SampleInteractor.self))
        }

        it("should nest the view controller under a navigation controller") {
          expect(router.navigator).toNot(beNil())
        }

        it("should assign listener to interactor") {
          expect(interactor).to(beAKindOf(SampleInteractor.self))
          if let interactor = interactor as? SampleInteractor {
            expect(interactor.listener === listener).to(beTrue())
          }
        }
      }
    }
  }
}
