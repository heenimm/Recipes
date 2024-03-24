import UIKit
import PlaygroundSupport


class EightImage: UIView {
     public var ivs = [UIImageView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 0, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 100, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100)))
        
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 300, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 300, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 400, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 400, width: 100, height: 100)))
        
        for i in 0...7 {
            ivs[i].contentMode = .scaleAspectFit
            self.addSubview(ivs[i])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

var view = EightImage(frame: CGRect(x: 0, y: 0, width: 700, height: 900))
view.backgroundColor = .red
let imageURLs = ["http://www.planetware.com/photos-larg...",
                 "http://adriatic-lines.com/wp-content/...",
                 "http://bestkora.com/IosDeveloper/wp-c...",
                 "http://www.picture-newsletter.com/arc..." ]
var images = [UIImage]()

PlaygroundPage.current.liveView = view

// метод возвращает картинку с сети по одной, всего 4
func asyncLoad(imageURL: URL,
              runQueue: DispatchQueue,
              completionQueue: DispatchQueue,
              completion: @escaping (UIImage?, Error?)-> ()){    do {
    let data = try Data(contentsOf: imageURL)
    completionQueue.async {
        completion(UIImage(data: data), nil)
        }
    } catch let error {
        completion(nil, error)
        }
}

//метод возвращает группу асинхронных операций
func asyncGroup() {
    let asGroup = DispatchGroup()
    for i in 0...3 {
        asGroup.enter()
        asyncLoad(imageURL: URL(string: imageURLs[i])!,
                 runQueue: .global(),
                 completionQueue: .main) { result, error in
            guard let image = result  else { return }
            images.append(image)
            asGroup.leave()
        }
    }
    //после получения всех элементов переходим в майн поток и все отрисовываем
    asGroup.notify(queue: .main) {
        for i in 0...3 {
            view.ivs[i].image = images[i]
        }
    }
}

asyncGroup()
