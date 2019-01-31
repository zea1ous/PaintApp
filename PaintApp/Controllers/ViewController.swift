//
//  ViewController.swift
//  PaintApp
//
//  Created by Alex Kolovatov on 29/01/2019.
//  Copyright © 2019 Alex Kolovatov. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    private lazy var canvas: Canvas = {
        let canvas = Canvas()
        canvas.backgroundColor = .white
        return canvas
    }()
    
    private lazy var undoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Undo", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleUndo), for: .touchUpInside)
        return button
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clear", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [undoButton, clearButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var yellowButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChanged), for: .touchUpInside)
        return button
    }()
    
    private lazy var redButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChanged), for: .touchUpInside)
        return button
    }()
    
    private lazy var blueButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChanged), for: .touchUpInside)
        return button
    }()
    
    private lazy var colorStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [yellowButton, redButton, blueButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var strokeWidthSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.addTarget(self, action: #selector(handleChangeLineWidth), for: .touchUpInside)
        return slider
    }()
    
    override func loadView() {
        super.loadView()
        
        self.view = canvas
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addSubview(stackView)
        view.addSubview(colorStackView)
        view.addSubview(strokeWidthSlider)
        
        setupConstraints()
    }
    
    // MARK: - Actions
    
    @objc private func handleUndo() {
        canvas.undo()
    }
    
    @objc private func handleClear () {
        canvas.clear()
    }
    
    @objc private func handleColorChanged(button: UIButton) {
        guard let backgroundColor = button.backgroundColor else { return }
        canvas.setStrokeColor(color: backgroundColor)
    }
    
    @objc private func handleChangeLineWidth() {
        canvas.setStrokeWidth(strokeWidthSlider.value)
    }
    
    // MARK: - Setup Layout
    
    private func setupConstraints() {
        [stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
         stackView.widthAnchor.constraint(equalToConstant: 120)].forEach { (anchor) in
            anchor.isActive = true
        }
        
        [colorStackView.leftAnchor.constraint(equalTo: stackView.rightAnchor), colorStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
         colorStackView.widthAnchor.constraint(equalToConstant: 90)].forEach { (anchor) in
            anchor.isActive = true
        }
        
        
        [strokeWidthSlider.leftAnchor.constraint(equalTo: colorStackView.rightAnchor, constant: 10),
         strokeWidthSlider.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
         strokeWidthSlider.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)].forEach { (anchor) in
            anchor.isActive = true
        }
    }
    
}


