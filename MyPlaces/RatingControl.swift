//
//  RatingControl.swift
//  MyPlaces
//
//  Created by Станислав Шапетько on 03.03.2022.
//

import UIKit
import SwiftUI

@IBDesignable class RatingControl: UIStackView {
    // MARK: Properties
    
    var rating = 0 {
        didSet {
            updateButtonSelectionState()
        }
    }
    
    private var ratingButtons = [UIButton]()
    
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
        guard let index = ratingButtons.firstIndex(of: button) else {return}
        
        // calculate rating of selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            rating = 0
        } else {
            rating = selectedRating
        }
    }
    
    // MARK: Private methods
    
    private func setUpButtons() {
        
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
            // load button image
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar",
                                 in: bundle,
                                 compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar",
                                in: bundle,
                                compatibleWith: self.traitCollection)
        let hightlightedStar = UIImage(named: "hightlightedStar",
                                       in: bundle,
                                       compatibleWith: self.traitCollection)
        
        
        for _ in 1...starCount {
            // создание кнопки
            let button = UIButton()
            
            // set the button image
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(hightlightedStar, for: .highlighted)
            button.setImage(hightlightedStar, for: [.highlighted, .selected])
             
            
            
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
        updateButtonSelectionState()
        
    }
    
    private func updateButtonSelectionState() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }

}
