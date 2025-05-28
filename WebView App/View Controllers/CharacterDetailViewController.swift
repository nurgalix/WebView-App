import UIKit
import SnapKit

class CharacterDetailViewController: UIViewController {
    
    private let character: Character
    
    private let imageView = UIImageView()
    
    private let statusIcon = UIImageView(image: UIImage(systemName: "bell.fill"))
    private let genderIcon = UIImageView(image: UIImage(systemName: "bell.fill"))
    private let typeIcon = UIImageView(image: UIImage(systemName: "bolt.fill"))
    private let speciesIcon = UIImageView(image: UIImage(systemName: "leaf.fill"))
    
    private let statusLabel = UILabel()
    private let genderLabel = UILabel()
    private let typeLabel = UILabel()
    private let speciesLabel = UILabel()
    
    private let statusTitle = UILabel()
    private let genderTitle = UILabel()
    private let typeTitle = UILabel()
    private let speciesTitle = UILabel()
    
    init(character: Character) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
        title = character.name.uppercased()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        configure()
    }
    
    private func createInfoGroup(icon: UIImageView, label: UILabel, title: UILabel, titleText: String, titleColor: UIColor) -> UIStackView {
        icon.tintColor = .label
        icon.contentMode = .scaleAspectFit
        icon.snp.makeConstraints { $0.size.equalTo(20) }
        
        label.font = .systemFont(ofSize: 20, weight: .medium)
        title.text = titleText
        title.font = .systemFont(ofSize: 12, weight: .semibold)
        title.textColor = titleColor
        title.textAlignment = .center
        
        let verticalStack = UIStackView(arrangedSubviews: [label, title])
        verticalStack.axis = .vertical
        verticalStack.spacing = 2
        verticalStack.alignment = .center
        
        let horizontal = UIStackView(arrangedSubviews: [icon, verticalStack])
        horizontal.axis = .horizontal
        horizontal.alignment = .center
        horizontal.spacing = 8
        return horizontal
    }

    private func setupUI() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(view.snp.height).multipliedBy(0.35) // 30–40% экрана
        }

        let statusGroup = createInfoGroup(icon: statusIcon, label: statusLabel, title: statusTitle, titleText: "STATUS", titleColor: .systemBlue)
        let genderGroup = createInfoGroup(icon: genderIcon, label: genderLabel, title: genderTitle, titleText: "GENDER", titleColor: .systemRed)
        let typeGroup = createInfoGroup(icon: typeIcon, label: typeLabel, title: typeTitle, titleText: "TYPE", titleColor: .systemPurple)
        let speciesGroup = createInfoGroup(icon: speciesIcon, label: speciesLabel, title: speciesTitle, titleText: "SPECIES", titleColor: .systemGreen)

        let topRow = UIStackView(arrangedSubviews: [statusGroup, genderGroup])
        topRow.axis = .horizontal
        topRow.distribution = .fillEqually
        topRow.spacing = 16

        let bottomRow = UIStackView(arrangedSubviews: [typeGroup, speciesGroup])
        bottomRow.axis = .horizontal
        bottomRow.distribution = .fillEqually
        bottomRow.spacing = 16

        let infoStack = UIStackView(arrangedSubviews: [topRow, bottomRow])
        infoStack.axis = .vertical
        infoStack.spacing = 20

        view.addSubview(infoStack)
        infoStack.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(30)
            $0.left.right.equalToSuperview().inset(20)
        }
    }

    private func configure() {
        if let url = URL(string: character.image) {
            imageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
        }
        statusLabel.text = character.status
        genderLabel.text = character.gender
        typeLabel.text = "None"
        speciesLabel.text = character.species
    }
}
