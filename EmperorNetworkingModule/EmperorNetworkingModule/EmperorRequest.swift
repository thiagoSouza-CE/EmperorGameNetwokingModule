import Foundation

// MARK: - HTTP Method
enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

// MARK: - API Error
enum APIError: Error {
    case invalidURL
    case requestFailed
    case decodingError
}

// MARK: - Generic Request
struct APIRequest {
    
    static func request<T: Codable>(
        url: String,
        method: HTTPMethod = .GET,
        body: Encodable? = nil,
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Se tiver body, transforma em JSON
        if let body = body {
            do {
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                completion(.failure(.requestFailed))
                return
            }
        }
        
        // Executa a requisição
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let data = data,
                error == nil
            else {
                completion(.failure(.requestFailed))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
