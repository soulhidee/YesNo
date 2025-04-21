import Foundation

struct NetworkClient {
    func fetch(url: URL, handler: @escaping (Result<Data, Error>) -> Void) {
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                handler(.failure(AppError.network(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                handler(.failure(AppError.codeError))
                return
            }
            
            guard let data else {
                handler(.failure(AppError.noData))
                return
            }
            
            handler(.success(data))
        }
        
        task.resume()
    }
}
