# Run RubyOnRails on Docker

Usage

- We need to build and run the web app

$ docker build -t ruby-rails:1.0 .

- Later we can check the image using:

$ docker images

- Let’s create a container and run the app

$ docker run -it -v /path/to/www/:/var/www/ -p 3000:3000 ruby-rails:1.0

- You can just open your browser at: 

http://localhost:3000 or you can get the container IP: docker inspect CONTAINER ID | grep IPAddress

(you can also run docker inspect --format '{{.NetworkSettings.IPAddress}}' CONTAINER ID )

In my case it is: "IPAddress": "172.17.0.2"

rails server -b 172.17.0.2

So, just open the browser and point it to http://172.17.0.2:3000 and you will see the rails app running :)
