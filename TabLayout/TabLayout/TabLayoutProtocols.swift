import Foundation

protocol TabsDelegate: AnyObject {
    func tabChanged(tab: Int)
}

protocol TabInfoProvider: AnyObject {
    var tabName: String {get set}
}

protocol BaseTabDelegate: AnyObject {
    var controllers: [BaseTabController] {get set}
    
    func setControllers(controllers: [BaseTabController])
}
