//
//  GamePlayViewController.swift
//  Fruit-Game
//
//  Created by Samreth Kem on 12/4/22.
//

import UIKit
import Combine

class GamePlayViewController: UIViewController {
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    private var viewModel: GamePlayViewModel!
    private var cancellable: Set<AnyCancellable>!
    
    init(viewModel: GamePlayViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.cancellable = []
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        levelLabel.text = "Level: \(viewModel.gameLevel.rawValue)"
        scoreLabel.text = "Score: \(viewModel.score)"
        binding()
        setupGame()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel?.saveGame()
    }
    
    private func binding() {
        viewModel.$score.sink { [weak self] score in
            if let self = self {
                self.scoreLabel.text = "Score: \(score)"
            }
        }.store(in: &cancellable)
    }
}

//MARK: setups
private extension GamePlayViewController {
    func setupGame() {
        Timer.scheduledTimer(withTimeInterval: viewModel.speed, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            let model = self.viewModel.models.randomElement()
            var imageView = self.setUpImageView(with: model?.rawValue ?? "")
            
            imageView = self.configStartAnimationFor(imageView: imageView)
            
            imageView.addTapGestureRecognizer { [weak self] in
                guard let self = self else { return }
                if imageView.tintColor == .red {
                    imageView = self.configClickAnimationFor(imageView: imageView, model: model)
                }
            }
            
            self.view.addSubview(imageView)
        }
    }
    
    func setUpImageView(with name: String) -> UIImageView {
        let image = UIImage(named: name)
        let imageView = UIImageView(image: image)
        
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .red
        imageView.setupWithinSafeArea(insects: self.view.safeAreaInsets, bounds: self.view.bounds)
        
        return imageView
    }
}

//MARK: animations
private extension GamePlayViewController {
    func configStartAnimationFor(imageView: UIImageView) -> UIImageView {
        CATransaction.setCompletionBlock {
            imageView.frame = .zero
            imageView.layer.removeAllAnimations()
        }
        
        imageView.layer.transform = CATransform3DMakeScale(5, 5, 1)
        imageView.layer.add(self.scaleAnimation(), forKey: nil)
        
        return imageView
    }
    
    func configClickAnimationFor(imageView: UIImageView, model: GameModel?) -> UIImageView {
        CATransaction.setCompletionBlock { [weak self] in
            imageView.frame = .zero
            imageView.layer.removeAllAnimations()
            self?.viewModel.objectClicked(model: model)
        }
        
        imageView.tintColor = .blue
        imageView.layer.add(self.fadeAnimation(), forKey: nil)
        
        return imageView
    }
    
    func scaleAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 1
        animation.toValue = 5
        animation.duration = self.viewModel.duration
        
        return animation
    }
    
    func fadeAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1
        animation.toValue = 0
        animation.duration = 0.15
        
        return animation
    }
}

