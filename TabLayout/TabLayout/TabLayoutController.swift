import UIKit

class TabLayoutController: UIViewController,
                            BaseTabDelegate {
    
    //MARK: - Properties
    var controllers: [BaseTabController] = []
    
    private var segmentWidth: CGFloat = 0
    private var selectedTab = 0
    private var titleName: String
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    private lazy var buttonsStack = UIStackView()
    private lazy var segmentBackgroundView: UIView = {
       let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 1
        view.layer.masksToBounds = true
        return view
    }()
    private lazy var selectedSegmentView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 1
        view.layer.masksToBounds = true
        return view
    }()
    private var layoutViewController = TabsController(transitionStyle: .scroll,
                                                      navigationOrientation: .horizontal)
    
    //MARK: - Init
    init(titleName: String) {
        self.titleName = titleName
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    //MARK: - Setup Views
    private func setupViews() {
        
        view.backgroundColor = .clear
        titleLabel.text = titleName
        buttonsStack.axis = .horizontal
        buttonsStack.distribution = .fillEqually
        view.addSubview(titleLabel)
        view.addSubview(buttonsStack)
        view.addSubview(segmentBackgroundView)
        
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 72).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        
        buttonsStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24).isActive = true
        buttonsStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        buttonsStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        
        segmentBackgroundView.topAnchor.constraint(equalTo: buttonsStack.bottomAnchor, constant: 24).isActive = true
        segmentBackgroundView.widthAnchor.constraint(equalTo: buttonsStack.widthAnchor).isActive = true
        segmentBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentBackgroundView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
    }
    
    //MARK: - Base Tab Delegates
    func setControllers(controllers: [BaseTabController]) {
        self.controllers = controllers
        
        layoutViewController.setControllers(controllers: self.controllers)
        layoutViewController.tabDelegate = self
        
        setupTabButtons()
        setupLayout()
        setupSelectedView()
    }
    
    private func setupLayout(){
        layoutViewController.view.frame = view.bounds
        view.addSubview(layoutViewController.view)
        addChild(layoutViewController)
        
        layoutViewController.didMove(toParent: self)
        
        layoutViewController.view.topAnchor.constraint(equalTo: segmentBackgroundView.bottomAnchor, constant: 24).isActive = true
        layoutViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        layoutViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        layoutViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    private func setupTabButtons() {
        for (index, vc) in self.controllers.enumerated() {
            let button = UIButton()
            button.tag = index
            button.setTitleColor( index == 0 ? .blue : .gray, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 16)
            button.setTitle(vc.tabName, for: .normal)
            button.addTarget(self,
                             action: #selector(tapTab(button:)),
                             for: .touchUpInside)
            buttonsStack.addArrangedSubview(button)
        }
    }
    
    private func setupAllDisabled() {
        for index in 0..<buttonsStack.subviews.count{
            (buttonsStack.subviews[index] as? UIButton)?.setTitleColor(.gray,
                                                                      for: .normal)
        
        }
    }
    
    private func setupSelectedView() {
        segmentWidth = (UIScreen.main.bounds.width / CGFloat(self.controllers.count)) - CGFloat(10)
        view.addSubview(selectedSegmentView)
        selectedSegmentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        selectedSegmentView.centerYAnchor.constraint(equalTo: segmentBackgroundView.centerYAnchor).isActive = true
        selectedSegmentView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        selectedSegmentView.widthAnchor.constraint(equalToConstant: segmentWidth).isActive = true
        
    }
    
    private func navigateToTab(index: Int) {
        UIView.animate(withDuration: 0.3) {
            self.selectedSegmentView.transform = CGAffineTransform(translationX: 0 + self.segmentWidth*CGFloat(self.selectedTab), y: 0)
            self.setupAllDisabled()
            (self.buttonsStack.subviews[index] as? UIButton)?.setTitleColor(.blue,
                                                                            for: .normal)
        }
    }
    
    //MARK: - Actions
    @objc
    private func tapTab(button: UIButton) {
        guard button.tag != selectedTab else { return }
        
        let isNext = button.tag>selectedTab
        selectedTab = button.tag
        
        navigateToTab(index: selectedTab)
        layoutViewController.setCurrentController(index: self.selectedTab,
                                                  isNext: isNext)
    }
    
}

extension TabLayoutController: TabsDelegate {
    func tabChanged(tab: Int) {
        guard tab != selectedTab else {return}
        self.selectedTab = tab
        self.navigateToTab(index: tab)
    }
}


