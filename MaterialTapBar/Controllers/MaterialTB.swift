//
//  MaterialTB.swift
//  Hometap
//
//  Created by Daniel Soto on 7/16/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit

@IBDesignable
public class MaterialTB: UIViewController {
    private(set) public static var currentTabBar: MaterialTB?
    private(set) public static var tabBarLoaded: Bool = false
    
    @IBInspectable var initialViewController: Int = 1 {
        didSet {
            initialViewController = min(initialViewController, 5)
        }
    }
    @IBInspectable var tabBarHeigth: CGFloat = 65
    @IBInspectable var selectedTint: UIColor = .blue
    @IBInspectable var idleTint: UIColor = .lightGray
    @IBInspectable var tabBarBackgroundColor: UIColor = .white
    @IBInspectable var fontSize: CGFloat = 12 {
        didSet {
            if let f = UIFont(name: fontFamily, size: fontSize) {
                self.font = f
            } else {
                self.font = UIFont.systemFont(ofSize: fontSize)
            }
        }
    }
    @IBInspectable var fontFamily: String = "" {
        didSet {
            if let f = UIFont(name: fontFamily, size: fontSize) {
                self.font = f
            } else {
                self.font = UIFont.systemFont(ofSize: fontSize)
            }
        }
    }
    
    private var font: UIFont = UIFont.systemFont(ofSize: 12)
    private var mainView: UIView!
    private var tabBarBackground: UIView!
    private var snackView: UIView!
    private var buttonsStackView: UIStackView!
    private var imagesStackView: UIStackView!
    private var labelsStackView: UIStackView!
    
    private var snackHeigth: NSLayoutConstraint!
    
    private var images: [Int:UIImageView] = [:]
    private var labels: [Int:UILabel] = [:]
    private var buttons: [Int: UIButton] = [:]
    private var animationConstraints: [Int: NSLayoutConstraint] = [:]
    
    private var selectedIndex = -1
    
