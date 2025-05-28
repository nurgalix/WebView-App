import UIKit

class CharactersViewController: UIViewController {

    private var collectionView: UICollectionView!
    private var characters: [Character] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        view.backgroundColor = .systemBackground
        setupCollectionView()
        fetchCharacters()
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 12
        let itemsPerRow: CGFloat = 2
        let totalSpacing = spacing * (itemsPerRow + 1)
        let itemWidth = (UIScreen.main.bounds.width - totalSpacing) / itemsPerRow
        let itemHeight = itemWidth * 1.4 // 2.3 карточки поместятся
        
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CharacterGridCell.self, forCellWithReuseIdentifier: CharacterGridCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    private func fetchCharacters() {
        let urlString = "https://rickandmortyapi.com/api/character"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(CharacterResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.characters = decoded.results
                        self.collectionView.reloadData()
                    }
                } catch {
                    print("❌ Decoding error:", error)
                }
            }
        }.resume()
    }
}

extension CharactersViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let character = characters[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterGridCell.identifier, for: indexPath) as! CharacterGridCell
        cell.configure(with: character)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = characters[indexPath.item]
        let detailVC = CharacterDetailViewController(character: character)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
