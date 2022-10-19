import Whatever

protocol SampleInteractable: Interactable, SampleSubListener {
  var router: SampleRouting? { get set }
  var listener: SampleListener? { get set }
}

protocol SampleViewControllable: ViewControllable {}

final class SampleRouter: ViewableRouter<SampleInteractable, SampleViewControllable>,
  SampleRouting {
  private let subBuilder: SampleSubBuildable

  init(interactor: SampleInteractable,
       viewController: SampleViewControllable,
       subBuilder: SampleSubBuildable) {
    self.subBuilder = subBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }

  func routeMethodWithPara(para1: String) {

  }

  func routeMethodWithoutPara() {
    
  }
}
