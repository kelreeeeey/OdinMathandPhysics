# all:
# 	odin build . -out:./bin/syndatagen.exe --debug

all:
	odin build ./test -out:./bin/test.exe --debug

clean:
	rm ./bin/test.exe
	rm *.exe

run_test:
	./bin/test.exe
