module HttpStuff where
  
import Data.ByteString.Lazy hiding (map)
import Network.Wreq

urls :: [String]
urls = [
        "https://www.baidu.com/",
        "http://www.jianshu.com/"
        ]
        
mappingGet :: [IO (Response ByteString)]
mappingGet = map get urls

traversedUrls :: IO [(Response ByteString)]
traversedUrls = traverse get urls