//
//  MainCategoryCollectionViewCell.swift
//  WomanApp
//
//  Created by botan pro on 9/3/21.
//

import UIKit

class MainCategoryCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var ViewOver: UIView!
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var Name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.ViewOver.layer.cornerRadius = 12
        self.Image.layer.cornerRadius = 12
    }
    
    func Update(category : MainCategoryObjects){
        self.Name.text = category.name
        let strUrl = "\(API.IMAGEURL)\(category.image)";
        guard let urlString = strUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else { return }
        let Url = URL(string: urlString)
        self.Image?.sd_setImage(with: Url, completed: nil)
    }
}
