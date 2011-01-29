class SiteConnector
  HTTP_STATUS_ARY=[
    {:http_status_code => 100 , :comment => "Continue"},
    {:http_status_code => 101 , :comment => "Switching Protocols"},
    {:http_status_code => 200 , :comment => "OK"},            
    {:http_status_code => 201 , :comment => "Created"},
    {:http_status_code => 202 , :comment => "Accepted"},
    {:http_status_code => 203 , :comment => "Non-Authoritative Information"},
    {:http_status_code => 204 , :comment => "No Content"},
    {:http_status_code => 205 , :comment => "Reset Content"},
    {:http_status_code => 206 , :comment => "Partial Content"},
    {:http_status_code => 300 , :comment => "Multiple Choices"},
    {:http_status_code => 301 , :comment => "Moved Permanently"},
    {:http_status_code => 302 , :comment => "Found"},
    {:http_status_code => 303 , :comment => "See Other"},
    {:http_status_code => 304 , :comment => "Not Modified"},
    {:http_status_code => 305 , :comment => "Use Proxy"},
    {:http_status_code => 306 , :comment => "Unused"},
    {:http_status_code => 307 , :comment => "Temporary Redirect"},
    {:http_status_code => 400 , :comment => "Bad Request"},
    {:http_status_code => 401 , :comment => "Unauthorized"},
    {:http_status_code => 402 , :comment => "Payment Required"},
    {:http_status_code => 403 , :comment => "Forbidden"},
    {:http_status_code => 404 , :comment => "Not Found"},
    {:http_status_code => 405 , :comment => "Method Not Allowed"},
    {:http_status_code => 406 , :comment => "Not Acceptable"},
    {:http_status_code => 407 , :comment => "Proxy Authentication Required"},
    {:http_status_code => 408 , :comment => "Request Timeout"},
    {:http_status_code => 409 , :comment => "Conflict"},
    {:http_status_code => 410 , :comment => "Gone"},
    {:http_status_code => 411 , :comment => "Length Required"},
    {:http_status_code => 412 , :comment => "Precondition Failed"},
    {:http_status_code => 413 , :comment => "Request Entity Too Large"},
    {:http_status_code => 414 , :comment => "Request-URI Too Long"},
    {:http_status_code => 415 , :comment => "Unsupported Media Type"},
    {:http_status_code => 416 , :comment => "Requested Range Not Satisfiable"},
    {:http_status_code => 417 , :comment => "Expectation Failed"},
    {:http_status_code => 500 , :comment => "Internal Server Error"},
    {:http_status_code => 501 , :comment => "Not Implemented"},
    {:http_status_code => 502 , :comment => "Bad Gateway"},
    {:http_status_code => 503 , :comment => "Service Unavailable"},
    {:http_status_code => 504 , :comment => "Gateway Timeout"},
    {:http_status_code => 505 , :comment => "HTTP Version Not Supported"}
  ]
  class TrackData
    attr_accessor :url, :http_status_code , :speed
  end
  attr_accessor :connector
  def initialize
    @connector = Typhoeus::Hydra.new
  end
  def check_connect(url_ary)
    track_data_ary = []
    url_ary.map do |url|
      request = Typhoeus::Request.new(url)
      track_data = TrackData.new
      track_data.url = url
      request.on_complete do |response|
        track_data.http_status_code = response.code
        track_data.speed = 
          response.success? ? 
            (response.body.size / response.time).to_i :
            0
        track_data_ary << track_data
      end
      @connector.queue request
    end
    @connector.run 
    track_data_ary
  end
end
