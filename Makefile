all:
	odin build ./test/mp/ -out:./bin/test_mp.exe --debug
	odin build ./test/mpplot/ -out:./bin/test_mpplot.exe --debug

clean:
	rm ./bin/*.exe
	rm *.exe

test_mp:
	./bin/test_mp.exe

test_mpplot:
	./bin/test_mpplot.exe 100 -10 10.1
	# ./bin/test_mpplot.exe 200 -20 0.001
