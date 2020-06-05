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
	case quizStep(step: QuizStep)
	case finished
}

struct QuizStep {
	let question: String
	let variants: [String]
	let correctVariantIndex: Int
}

class StepsModel {
	private let _quizSteps: [QuizStep] = []

	private var _currentStepIndex: Int = 0

	private var _correctAnswers: Int = 0

	func checkIfStepIsCorrect(index: Int) -> Bool {
		return _quizSteps[_currentStepIndex].correctVariantIndex == index
	}

	func nextStep() -> State {
		_currentStepIndex += 1
		guard _currentStepIndex < _quizSteps.count else { return .finished }
		return .quizStep(step: _quizSteps[_currentStepIndex])
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
        label.text = "Win a quiz game or get a spoiler!"
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

	func showStartState() {

	}

	func showQuiz() {

	}


    override func loadView() {
        let quizView = QuizView()
        quizView.button.addTarget(self, action: #selector(onStart), for: .touchUpInside)
        self.view = quizView
    }

    @objc private func onStart() {
        let stepView = StepView()
        self.view = stepView
    }

    class StepView : UIView {
        lazy var mainStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
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
            stackView.axis = .vertical
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()

        lazy var titleLabel: UILabel = {
            let label = UILabel()
//            label.text = "Win a quiz game or get a spoiler!"
            label.textColor = .white
            return label
        }()

        override init(frame: CGRect) {
            super.init(frame: frame)
            self.addSubview(mainStackView)
            self.mainStackView.addSubview(self.scoreStackView)
            self.mainStackView.addSubview(self.titleLabel)
            self.mainStackView.addSubview(self.answersStackView)
            mainStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            mainStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        }

        required init?(coder: NSCoder) {
            nil
        }
    }
}
