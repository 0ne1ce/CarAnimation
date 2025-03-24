//
//  ViewController.swift
//  ExtraHW
//
//  Created by Алексей on 22.03.2025.
//

import UIKit

final class ViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        static let detailColor = UIColor(hex: "00C7C0")
        static let carOffsetH: CGFloat = 25
        static let carOffsetV: CGFloat = 365
        
        static let newDetailOffsetLeft: CGFloat = 10
        static let newDetailWidth: CGFloat = 10
        static let newDetailHeight: CGFloat = 45
        static let newDetailRadius: CGFloat = 5
    }
    
    // MARK: - Properties
    let distance = CGFloat(20)
    let carAnimationDuration = CGFloat(1)
    let waveAnimationDuration = 0.5
    let wheelAnimationDuration = 2.0
    let waveOffset: CGFloat = 2
    var linesContainer: [UIView] = []
    var wheels: [UIImageView] = []
    var car: UIView = UIView()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureCar()
    }
    
    func configureCar() {
        car.backgroundColor = .clear
        view.addSubview(car)
        car.pinHorizontal(to: view, Constants.carOffsetH)
        car.pinVertical(to: view, Constants.carOffsetV)
        //car.leadingAnchor.constant
        for i in 1...18 {
            let newDetail: UIView = UIView()
            car.addSubview(newDetail)
            if i == 1 {
                newDetail.pinLeft(to: car.leadingAnchor)
            }
            else {
                newDetail.pinLeft(to: linesContainer[linesContainer.endIndex - 1].trailingAnchor, Constants.newDetailOffsetLeft)
            }
            newDetail.setWidth(Constants.newDetailWidth)
            switch i {
            case 1:
                newDetail.pinBottom(to: car)
                newDetail.setHeight(45)
            case 2:
                newDetail.pinBottom(to: car, 30)
                newDetail.setHeight(35)
            case 3:
                newDetail.pinBottom(to: car, 34)
                newDetail.setHeight(38)
            case 4:
                newDetail.pinBottom(to: car, 30)
                newDetail.setHeight(55)
            case 5:
                newDetail.pinBottom(to: car)
                newDetail.setHeight(103)
            case 6:
                newDetail.pinBottom(to: car)
                newDetail.setHeight(117)
            case 7:
                newDetail.pinBottom(to: car)
                newDetail.setHeight(123)
            case 8:
                newDetail.pinBottom(to: car)
                newDetail.setHeight(120)
            case 9:
                newDetail.pinBottom(to: car)
                newDetail.setHeight(117)
            case 10:
                newDetail.pinBottom(to: car)
                newDetail.setHeight(112)
            case 11:
                newDetail.pinBottom(to: car)
                newDetail.setHeight(92)
            case 12:
                newDetail.pinBottom(to: car)
                newDetail.setHeight(75)
            case 13:
                newDetail.pinBottom(to: car)
                newDetail.setHeight(67)
            case 14:
                newDetail.pinBottom(to: car)
                newDetail.setHeight(61)
            case 15:
                newDetail.pinBottom(to: car, 30)
                newDetail.setHeight(25)
            case 16:
                newDetail.pinBottom(to: car, 35)
                newDetail.setHeight(25)
            case 17:
                newDetail.pinBottom(to: car, 30)
                newDetail.setHeight(25)
            case 18:
                newDetail.pinBottom(to: car)
                newDetail.setHeight(25)
            default:
                newDetail.pinBottom(to: car)
                newDetail.pinTop(to: car)
            }
            newDetail.layer.cornerRadius = Constants.newDetailRadius
            newDetail.backgroundColor = Constants.detailColor
            linesContainer.append(newDetail)
        }
        for i in 1...2 {
            let wheel = UIImageView()
            car.addSubview(wheel)
            wheel.image = UIImage(named: "wheel")
            wheel.contentMode = .scaleAspectFit
            wheel.pinBottom(to: car, -30)
            wheel.setHeight(60)
            wheel.setWidth(60)
            if i == 1 {
                wheel.pinLeft(to: linesContainer[0].trailingAnchor, 3)
            }
            else {
                wheel.pinRight(to: linesContainer[linesContainer.endIndex - 1].leadingAnchor, 3)
            }
            wheels.append(wheel)
        }
        
        for (index, line) in linesContainer.enumerated() {
            line.transform = CGAffineTransform(translationX: 0, y: waveOffset)

            UIView.animate(
                withDuration: waveAnimationDuration,
                delay: 0.058 * Double(index), // 1 / 17 = 0.058
                usingSpringWithDamping: 0.45,
                initialSpringVelocity: 0.5,
                options: [.curveEaseInOut, .autoreverse, .repeat],
                animations: {
                    line.transform = CGAffineTransform(translationX: 0, y: -self.waveOffset)
                }
            )
        }
        animateCar()
        spinWheels()
    }
    
    func animateCar() {
        car.transform = CGAffineTransform(translationX: -view.bounds.width, y: 0)

        UIView.animateKeyframes(withDuration: 4.0, delay: 0, options: [.repeat], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.375) {
                self.car.transform = CGAffineTransform(translationX: 0, y: 0)
            }

            UIView.addKeyframe(withRelativeStartTime: 0.375, relativeDuration: 0.125) {}


            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.car.transform = CGAffineTransform(translationX: self.view.bounds.width, y: 0)
            }
        })
    }

    func spinWheels() {
        for wheel in wheels {
            UIView.animate(withDuration: wheelAnimationDuration, delay: 0, options: [.repeat], animations: {
                wheel.transform = CGAffineTransform(rotationAngle: -720)
            })
        }
    }
}


