import UIKit
import Alamofire
import NetworkingCore


let ds = Datasource(path: "", method: .post, parameters: UserParamsProvider.self, headers: TokenProvider.self, returnType: ApiResponse.self, consumer: ResponseConsumer.self, datasourceType: "local")
let env = TestEnviroment(hostString: "http://localhost:3000", apiString: "v1")


Core.registerEnviroment(enviroment: env)
Core.registerDatasource(datasource: ds)

Core.go(datasourceType: "local", returnType: ApiResponse.self) { (error) in
    print(error)
}
