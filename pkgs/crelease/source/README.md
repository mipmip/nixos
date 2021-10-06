# CRelease

Application to simpify versioning and releasing crystal projects.

## Installation

### With Homebrew 
1. `brew install elorest/homebrew-crystal/crelease`

### From Source
1. `git clone https://github.com/elorest/crelease.git`
2. `cd crelease`
3. `make`



## General Usage

`crelease 0.0.1` will update shards.yml and src/yourproject/version.cr to 0.1.1 and then create tags and push to git.
`crelease 0.0.1 "commit message"` will do the same as above but with a custom commit message. 

## Amber Specific Usage

1. Create new branch with version name. i.e. `is/0.2.9`.
2. Run `crelease 0.2.9`.
3. Create PR for new branch.
4. Merge it in without squashing.



## Contributing

1. Fork it ( https://github.com/elorest/crelease/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [elorest](https://github.com/elorest) Isaac Sloan - creator, maintainer
- [lady-elorest](https://github.com/lady-elorest) Shuana Sloan - documention
