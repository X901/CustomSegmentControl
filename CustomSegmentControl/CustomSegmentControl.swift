////
//CustomSegmentControl.swift
//CustomSegmentControl
//
//Created by Basel Baragabah on 16/03/2019.
//Copyright © 2019 Basel Baragabah. All rights reserved.
//

import UIKit

@IBDesignable
class CustomSegmentControl: UIControl {
var buttons = [UIButton]()
    var selector: UIView!
    var selectedSegmentIndex = 0
    
 @IBInspectable
    var borderWidth: CGFloat = 0 {
    didSet{
        layer.borderWidth = borderWidth
    }
    }
    
    @IBInspectable
    var borderColor: UIColor = UIColor.clear {
        didSet{
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var buttonBorderColor: UIColor = UIColor.lightGray {
        didSet{
            updateView()
        }
    }
    
    @IBInspectable
    var buttonBorderWidth: CGFloat = 2.0 {
        didSet{
            updateView()
        }
    }
    
    @IBInspectable
    var commmaSeparatedButtonTitles: String = ""{
        didSet{
updateView()
    }
    }
    
    @IBInspectable
    var imageTintColor: UIColor = .lightGray {
        didSet{
updateView()
            
        }
    }
    
    @IBInspectable
    var selectorColor: UIColor = UIColor(red: 0.23, green: 0.62, blue: 1.00, alpha: 1.00) {
        didSet{
            updateView()
        }
    }
    
    @IBInspectable
    var selectorTintColor: UIColor = .white {
        didSet{
            updateView()
        }
    }
    
    func updateView(){
        buttons.removeAll()
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        let buttonTitles = commmaSeparatedButtonTitles.components(separatedBy: ",")
        
        
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .roundedRect)
            
            button.sizeToFit()
            button.layer.cornerRadius = self.frame.height/2
            button.layer.masksToBounds = true
            button.layer.borderColor = buttonBorderColor.cgColor
            button.layer.borderWidth = buttonBorderWidth
            button.setImage(button.convertTitleToImage(textString: buttonTitle), for: .normal)
            button.tintColor = buttonBorderColor
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            buttons.append(button)
        }
        
        buttons[0].tintColor = selectorTintColor
        buttons[0].layer.borderColor = selectorColor.cgColor

        
        let selectorWidth = (frame.width) / CGFloat(buttonTitles.count)
        
        selector = UIView(frame: CGRect(x: 0, y: 0, width: selectorWidth - 8, height: frame.height ))
        selector.layer.cornerRadius = frame.height/2
        selector.backgroundColor = selectorColor
        addSubview(selector)
        
        let sv = UIStackView(arrangedSubviews: buttons)
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.spacing = 10
        addSubview(sv)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sv.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        sv.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        sv.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true


        
        
    }
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.height/2
    }
    
    override func layoutSubviews() {
        
        #if !TARGET_INTERFACE_BUILDER
        
        updateView()
        
        #endif
    }

    @objc func buttonTapped(button: UIButton){
        for (buttonIndex, btn) in buttons.enumerated() {
            
            btn.layer.borderColor = buttonBorderColor.cgColor
            btn.tintColor = buttonBorderColor
            
            if (btn) == button {
                selectedSegmentIndex = buttonIndex
                let selectorStartPosition = (frame.width/CGFloat(buttons.count) + CGFloat(buttons.count) - 1  ) * CGFloat(buttonIndex)
                UIView.animate(withDuration: 0.3) {
                    self.selector.frame.origin.x = selectorStartPosition
                }
                
                btn.layer.borderColor = selectorColor.cgColor
                btn.tintColor = selectorTintColor
            }
        }
        
        sendActions(for: .valueChanged)
    }
  
}


extension UIButton {
    
    func convertTitleToImage(textString: String) -> UIImage? {
        var image: UIImage? = nil
        
         let text = textString 
             image = UIImage(named: text)
            self.imageView?.contentMode = .scaleAspectFit
            self.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)

        
        return image
    }
    
}
