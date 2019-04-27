//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Iury Miguel on 21/04/19.
//  Copyright © 2019 Iury Miguel. All rights reserved.
//

import UIKit
//@IBDesignable in order the Inteface Builder knows about the contents of this control.
@IBDesignable class RatingControl: UIStackView {
    
    //MARK: Properties
    private var onRatingChangedListener: ((Int) -> Void?)? = nil
    private var ratingButtons = [UIButton]()
    var rating = 0 {
        didSet {
            onRatingChangedListener?(rating)
            updateButtonSelectionStates()
        }
    }
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    
    //MARK: Initialization
    // init(frame:) for programatically initializing the view and init?(coder:) for loading the view from the storyboard. 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Private Methods
    
    private func setupButtons() {
        
        // clear any existing buttons
        for button in ratingButtons {
            // This tells the stack view that it should no longer calculate the button’s size and position
            removeArrangedSubview(button)
            //removes the button from the stack view entirely
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // Load Button Images
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named:"emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named:"highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        for _ in 0..<starCount {
            // Create the button
            let button = UIButton()
            // button.backgroundColor = UIColor.red
            // Set the button images
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            // disables the button’s automatically generated constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            // Add constraints
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            // Add the button to the stack
            addArrangedSubview(button)
            // Add the new button to the rating button array
            ratingButtons.append(button)
        }
        updateButtonSelectionStates()
    }
    
    //MARK: Button Action
    
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.firstIndex(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        // Calculate the rating of the selected button
        let selectedRating = index + 1
        if selectedRating == rating {
            // If the selected star represents the current rating, reset the rating to 0.
            rating = 0
        } else {
            // Otherwise set the rating to the selected star
            rating = selectedRating
        }
    }
    
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
    
    func setOnRatingChangedListener(listener: @escaping (Int) -> Void) {
        onRatingChangedListener = listener
    }
}
