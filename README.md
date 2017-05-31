# Dojo

## The Code

Some example projects in multiple languages setup to be ready to jump in and start writing some tests.

To get started run one of the following:

```
$ make elm
$ make javascript
$ make java
$ make php
```

> Note: The .gitignore files are setup to ignore any code that's not the examples. This is because you don't need to commit your kata results, it's the exercise, not that result that's important! It's also to stop me accidentally commiting my own katas to this repo! 

There's also some resources setup such as file watchers for Intellij. To install the file watchers run:

```
$ make intellij-file-watchers 
```

## The Katas

### Prime Factors

Write a function which takes a number and return a list of its prime factors.

e.g.

```
factorise(6); // returns [ 2, 3 ]
```

Table of prime factors:
> ![Prime Factors Table](https://raw.githubusercontent.com/danrspencer/dojo/master/katas/prime_factors.gif "Prime Factors Table")
