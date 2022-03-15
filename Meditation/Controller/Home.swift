//
//  Home.swift
//  Meditation
//
//  Created by Глеб Голощапов on 15.03.2022.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class Home: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
        
    var feelingList: [FeelingModel] = []
    @IBOutlet weak var feelingCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFeelings()
        
        feelingCollectionView.delegate = self
        feelingCollectionView.dataSource = self
    }
    
    func getFeelings() {
        let url = "http://mskko2021.mad.hakta.pro/api/feelings"
        
        AF.request(url, method: .get).validate().response { response in
            switch response.result {
            case .success(let value):
                let answer = JSON(value!)
                for i in answer["data"] {
                    self.feelingList.append(FeelingModel(id: i.1["id"].intValue, position: i.1["position"].intValue, title: i.1["title"].stringValue, image: i.1["image"].stringValue))
                }
                print(self.feelingList)
                self.feelingCollectionView.reloadData()
            case .failure(let error):
                self.alert(message: error.localizedDescription)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feelingList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Feeling", for: indexPath) as! Feeling
        
        cell.image.sd_setImage(with: URL(string: feelingList[indexPath.row].image), completed: nil)
        
        cell.name.text = feelingList[indexPath.row].title
        
        return cell
    }

    
    func alert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }

}
