have() {
  which "$@" >/dev/null 2>&1
}

if have bundler; then
  alias bi='bundle install'
  alias bu='bundle update'
  alias be='bundle exec'
  alias br='bundle exec rake'
  alias bs='bundle exec rspec'
  alias brs='bundle exec rescue rspec'
  alias bpa='bundle pack --all'
fi

if have rbenv; then
  eval "$(rbenv init -)"
fi
