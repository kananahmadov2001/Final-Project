//
//  ProfileViewController.swift
//  TeamUp WashU
//
//  Created by Ahmadov, Kanan on 11/12/24.
//

import UIKit

class ProfileViewController: UIViewController {

    // Outlets for UI elements
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var majorTextField: UITextField!
    @IBOutlet weak var skillsStackView: UIStackView!

    // Data models
    var skills: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial setup
        setupProfileImageView()
        checkIfNewUser()
        updateSkillsStackView()
    }

    // Function to set up the profile image view
    func setupProfileImageView() {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
        profileImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeImageTapped))
        profileImageView.addGestureRecognizer(tapGesture)
    }

    // Function to check if the user is new
    func checkIfNewUser() {
        let isNewUser = UserDefaults.standard.bool(forKey: "isNewUser")

        if isNewUser {
            // Clear all fields for a new user
            profileImageView.image = UIImage(systemName: "person.circle")
            nameTextField.text = ""
            emailTextField.text = ""
            phoneTextField.text = ""
            majorTextField.text = ""
            skills = []

            // Save that the user is no longer new
            UserDefaults.standard.set(false, forKey: "isNewUser")
        } else {
            // Load user data if it exists
            loadUserData()
        }
    }

    // Function to load existing user data
    func loadUserData() {
        nameTextField.text = UserDefaults.standard.string(forKey: "userName") ?? ""
        emailTextField.text = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        phoneTextField.text = UserDefaults.standard.string(forKey: "userPhone") ?? ""
        majorTextField.text = UserDefaults.standard.string(forKey: "userMajor") ?? ""
        skills = UserDefaults.standard.stringArray(forKey: "userSkills") ?? []
        updateSkillsStackView()
    }

    // Function to update skills section with buttons for each skill
    func updateSkillsStackView() {
        skillsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for skill in skills {
            let skillButton = UIButton(type: .system)
            skillButton.setTitle(skill, for: .normal)
            skillButton.backgroundColor = .systemGray5
            skillButton.setTitleColor(.black, for: .normal)
            skillButton.layer.cornerRadius = 10
            skillsStackView.addArrangedSubview(skillButton)
        }

        // Add "+" button for adding new skills
        let addButton = UIButton(type: .system)
        addButton.setTitle("+", for: .normal)
        addButton.backgroundColor = .systemBlue
        addButton.setTitleColor(.white, for: .normal)
        addButton.layer.cornerRadius = 10
        addButton.addTarget(self, action: #selector(addSkillTapped), for: .touchUpInside)
        skillsStackView.addArrangedSubview(addButton)
    }

    // Action for "Change Image" tap
    @IBAction func changeImageTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Change Profile Image", message: "Choose a source", preferredStyle: .actionSheet)

        alertController.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            print("Camera selected")
        }))

        alertController.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
            print("Photo Library selected")
        }))

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true)
    }
    

    // Action for adding a new skill
    @IBAction func addSkillTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Add Skill", message: "Enter your skill:", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Skill"
        }

        let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
            if let skill = alertController.textFields?.first?.text, !skill.isEmpty {
                self.skills.append(skill)
                self.updateSkillsStackView()
                self.saveSkills()
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(submitAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    // Function to save skills to UserDefaults
    func saveSkills() {
        UserDefaults.standard.set(skills, forKey: "userSkills")
        print("Skills saved: \(skills)")
    }
    
}
