import UIKit

class ViewController: UIViewController {
    
    var countries = ["brazil", "belgium", "france", "german", "italy", "kgz", "kz", "russia", "turkey", "usa", "uz"].shuffled()
    var correctAnswer = Int.random(in: 0...2)
    
    var score = 0
    var scoreLabel: UILabel!
    var questionLabel: UILabel!
    var flagButtons = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up UI components
        setupUI()
        askQuestion()
    }
    
    func setupUI() {
        // Title label
        let titleLabel = UILabel()
        titleLabel.text = "Guess the Flag"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        let gradient = CAGradientLayer()

        gradient.frame = view.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.black.cgColor]

        view.layer.insertSublayer(gradient, at: 0)

        
        // Question label
        questionLabel = UILabel()
        questionLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        questionLabel.textColor = .white
        questionLabel.textAlignment = .center
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(questionLabel)
        view.addSubview(view1)
        
        // Flag buttons
        for i in 0..<3 {
            let button = UIButton(type: .system)
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.black.cgColor
            button.clipsToBounds = true
            button.tag = i
            button.setImage(UIImage(named: "usa"), for: .normal)
            button.addTarget(self, action: #selector(flagTapped), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            flagButtons.append(button)
            view.addSubview(button)
        }
        
        // Score label
        scoreLabel = UILabel()
        scoreLabel.text = "Score: \(score)"
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 24)
        scoreLabel.textColor = .white
        scoreLabel.textAlignment = .center
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scoreLabel)
        
        // Constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            questionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            flagButtons[0].topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 40),
            flagButtons[0].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            flagButtons[0].widthAnchor.constraint(equalToConstant: 200),
            flagButtons[0].heightAnchor.constraint(equalToConstant: 100),
            
            flagButtons[1].topAnchor.constraint(equalTo: flagButtons[0].bottomAnchor, constant: 20),
            flagButtons[1].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            flagButtons[1].widthAnchor.constraint(equalToConstant: 200),
            flagButtons[1].heightAnchor.constraint(equalToConstant: 100),
            
            flagButtons[2].topAnchor.constraint(equalTo: flagButtons[1].bottomAnchor, constant: 20),
            flagButtons[2].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            flagButtons[2].widthAnchor.constraint(equalToConstant: 200),
            flagButtons[2].heightAnchor.constraint(equalToConstant: 100),
            
            scoreLabel.topAnchor.constraint(equalTo: flagButtons[2].bottomAnchor, constant: 40),
            scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionLabel.text = "Tap the flag of \(countries[correctAnswer])"
        
        for (index, button) in flagButtons.enumerated() {
            button.setImage(UIImage(named: countries[index]), for: .normal)
            
            print("Tap the flag of \(countries[index])")
        }
    }
    
    @objc func flagTapped(_ sender: UIButton) {
        var alertTitle: String
        
        if sender.tag == correctAnswer {
            alertTitle = "Correct"
            score += 1
        } else {
            alertTitle = "Wrong"
        }
        
        // Show alert
        let ac = UIAlertController(title: alertTitle, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
            self.askQuestion()
        }))
        present(ac, animated: true)
        
        scoreLabel.text = "Score: \(score)"
    }
}
