
import UIKit

class ElipseView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(image: String) {
        super.init(frame: .zero)

        //        UIImage(systemName: image)
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
    }
}
