//
//  ViewController.swift
//  WeatherAnimations
//
//  Created by Байсангур on 20.07.2024.
//

import UIKit

final class AnimationsViewController: UIViewController {
    
    private enum Constants {
        static let heightCollection = CGFloat(110)
        static let sizeWidthCell = CGFloat(100)
        static let sizeHeightCrll = CGFloat(100)
    }
    
    private let imageSnowflake = UIImage(named: "snowflake")
    private var emitter = Emitter()
    private weak var emitterLayer: CAEmitterLayer?
    
    private let images = ImageName.allCases
    private var collectionView: UICollectionView!
    
    private var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private var blurView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        view.effect = blurEffect
        view.clipsToBounds = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavController()
        configureCollectionView()
        setupLayout()
        snowAnimation(imageSnowflake)
    }
    
    func configureNavController() {
        self.view.backgroundColor = .systemBlue
        title = "Weather Animations"
    }

    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        collectionView.backgroundColor = .clear
        collectionView.backgroundView = blurView
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        return layout
    }
    
    
    func setupLayout() {
        view.addSubview(backgroundView)
        view.addSubview(collectionView)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: Constants.heightCollection)
        ])
    }
}

extension AnimationsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionViewCell
        cell.imageView.image = images[indexPath.row].image
        return cell
    }
}

extension AnimationsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.sizeWidthCell, height: Constants.sizeHeightCrll)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected image: \(images[indexPath.row].rawValue)")
        stopSnowAnimation()
//        snowAnimation(UIImage(systemName: "drop.fill"))
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            self.stopSnowAnimation()
//            self.snowAnimation(UIImage(systemName: "drop.fill"))
    }
}

extension AnimationsViewController {
    func snowAnimation(_ image: UIImage?) {

        emitterLayer = emitter.get(with: image)
        guard let emitterLayer = emitterLayer else { return }
        emitterLayer.emitterPosition = CGPoint(x: view.frame.width / 2, y: 0)
        emitterLayer.emitterSize = CGSize(width: view.frame.width, height: 2)
        backgroundView.layer.addSublayer(emitterLayer)
    }
    
    func stopSnowAnimation() {
        emitterLayer?.removeFromSuperlayer()
        emitterLayer = nil
    }
    
}
