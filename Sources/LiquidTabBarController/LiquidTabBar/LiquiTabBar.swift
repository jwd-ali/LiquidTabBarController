//
//  JDTabBar.swift
//  Pods-SOTabBar_Example
//
//  Created by Jawad Ali on 04/09/2020.
//

import UIKit
public protocol LTabBarDelegate: AnyObject {
    func tabBar(_ tabBar: LTabBar, didSelectTabAt index: Int)
}

public class LTabBar: UIView {
    private var shapeLayer : CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.fillColor = #colorLiteral(red: 0.9894880652, green: 0.3935522437, blue: 0.3954764307, alpha: 1)
        //        shape.strokeColor = UIColor.green.cgColor
        //        shape.lineWidth = 5
        return shape
    }()
    
    //MARK:- Public Properties
    open var tabBarTintColor: UIColor = #colorLiteral(red: 0.9894880652, green: 0.3935522437, blue: 0.3954764307, alpha: 1) {
        didSet {
            backgroundColor = tabBarTintColor
            setNeedsDisplay()
        }
    }
    
    public var circleSize: CGFloat = 60 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public var circleBorderWidth: CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var viewControllers = [UIViewController]() {
        didSet {
            guard !viewControllers.isEmpty else { return }
            
            DispatchQueue.main.async {
                self.drawTabs()
                self.didSelectTab(index: 0)
            }
        }
    }
    
    //MARK:- Views
    
    private lazy var stackView = UIStackViewFactory.createStackView(with: .horizontal, alignment: .center, distribution: .fillEqually, spacing: 0)
    
    private lazy var innerCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    //MARK:- delegate
    
    weak var delegate: LTabBarDelegate?
    
    //MARK:- Private properties
    
    private var selectedIndex: Int = 0
    private var previousSelectedIndex = 0
    
    //MARK:- initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = tabBarTintColor
        shapeLayer.fillColor = tabBarTintColor.cgColor
        setUp()
        
    }
    
    public override func draw(_ rect: CGRect) {
        setupConstraints()
        drawShapePath(holdingView: innerCircleView)
        backgroundColor = tabBarTintColor
        shapeLayer.fillColor = tabBarTintColor.cgColor
        
        
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touchArea = touches.first?.location(in: self).x else {
            return
        }
        let index = Int(floor(touchArea / tabWidth))
        didSelectTab(index: index)
    }
}

//MARK:- set upview and constraints
private extension LTabBar {
    func setUp() {
        setUpView()
        setupConstraints()
    }
    
    func setUpView() {
        innerCircleView.layer.addSublayer(shapeLayer)
        
        addSubview(innerCircleView)
        addSubview(stackView)
    }
    func setupConstraints() {
        innerCircleView.frame = CGRect(origin: CGPoint(x: 0, y: -circleSize), size: CGSize(width: circleSize*2, height: circleSize))
        
        stackView
            .alignAllEdgesWithSuperview()
    }
    
}

//MARK:- Add LTabBarItem in tabBar
extension LTabBar {
    private func drawTabs() {
        for  vc in viewControllers {
            let barView = LiquidTabBarItem(tabBarItem: vc.tabBarItem)
            
            barView
                .height(constant: stackView.bounds.maxY)
            
            self.stackView.addArrangedSubview(barView)
        }
    }
}

//MARK:- Touch Handling
extension LTabBar {
    
    var tabWidth: CGFloat {
        return (UIScreen.main.bounds.width / CGFloat(viewControllers.count))
    }
    
    var circleTransition: (startX:CGFloat, endX: CGFloat) {
        let startPoint_X = CGFloat(previousSelectedIndex) * CGFloat(tabWidth) - (tabWidth * 0.5)
        let endPoint_X = CGFloat(selectedIndex) * CGFloat(tabWidth) - (tabWidth * 0.5)
        return (startPoint_X,endPoint_X)
    }
    
    func didSelectTab(index: Int) {
        delegate?.tabBar(self, didSelectTabAt: index)
        if index + 1 == selectedIndex {return}
        
        previousSelectedIndex = selectedIndex
        selectedIndex  = index + 1
        
        innerCircleView.layer.aimateJelly(from: circleTransition.startX, endX: circleTransition.endX)
        animateTabItem(index: index)
    }
}
//MARK:- Animation shape
private extension LTabBar {
    
    func animateTabItem(index: Int) {
        self.stackView.arrangedSubviews.enumerated().forEach {
            guard let tabView = $1 as? LiquidTabBarItem else { return }
            ($0 == index ? tabView.animateTabSelected : tabView.animateTabDeSelect)()
        }
    }
}

private extension LTabBar {
    func drawShapePath(holdingView:UIView) {
        let bezierPath = UIBezierPath()
        
        bezierPath.move(to: CGPoint(x: 0, y: holdingView.bounds.maxY))
        bezierPath.addCurve(to: CGPoint(x: holdingView.bounds.midX * 0.4, y: holdingView.bounds.maxY * 0.8), controlPoint1: CGPoint(x: holdingView.bounds.midX * 0.1, y: holdingView.bounds.maxY   ), controlPoint2: CGPoint(x: holdingView.bounds.midX * 0.25, y: holdingView.bounds.maxY ))
        bezierPath.addQuadCurve(to: CGPoint(x: holdingView.bounds.midX + holdingView.bounds.midX * 0.6, y: holdingView.bounds.maxY * 0.8), controlPoint: CGPoint(x: holdingView.bounds.midX, y: 0))
        bezierPath.addCurve(to: CGPoint(x: holdingView.bounds.maxX, y: holdingView.bounds.maxY), controlPoint1: CGPoint(x:holdingView.bounds.midX + holdingView.bounds.midX * 0.75, y: holdingView.bounds.maxY   ), controlPoint2: CGPoint(x:holdingView.bounds.midX + holdingView.bounds.midX * 0.9, y: holdingView.bounds.maxY ))
        shapeLayer.path = bezierPath.cgPath
    }
}
