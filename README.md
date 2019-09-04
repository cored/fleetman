# README

# Setup

### Install Postgres

#### Mac OSX
`
$ brew install postgres`

`$ gem install lunch # This will allow you to start and stop PostgreSQL`

`$ mkdir -p ~/Library/LaunchAgents`

`$ cp /usr/local/Cellar/postgresql/<INSTALLED_VERSION>/homebrew.mxcl.postgresql.plist ~/Library/LaunchAgents/ # Notice the use of your installed version`

`$ lunchy start postgres`

### Initialize Database
