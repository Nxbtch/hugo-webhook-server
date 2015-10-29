require 'webrick'
require 'json'

blog_dir = '~/blog'

class Simple < WEBrick::HTTPServlet::AbstractServlet
  def do_POST request, response
    payload = JSON.parse(request.body)
    if payload["ref"] == "refs/heads/master"
      system("cd #{blog_dir} && git pull")
    end
  end
end

server = WEBrick::HTTPServer.new :Port => 8081

server.mount "/", Simple

trap 'INT' do
	server.shutdown
end

server.start
