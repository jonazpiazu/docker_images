# README

Docker image to load pointclouds and visualize them using the [potree cloud viewer](https://github.com/potree)

## Usage

Save your pointclouds (.ply, .ptx, .laz, .las) into a folder. Go into that folder, and run:

```
docker run -dit --name=potree_viewer --rm -p 8080:80 -v "$PWD":/shared  potree
```

Then open a web browser to http://localhost:8080/
