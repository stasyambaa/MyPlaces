//
//  RatingControl.swift
//  MyPlaces
//
//  Created by Станислав Шапетько on 03.03.2022.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    // MARK: Properties
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setUpButtons()
        }
    }
    
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setUpButtons()
        }
    }
    
    private var ratingButtons = [UIButton]()
    
    var rating = 0
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setUpButtons()
    }
        // MARK: Button action
    @objc func ratingButtonTapped(button: UIButton) {
        print("Button pressed")
    }
    
    // MARK: Private methods
    
    private func setUpButtons() {
        
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        for _ in 1...starCount {
            // создание кнопки
            let button = UIButton()
            button.backgroundColor = .red
            
            
            // констрейнты для кнопки
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            // setup the button action
            button.addTarget(self, action: #selector(ratingButtonTapped(button:)), for: .touchUpInside)
            
            // добавление кнопки в стэк вью
            addArrangedSubview(button)
            
            // добавление кнопки в массив RatingButtons
            ratingButtons.append(button)
        }
        
    }

}
