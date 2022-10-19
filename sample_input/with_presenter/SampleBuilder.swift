import UIKit
import Whatever

protocol SampleDependency: Dependency {
  var apiService: APIServicing { get }
}

final class SampleComponent: Component<SampleDependency>, SampleSubDependency {
  var apiService: APIServicing { dependency.apiService }
  var locationService: LocationServicing { AppDependency.shared.locationService }
}

// MARK: - Builder

protocol SampleBuildable: Buildable {
  func build(
    withListener listener: SampleListener
  ) -> (router: SampleRouting, actionableItem: SampleActionableItem)
}

final class SampleBuilder: Builder<SampleDependency>,
  SampleBuildable {
  override init(dependency: SampleDependency) {
    super.init(dependency: dependency)
  }

  func build(
    withListener listener: SampleListener
  ) -> (router: SampleRouting, actionableItem: SampleActionableItem) {
    let component = SampleComponent(dependency: dependency)
    let viewController = SampleViewController()
    let presenter = SamplePresenter(viewController: viewController)
    let interactor = SampleInteractor(
      apiService: dependency.apiService,
      listener: SampleListener,
      presenter: presenter
    )
    interactor.listener = listener
    let router = SampleRouter(
      interactor: interactor,
      viewController: viewController,
      subBuilder: SampleSubBuilder(dependency: component)
    )
    return (router, interactor)
  }
}
