//
//  Emitter.swift
//  WeatherAnimations
//
//  Created by Байсангур on 21.07.2024.
//

import UIKit

class Emitter {
    func get(with image: UIImage?) -> CAEmitterLayer {
        let emitter = CAEmitterLayer()
        
        guard let image = image else {
            return emitter
        }
        
        emitter.emitterShape = CAEmitterLayerEmitterShape.line
        emitter.emitterCells = generateEmitterCells(with: image)
        
        return emitter
    }
    
    func generateEmitterCells (with image: UIImage) -> [CAEmitterCell] {
        var cells = [CAEmitterCell]()
        
        let cell = CAEmitterCell()
        cell.contents = image.cgImage
        cell.birthRate = 2
        cell.lifetime = 40
        cell.velocity = CGFloat(25)
        cell.emissionLongitude = (180 * (.pi/180))
        cell.emissionRange = (45 * (.pi/180))
        cell.scale = 0.14
        cell.scaleRange = 0.1
        cells.append(cell)
        return cells
    }
}
