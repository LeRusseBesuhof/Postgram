import Foundation

final class StorageManager {
    static let shared = StorageManager()
    private init() { }
    
    private func getPath() -> URL? {
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first else {
            return nil
        }
        return path
    }
    
    func saveImageData(_ data: Data, _ imageName: String) {
        if var path = getPath() {
            path.append(path: imageName)
            do {
                try data.write(to: path)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func getImageData(byImageName name: String) -> Data? {
        guard var path = getPath() else { return nil }
        path.append(path: name)
        do {
            let imageData = try Data(contentsOf: path)
            return imageData
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func removeObjects() {
        guard let path = getPath() else { return }
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(atPath: path.path)
            for img in fileURLs {
                let imgPath = path.appending(path: img)
                print(imgPath)
                try FileManager.default.removeItem(atPath: imgPath.path)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
