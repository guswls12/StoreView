//
//  ViewController.swift
//  StoreView
//
//  Created by 최진용 on 2022/11/26.
//

import UIKit

class StoreViewController: UIViewController {
    
    //목업데이터
    var tempSellArray: [SellItems] = [SellItems(imageName: "testimage"),SellItems(imageName: "testimage"),SellItems(imageName: "testimage"),SellItems(imageName: "testimage")]
    var tempBuyArray: [BuyItems] = [BuyItems(imageName: "testimage"),BuyItems(imageName: "testimage"),BuyItems(imageName: "testimage")]
    
    
    
    

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let buyItemNib = UINib(nibName: String(describing: BuyItemCell.self), bundle: nil)
        self.collectionView.register(buyItemNib, forCellWithReuseIdentifier: String(describing: BuyItemCell.self))
        
        let sellItemNib = UINib(nibName: String(describing: SellItemCell.self), bundle: nil)
        self.collectionView.register(sellItemNib, forCellWithReuseIdentifier: String(describing: SellItemCell.self))
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        GlobalItems.shared.array.append(tempSellArray)
        GlobalItems.shared.array.append(tempBuyArray)
        collectionView.collectionViewLayout = creatLayout()
    }


}


//MARK: - collectionview delegate, datasource
extension StoreViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    //셀 반환
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellData = GlobalItems.shared.array[indexPath.section][indexPath.item]
        let sectionIDX = indexPath.section
        switch sectionIDX{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SellItemCell", for: indexPath) as! SellItemCell
            cell.fetchData(cellData)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BuyItemCell", for: indexPath) as! BuyItemCell
            cell.fetchData(cellData)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    //섹션별 아이탬 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GlobalItems.shared.array[section].count
    }
    
    //섹션갯수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return GlobalItems.shared.array.count
    }
    
    
    
}

//MARK: - compositional layout
extension StoreViewController {
    func creatLayout()->UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout{
            // 만들게 되면 튜플 (키: 값, 키: 값) 의 묶음으로 들어옴 반환 하는 것은 NSCollectionLayoutSection 콜렉션 레이아웃 섹션을 반환해야함
            (sectionIndex: Int, layoutEnvironment : NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            // 아이템에 대한 사이즈 - absolute 는 고정값, estimated 는 추축, fraction 퍼센트
            if sectionIndex == 0{
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .absolute(100))
                
                // 위에서 만든 아이템 사이즈로 아이템 만들기
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                // 아이템 간의 간격 설정
                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
                
                // 그룹사이즈
                let grouSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3)) // 한 줄 짜리
                
                // 그룹사이즈로 그룹 만들기
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: grouSize, subitems: [item, item, item])
                
                // 그룹으로 섹션 만들기
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous // 오른쪽으로 스크롤이 가능
                
                // 섹션에 대한 간격
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 30, trailing: 20)
                
                return section
                
            } else{
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.3))
                
                // 위에서 만든 아이템 사이즈로 아이템 만들기
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                // 아이템 간의 간격 설정
                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
                
                // 그룹사이즈
                let grouSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)) // 한 줄 짜리
                
                // 그룹사이즈로 그룹 만들기
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: grouSize, subitems: [item, item, item])
                
                // 그룹으로 섹션 만들기
                let section = NSCollectionLayoutSection(group: group)
                // section.orthogonalScrollingBehavior = .continuous // 오른쪽으로 스크롤이 가능
                
                
                // 섹션에 대한 간격
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
                
                return section
            }
        }
        return layout
    }
}