    private var viewControllers: [Int:MaterialViewController] = [:]
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure views
        // TABBAR
        tabBarBackground = UIView()
        tabBarBackground.backgroundColor = tabBarBackgroundColor
        tabBarBackground.translatesAutoresizingMaskIntoConstraints = false
        // Buttons Stack
        buttonsStackView = UIStackView()
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 10
        buttonsStackView.alignment = .fill
        buttonsStackView.distribution = .fill
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        tabBarBackground.addSubview(buttonsStackView)
        // Images Stack
        imagesStackView = UIStackView()
        imagesStackView.axis = .horizontal
        imagesStackView.spacing = 10
        imagesStackView.alignment = .fill
        imagesStackView.distribution = .fill
        imagesStackView.translatesAutoresizingMaskIntoConstraints = false
        tabBarBackground.insertSubview(imagesStackView, belowSubview: buttonsStackView)
        // Labels Stack
        labelsStackView = UIStackView()
        labelsStackView.axis = .horizontal
        labelsStackView.spacing = 10
        labelsStackView.alignment = .top
        labelsStackView.distribution = .fill
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        tabBarBackground.insertSubview(labelsStackView, belowSubview: imagesStackView)
        // Labels Constraint
        let cLabelsHeight = NSLayoutConstraint(item: labelsStackView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25)
        self.labelsStackView.addConstraint(cLabelsHeight)
        // Tabbar Constraints
        let cTabHeigth = NSLayoutConstraint(item: tabBarBackground, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: tabBarHeigth)
        // Buttons Stack Positioning
        let cButtonsTop = NSLayoutConstraint(item: buttonsStackView, attribute: .top, relatedBy: .equal, toItem: tabBarBackground, attribute: .top, multiplier: 1, constant: 10)
        let cButtonsLeft = NSLayoutConstraint(item: buttonsStackView, attribute: .leading, relatedBy: .equal, toItem: tabBarBackground, attribute: .leading, multiplier: 1, constant: 0)
        let cButtonsRight = NSLayoutConstraint(item: buttonsStackView, attribute: .trailing, relatedBy: .equal, toItem: tabBarBackground, attribute: .trailing, multiplier: 1, constant: 0)
        // Images Stack Positioning
        let cImagesTop = NSLayoutConstraint(item: buttonsStackView, attribute: .top, relatedBy: .equal, toItem: imagesStackView, attribute: .top, multiplier: 1, constant: 0)
        let cImagesWidth = NSLayoutConstraint(item: imagesStackView, attribute: .width, relatedBy: .equal, toItem: buttonsStackView, attribute: .width, multiplier: 1, constant: 0)
        let cImagesLeft = NSLayoutConstraint(item: imagesStackView, attribute: .leading, relatedBy: .equal, toItem: buttonsStackView, attribute: .leading, multiplier: 1, constant: 0)
        let cImagesHeigth = NSLayoutConstraint(item: imagesStackView, attribute: .height, relatedBy: .equal, toItem: buttonsStackView, attribute: .height, multiplier: 1, constant: 0)
        // Labels Stack Positioning
        let cLabelsTop = NSLayoutConstraint(item: labelsStackView, attribute: .top, relatedBy: .equal, toItem: buttonsStackView, attribute: .bottom, multiplier: 1, constant: 0)
        let cLabelsBottom = NSLayoutConstraint(item: labelsStackView, attribute: .bottom, relatedBy: .equal, toItem: tabBarBackground, attribute: .bottom, multiplier: 1, constant: 0)
        let cLabelsLeading = NSLayoutConstraint(item: labelsStackView, attribute: .leading, relatedBy: .equal, toItem: buttonsStackView, attribute: .leading, multiplier: 1, constant: 0)
        let cLabelsWidth = NSLayoutConstraint(item: labelsStackView, attribute: .width, relatedBy: .equal, toItem: buttonsStackView, attribute: .width, multiplier: 1, constant: 0)
        // Add to Tabbar
        tabBarBackground.addConstraints([cTabHeigth, cButtonsTop, cButtonsLeft, cButtonsRight, cImagesTop, cImagesWidth, cImagesLeft, cImagesHeigth, cLabelsTop, cLabelsBottom, cLabelsLeading, cLabelsWidth])
        self.view.addSubview(tabBarBackground)
        // SNACK
        snackView = UIView()
        snackView.translatesAutoresizingMaskIntoConstraints = false
        let snackTitle = UILabel()
        snackTitle.tag = 11
        snackTitle.font = font
        snackTitle.translatesAutoresizingMaskIntoConstraints = false
        snackView.addSubview(snackTitle)
        // Constraints
        snackHeigth = NSLayoutConstraint(item: snackView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        let cLabelY = NSLayoutConstraint(item: snackTitle, attribute: .centerY, relatedBy: .equal, toItem: snackView, attribute: .centerY, multiplier: 1, constant: 0)
        let cLabelX = NSLayoutConstraint(item: snackTitle, attribute: .centerX, relatedBy: .equal, toItem: snackView, attribute: .centerX, multiplier: 1, constant: 0)
        let cLabelLeft = NSLayoutConstraint(item: snackTitle, attribute: .leading, relatedBy: .equal, toItem: snackView, attribute: .leading, multiplier: 1, constant: 20)
        snackView.addConstraints([snackHeigth, cLabelY, cLabelX, cLabelLeft])
        self.view.insertSubview(snackView, belowSubview: tabBarBackground)
        // MAIN
        mainView = UIView()
        mainView.backgroundColor = .white
        mainView.translatesAutoresizingMaskIntoConstraints = false
        self.view.insertSubview(mainView, belowSubview: snackView)
        // General Constraints
        let cMainLeft = NSLayoutConstraint(item: mainView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
        let cMainRight = NSLayoutConstraint(item: mainView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
        let cMainTop = NSLayoutConstraint(item: mainView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0)
        let cSnackLeft = NSLayoutConstraint(item: snackView, attribute: .leading, relatedBy: .equal, toItem: mainView, attribute: .leading, multiplier: 1, constant: 0)
        let cSnackTop = NSLayoutConstraint(item: snackView, attribute: .top, relatedBy: .equal, toItem: mainView, attribute: .bottom, multiplier: 1, constant: 0)
        let cSnackRigth = NSLayoutConstraint(item: snackView, attribute: .trailing, relatedBy: .equal, toItem: mainView, attribute: .trailing, multiplier: 1, constant: 0)
        let cTabRigth = NSLayoutConstraint(item: tabBarBackground, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
        let cTabLeft = NSLayoutConstraint(item: tabBarBackground, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
        let cTabTop = NSLayoutConstraint(item: tabBarBackground, attribute: .top, relatedBy: .equal, toItem: snackView, attribute: .bottom, multiplier: 1, constant: 0)
        let cTabBottom = NSLayoutConstraint(item: tabBarBackground, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
        // Add to view
        self.view.addConstraints([cMainLeft, cMainRight, cMainTop, cSnackLeft, cSnackTop, cSnackRigth, cTabRigth, cTabLeft, cTabTop, cTabBottom])
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        MaterialTB.currentTabBar = self
        MaterialTB.tabBarLoaded = true
        
        self.performSpecialSegue(id: "1", sender: self)
        self.performSpecialSegue(id: "2", sender: self)
        self.performSpecialSegue(id: "3", sender: self)
        self.performSpecialSegue(id: "4", sender: self)
        self.performSpecialSegue(id: "5", sender: self)
    }
    
    internal func addTapViewController(vc: MaterialViewController, index: Int) {
        guard index <= viewControllers.count else {
            print("Unable to add view controller to tap bar: Index out of bounds. Make sure you create your views in order")
            return
        }
        
        guard index < 6 else {
            print("Unable to add view controller to tap bar: Index greater than 6, tab bars are meant to use for a maximum of 5 view controllers.")
            return
        }
        
        guard index >= 0 else {
            print("Unable to add view controller to tap bar: Negative index.")
            return
        }
        
        self.viewControllers[index] = vc
        let button = UIButton()
        button.tag = index
        button.addTarget(self, action: #selector(tabBarTap), for: .touchUpInside)
        self.buttons[index] = button
        self.buttonsStackView.insertArrangedSubview(button, at: index)
        
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        let label = UILabel()
        
        let imageWidthConstraint = NSLayoutConstraint(item: image, attribute: .width, relatedBy: .equal, toItem: button, attribute: .width, multiplier: 1, constant: 0)
        let labelWidthConstraint = NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: button, attribute: .width, multiplier: 1, constant: 0)
        let labelYConstraint = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: labelsStackView, attribute: .centerY, multiplier: 1, constant: 0)
        
        self.imagesStackView.insertArrangedSubview(image, at: index)
        self.labelsStackView.insertArrangedSubview(label, at: index)
        
        self.tabBarBackground.addConstraints([imageWidthConstraint, labelWidthConstraint, labelYConstraint])
        
        if self.viewControllers.count > 1 {
            let newConstraint = NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: self.buttons[0], attribute: .width, multiplier: 1, constant: 0)
            self.buttonsStackView.addConstraint(newConstraint)
            self.animationConstraints[index] = newConstraint
        }
        
        // Configure Images and label
        image.image = vc.idleImage
        image.highlightedImage = vc.selectedImage ?? vc.idleImage?.maskWithColor(color: selectedTint)
        label.text = vc.tabTitle
        label.font = font
        label.textAlignment = .center
        
        self.images[index] = image
        self.labels[index] = label
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tabBarBackground.addInvertedShadow()
        
        if selectedIndex == -1 {
            selectedIndex = initialViewController - 1
            if let home = viewControllers[selectedIndex] {
                self.addChildViewController(home)
                self.view.insertSubview(home.view, aboveSubview: self.mainView)
                home.view.frame = self.mainView.bounds
                home.didMove(toParentViewController: self)
                images[selectedIndex]?.isHighlighted = true
                labels[selectedIndex]?.textColor = self.selectedTint
                self.animateTabbar()
            } else {
                print("The view controller selcted as initialViewController has not been configured. Make sure you added the material view segue and that the identifier is configured correctly")
            }
        }
    }
    
    public func currentViewController() -> UIViewController? {
        if selectedIndex > -1 {
            return viewControllers[selectedIndex]
        } else {
            return nil
        }
    }
    
    public func reloadViewController() {
        if let reloadedViewController = viewControllers[selectedIndex]?.refreshViewController(),
            let previous_vc = self.viewControllers[selectedIndex] {
            
            previous_vc.dismiss(animated: true, completion: nil)
            
            UIView.animate(withDuration: 0.3, animations: {() in
                previous_vc.view.alpha = 0
            })
            
            previous_vc.willMove(toParentViewController: nil)
            previous_vc.view.removeFromSuperview()
            previous_vc.removeFromParentViewController()
            
            self.view.insertSubview(reloadedViewController.view, aboveSubview: self.mainView)
            
            reloadedViewController.view.alpha = 0
            
            self.addChildViewController(reloadedViewController)
            reloadedViewController.didMove(toParentViewController: self)
            
            UIView.animate(withDuration: 0.3, animations: {() in
                self.view.layoutIfNeeded()
                reloadedViewController.view.alpha = 1
                reloadedViewController.view.frame = self.mainView.bounds
            })
            
            self.viewControllers[selectedIndex] = reloadedViewController
        }
    }
    
    @objc public func tabBarTap(_ sender: UIButton) {
        if(sender.tag == selectedIndex) {
            reloadViewController()
            return
        }
        
        UIView.animate(withDuration: 0.2) {
            self.labels[self.selectedIndex]!.alpha = 0
        }
        
        let previousIndex = selectedIndex
        selectedIndex = sender.tag
        
        let selected_vc = self.viewControllers[selectedIndex]!
        self.view.insertSubview(selected_vc.view, aboveSubview: self.mainView)
        
        let direction = CGFloat((selectedIndex - previousIndex)/abs(selectedIndex - previousIndex))
        
        selected_vc.view.frame = CGRect(x: self.mainView.bounds.origin.x + (direction * self.mainView.bounds.size.width), y: self.mainView.bounds.origin.y, width: self.mainView.bounds.size.width, height: self.mainView.bounds.size.height)
        
        self.addChildViewController(selected_vc)
        selected_vc.didMove(toParentViewController: self)
        
        self.animateTabbar()
        
        let previous_vc = self.viewControllers[previousIndex]!
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.images[previousIndex]!.isHighlighted = false
            self.labels[previousIndex]!.textColor = self.idleTint
            self.labels[previousIndex]!.alpha = 1
            self.images[self.selectedIndex]!.isHighlighted = true
            self.labels[self.selectedIndex]!.textColor = self.selectedTint
            self.labels[self.selectedIndex]!.alpha = 1
            selected_vc.view.frame = self.mainView.bounds
            previous_vc.view.frame = CGRect(x: self.mainView.bounds.origin.x - (direction * self.mainView.bounds.size.width), y: self.mainView.bounds.origin.y, width: self.mainView.bounds.size.width, height: self.mainView.bounds.size.height)
        }) { (completed) in
            previous_vc.willMove(toParentViewController: nil)
            previous_vc.view.removeFromSuperview()
            previous_vc.removeFromParentViewController()
        }
    }
    
    private func animateTabbar() {
        switch viewControllers.count {
        case 4:
            if selectedIndex == 0 {
                for i in 1...3 {
                    self.animationConstraints[i] = self.animationConstraints[i]?.setMultiplier(multiplier: 0.5)
                }
            } else {
                self.animationConstraints[selectedIndex] = self.animationConstraints[selectedIndex]?.setMultiplier(multiplier: 2)
                for i in 1...3 {
                    if selectedIndex != i {
                        self.animationConstraints[i] = self.animationConstraints[i]?.setMultiplier(multiplier: 1)
                    }
                }
            }
        case 5:
            if selectedIndex == 0 {
                for i in 1...4 {
                    self.animationConstraints[i] = self.animationConstraints[i]?.setMultiplier(multiplier: 0.5)
                }
            } else {
                self.animationConstraints[selectedIndex] = self.animationConstraints[selectedIndex]?.setMultiplier(multiplier: 2)
                for i in 1...4 {
                    if selectedIndex != i {
                        self.animationConstraints[i] = self.animationConstraints[i]?.setMultiplier(multiplier: 1)
                    }
                }
            }
        default:
            // Animate withoud width changes
            break
        }
    }
    
    
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer)
    {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer
        {
            let b = UIButton()
            switch swipeGesture.direction
            {
            case UISwipeGestureRecognizerDirection.right:
                b.tag = selectedIndex > 0 ? selectedIndex-1 : 0
            case UISwipeGestureRecognizerDirection.left:
                b.tag = selectedIndex < (viewControllers.count - 1) ? (selectedIndex+1) : (viewControllers.count - 1)
            default:
                break
            }
            tabBarTap(b)
        }
    }
    
    
    public func showSnack(message: String, permanent: Bool = false) {
        (self.snackView.viewWithTag(11) as? UILabel)?.text = message
        self.snackHeigth.constant = 35
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.snackView.alpha = 1
        }
        if (!permanent) {
            if #available(iOS 10.0, *) {
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (timer) in
                    self.snackHeigth.constant = 0
                    UIView.animate(withDuration: 0.5) {
                        self.view.layoutIfNeeded()
                        self.snackView.alpha = 0
                    }
                    timer.invalidate()
                }
            } else {
                Timer.scheduledTimer(timeInterval: 5.0,
                                     target: self,
                                     selector: #selector(hideSnack),
                                     userInfo: nil,
                                     repeats: false)
            }
        }
    }
    
    @objc public func hideSnack() {
        self.snackHeigth.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.snackView.alpha = 0
        }
    }
    
}
