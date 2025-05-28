import FirebaseRemoteConfig

class RemoteConfigService {
    
    static let shared = RemoteConfigService()
    private let remoteConfig = RemoteConfig.remoteConfig()
    
    private init() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0 // всегда обновлять
        remoteConfig.configSettings = settings
    }
    
    func fetchConfig(completion: @escaping (AppConfig?) -> Void) {
        remoteConfig.fetchAndActivate { status, error in
            let jsonString = self.remoteConfig["app_config"].stringValue
            if let data = jsonString.data(using: .utf8),
               let config = try? JSONDecoder().decode(AppConfig.self, from: data) {
                completion(config)
            } else {
                completion(nil)
            }
            
        }
    }
}
