//
//  JDTabBarItem.swift
//  JDTabBarController
//
//  Created by Jawad Ali on 04/09/2020.
//

import UIKit

public class LiquidTabBarItem: UIView {
    
    //MARK:- Properties
    private let image: UIImage
    
    
    
    private var imageCenterYConstraint : NSLayoutConstraint?
    private var imageWidthConstraint : NSLayoutConstraint?
    private var imageHeightConstraint : NSLayoutConstraint?
    
    public var imageSelectedTintColor: UIColor = .white
    
    open var imageTintColor: UIColor = #colorLiteral(red: 1, green: 0.6804677844, blue: 0.6831721663, alpha: 1)
    open var animationDuration: Double = 0.6
    open var badgeColor: UIColor?
    open var badgeValue: String?
    var imageSize: CGFloat = 25
    
    //MARK:- Views
    
    
    private lazy var imageView = UIImageViewFactory.createImageView(mode: .scaleAspectFit, image: image, tintColor: imageTintColor)
    
    //MARK:- initialiser
    
    init(tabBarItem item: UITabBarItem, tintColor:UIColor = #colorLiteral(red: 1, green: 0.6804677844, blue: 0.6831721663, alpha: 1)) {
        
        
        guard let selecteImage = item.image else {
            fatalError("You should set image to all view controllers")
        }
        
        self.imageTintColor = tintColor
        self.image = selecteImage.withRenderingMode(.alwaysTemplate)
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK:- setup View
private extension LiquidTabBarItem {
    func setup() {
        setupViews()
        setupConstraints()
    }
    func setupViews() {
        addSubview(imageView)
        
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
    }
    func setupConstraints() {
        
        imageView
            .centerHorizontallyInSuperview()
        
        imageCenterYConstraint = imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        imageCenterYConstraint?.isActive = true
        
        imageWidthConstraint = imageView.widthAnchor.constraint(equalToConstant: imageSize)
        imageWidthConstraint?.isActive = true
        
        imageHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: imageSize)
        imageHeightConstraint?.isActive = true
        
        
    }
}

//MARK:- Select / DeSelect item
internal extension LiquidTabBarItem {
    func animateTabSelected() {
        
        imageCenterYConstraint?.constant = -30
        imageView.tintColor = imageSelectedTintColor
        imageHeightConstraint?.constant = imageSize + 10
        imageWidthConstraint?.constant = imageSize + 10
        UIView.animate(withDuration: animationDuration) {
            self.layoutIfNeeded()
        }
    }
    
    func animateTabDeSelect() {
        imageCenterYConstraint?.constant = -10
        imageView.tintColor = imageTintColor
        imageHeightConstraint?.constant = imageSize
        imageWidthConstraint?.constant = imageSize
        UIView.animate(withDuration: animationDuration, animations: {
            self.layoutIfNeeded()
        }) { _ in
            self.layoutIfNeeded()
        }
    }
}
