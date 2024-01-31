//
//  ChatRoomListViewController.swift
//  ChatBot
//
//  Created by 김예준 on 1/26/24.
//

import UIKit
import CoreData

final class ChatRoomListViewController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        // TODO: why view.bounds?
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    typealias ChatRoomDataSource = UICollectionViewDiffableDataSource<Int, ChatRoom>
    typealias ChatRoomCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, ChatRoom>
    private var dataSource: ChatRoomDataSource!
    private var cellResistration: ChatRoomCellRegistration!
    
    var container: NSPersistentContainer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)

        configureNavigationController()
        setConstraints()
        configureDataSource()
        configureCellResistration()
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let context = container?.viewContext
        let request = ChatRoom.fetchRequest()
        do {
            guard let chatRoom = try context?.fetch(request) else { return }
            var snapshot = dataSource.snapshot()
            snapshot.appendItems(chatRoom, toSection: 0)
            dataSource.apply(snapshot)
        } catch {
            print(error)
        }
    }
}

// MARK: - CollectionView 초기 설정

extension ChatRoomListViewController {
    
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
        ])
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        
        return layout
    }
    
    private func configureDataSource() {
        dataSource = ChatRoomDataSource(collectionView: collectionView) { (collectionView, indexPath, chatRoom) -> UICollectionViewCell? in
            
            return collectionView.dequeueConfiguredReusableCell(using: self.cellResistration, for: indexPath, item: chatRoom)
        }
        
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([0])
        dataSource.apply(snapshot)
    }
    
    private func configureCellResistration() {
        cellResistration = ChatRoomCellRegistration { (cell, indexPath, chatRoom) -> Void in
            var content = cell.defaultContentConfiguration()
            content.text = chatRoom.title
            content.secondaryText = chatRoom.created.description
            
            cell.contentConfiguration = content
        }
    }
}

// MARK: - Navigation 초기 설정

extension ChatRoomListViewController {
    
    private func configureNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "MyChatBot 🤖"
        
        
        if #available(iOS 16.0, *) {
            let chatRoomButtonItem = UIBarButtonItem(title: "make", image: .add, target: self, action: #selector(tappedMakeRoomButton))
            
            navigationItem.rightBarButtonItem = chatRoomButtonItem
        } else {
            // Fallback on earlier versions
        }
    }
    
    @objc
    private func tappedMakeRoomButton() {
        let chatVC = ChatViewController(id: UUID(), container: container)
        navigationController?.pushViewController(chatVC, animated: true)
    }
}

extension ChatRoomListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 방법 1
        let snapshot = dataSource.snapshot()
        let chats = snapshot.itemIdentifiers(inSection: 0)
        let roomID = chats[indexPath.row].roomID
        // 방법 2
//        let roomID = dataSource.itemIdentifier(for: indexPath)?.roomID
        
        let chatVC = ChatViewController(id: roomID, container: container)
        navigationController?.pushViewController(chatVC, animated: true)
    }
}
