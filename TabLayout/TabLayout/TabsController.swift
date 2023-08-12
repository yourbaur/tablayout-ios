import UIKit

final class TabsController: UIPageViewController {
    
    private (set) var tabControllers: [UIViewController] = []
    private var currentIndex: Int = 0
    weak var tabDelegate: TabsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        if let firstViewController = tabControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    func setControllers(controllers: [UIViewController]) {
        tabControllers = controllers
    }
    func setCurrentController(index: Int,
                              isNext: Bool) {
        if tabControllers.count>index{
            setViewControllers([tabControllers[index]],
                               direction: isNext ? .forward : .reverse,
                               animated: true,
                               completion: nil)
        }
    }
}

// MARK: UIPageViewControllerDataSource
extension TabsController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = tabControllers.firstIndex(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = tabControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return tabControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = tabControllers.firstIndex(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard tabControllers.count > previousIndex else {
            return nil
        }
       
        return tabControllers[previousIndex]
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if finished {
            if let vc = pageViewController.viewControllers?[0] {
                guard let viewControllerIndex = tabControllers.firstIndex(of: vc) else {
                    return
                }
                tabDelegate?.tabChanged(tab: viewControllerIndex)
            }
        }
    }
}
