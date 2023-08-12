import UIKit

class BaseTabController: UIViewController,
                         TabInfoProvider {
    
    //MARK: - Properties
    var tabName: String
    
    //MARK: - Init
    init(tabName: String) {
        self.tabName = tabName
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

