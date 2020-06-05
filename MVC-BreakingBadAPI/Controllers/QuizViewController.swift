//
//  QuizViewController.swift
//  MVC-BreakingBadAPI
//
//  Created by Aleksandr Lavrinenko on 05.06.2020.
//  Copyright © 2020 Iurii Popov. All rights reserved.
//

import UIKit

enum State {
	case initial
	case quiz
	case finished
}

struct QuizStep {
	let question: String
	let variants: [String]
	let correctVariantIndex: Int
}

class StepsModel {
	private let _quizSteps: [QuizStep] = [
		QuizStep(question: "Who killed Walter White",
				 variants: ["Mike Ehrmantraut", "Christian Ortgea", "Skinny Pete", "Unknown"],
				 correctVariantIndex: 1) ]
	private var _currentStepIndex: Int = 0
	private var _correctAnswers: Int = 0
	private var _state: State = .initial

	func checkIfStepIsCorrect(index: Int) -> Bool {
		return _quizSteps[_currentStepIndex].correctVariantIndex == index
	}

	func nextStep() -> QuizStep? {
		switch _state {
		case .initial:
			_currentStepIndex = 0
			_state = .quiz
		case .quiz:
			_currentStepIndex += 1
			guard _currentStepIndex < _quizSteps.count else {
				_state = .finished
				return nil
			}
		case .finished:
			return nil
		}

		return _quizSteps[_currentStepIndex]
	}
}

class QuizView: UIView {
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Win a quiz game or get a spoiler! \nP.S. Black lives matter!"
        label.textColor = .white
        return label
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(button)
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class QuizViewController: UIViewController {
	let model = StepsModel()

    override func loadView() {
        let quizView = QuizView()
        quizView.button.addTarget(self, action: #selector(onStart), for: .touchUpInside)
        self.view = quizView
    }

    @objc private func onStart() {
        let stepView = StepView()
		guard let quizStep = model.nextStep() else { return }
		stepView.titleLabel.text = quizStep.question
		stepView.answerTwoButton.setTitle(quizStep.variants.first, for: .normal)
		stepView.answerFirstbutton.setTitle(quizStep.variants[1], for: .normal)
        stepView.answerTwoButton.addTarget(self, action: #selector(buttonSecondTapped), for: .touchUpInside)
        stepView.answerFirstbutton.addTarget(self, action: #selector(buttonFirstTapped), for: .touchUpInside)
        self.view = stepView

    }

    @objc private func buttonFirstTapped() {
        presentAlert(title: "You chose First answer", message: "You was maybe right", buttonTitle: "Donate us!")
    }

    @objc private func buttonSecondTapped() {
        presentAlert(title: "You chose Second answer", message: "You was maybe right", buttonTitle: "Oh no")
    }

    class StepView : UIView {
        lazy var mainStackView: UIStackView = {
            let stackView = UIStackView()
			stackView.spacing = 16
            stackView.axis = .vertical
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()

        lazy var scoreStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()

        lazy var answersStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()

        lazy var titleLabel: UILabel = {
            let label = UILabel()
			label.font = UIFont.boldSystemFont(ofSize: 24)
            label.textColor = .white
            label.textAlignment = .center
            return label
        }()

		lazy var answerFirstbutton: UIButton = {
			let button = UIButton()
			button.translatesAutoresizingMaskIntoConstraints = false
			return button
		}()

		lazy var answerTwoButton: UIButton = {
			let button = UIButton()
			button.translatesAutoresizingMaskIntoConstraints = false
			return button
		}()



        override init(frame: CGRect) {
            super.init(frame: frame)
            self.addSubview(mainStackView)
            self.mainStackView.addArrangedSubview(self.scoreStackView)
            self.mainStackView.addArrangedSubview(self.titleLabel)
            self.mainStackView.addArrangedSubview(self.answersStackView)
			self.answersStackView.addArrangedSubview(answerFirstbutton)
			self.answersStackView.addArrangedSubview(answerTwoButton)
			mainStackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
			mainStackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            mainStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            mainStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        }

        required init?(coder: NSCoder) {
            nil
        }
    }
}
