Solutions to Project Euler challenges using Nim.

If you want to run Aporia (Nim IDE) on Ubuntu, you need to install the dependencies with:
```apt-get install build-essential libgtk2.0-dev libgtksourceview2.0-0```

To install Aporia itself, run:

```nimble install aporia```


To test a solution, run:

```sh test_program.sh <NAME>```

For example:

```sh test_program.sh euler_013_large_sum```

The above command compiles first using `nim c <NIM_FILE>`, for speed of compilation.
If everything works, it compiles again with `nim c -d:release <NIM_FILE>`, to squeeze
all performance available for the test.


However, to debug a program, it is useful to see a stack trace. To do so, use:

```sh test_program.sh <NAME> DEBUG```

This command does not perform the second compilation.


To test all of the solutions, run:

```sh test_all.sh```



Note: I am using both projecteuler.net and hackerrank.com.
The two websites have slightly different versions of the problems;
I normally stick to the projecteuler.net version but my programs usually
use input parameters, as in hackerrank.com, (as opposed to projecteuler.net,
which uses "constant" problems). There are exceptions to this.
