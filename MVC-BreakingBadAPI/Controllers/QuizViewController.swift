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

final class QuizViewController: UIViewController {

	func showStartState() {

	}

	func showQuiz() {

	}
}
