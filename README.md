
# Crunch
Facebook page likes and comments counter, discover your most active fans and users!
##	You will need 'git' installed.
`git clone git@github.com:jdarc/crunch.git`
# You will need 'ruby' installed/
This software was developed on Ubuntu 16.04 LTS using Ruby 2.3.1p112
`ruby --version`
## Install bundler which will be managing all of the gems
`gem install bundler`
## Run the tests
`bundler exec rake test`
## Obtain access token
* Visit https://developers.facebook.com/tools/explorer/
* Obtain a page access token (Get Token -> Get Page Access Token)
* Copy the value of the access token to your systems clipboard
* Open config.yml file
* Remove the existing value of oauth_access_token
* Paste the newly obtained value of oauth_access_token after the semicolon

These temporary tokens expire after approximately 60 minutes, simply request a new token using the graph explorer and repeat the above steps as necessary.
## Run the program
By default the program will read page id's and totals from a CSV file called example.csv in the data folder, it will also output the results to a file called result.csv in the data folder.
`bundler exec ./bin/crunch`
or
`bundler exec ./bin/crunch --help` (to specify different paths for input and output files)
## Disclaimer
Test driven development, Domain driven development and frequent check-ins with sensible comments, absolutely vital when working in a team, but for this simple exercise I wrote a spike, got that working, then wrote a single test for the payload processor before refactoring it! For this simple exercise creating a domain model would have been overkill!
