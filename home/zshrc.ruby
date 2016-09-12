if which bundler >/dev/null 2>&1; then
  alias bi='bundle install'
  alias bu='bundle update'
  alias be='bundle exec'
  alias br='bundle exec rake'
  alias bs='bundle exec rspec'
  alias brs='bundle exec rescue rspec'
  alias bpa='bundle pack --all'
fi
