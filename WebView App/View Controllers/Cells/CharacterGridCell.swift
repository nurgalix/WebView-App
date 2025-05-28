import UIKit
import SnapKit
import Kingfisher

class CharacterGridCell: UICollectionViewCell {
    
    static let identifier = "CharacterGridCell"
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let statusLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        nameLabel.font = .boldSystemFont(ofSize: 14)
        statusLabel.font = .systemFont(ofSize: 12)
        statusLabel.textColor = .gray

        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        contentView.backgroundColor = .secondarySystemBackground

        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(statusLabel)

        imageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(contentView.snp.width) // квадрат
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(4)
            $0.left.right.equalToSuperview().inset(8)
        }

        statusLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(2)
            $0.left.right.equalToSuperview().inset(8)
            $0.bottom.lessThanOrEqualToSuperview().inset(4)
        }
    }

    func configure(with character: Character) {
        nameLabel.text = character.name
        statusLabel.text = "Status: \(character.status)"
        if let url = URL(string: character.image) {
            imageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
        }
    }
}
