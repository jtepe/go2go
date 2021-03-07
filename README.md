# go2go
Docker image to experiment with go2. A build of the `dev.go2go` branch of [Go](https://github.com/golang/go).

As a convenience do `alias go2go='docker run --rm -v $(pwd):/home/gopher/go <image> go2go tool go2go`.

After this simply run `go2go run main.go2` for your Go2 source in `main.go2`. BAM.

```
Usage: go2go <command> [arguments]

The commands are:

	build      translate and build packages
	run        translate and run list of files
	test       translate and test packages
	translate  translate .go2 files into .go files
```

`translate` is quite nice, as it shows what e.g. generic functions look like (you could say, *stamped out*?) after type arguments are applied.

