module RequestSpecHelper
  def valid_headers
    headers = { "Content-Type" => "application/json" }
    # add other headers as needed, such as authorization tokens
    headers
  end

  def json
    JSON.parse(response.body)
  end
end
