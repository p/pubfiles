have() {
  which "$@" >/dev/null 2>&1
}

if have rbenv; then
  eval "$(rbenv init -)"
fi

if have bundler; then
  register_fuubar() {
    echo pwd >>$HOME/.fuubar-paths
  }
  deregister_fuubar() {
    set -e
    if test -f $HOME/.fuubar-paths; then
      tempfile=`mktemp`
      <$HOME/.fuubar-paths grep -v `pwd` >$tempfile
      <$tempfile >$HOME/.fuubar-paths
    fi
  }
  alias bi='bundle install'
  alias bu='bundle update'
  alias be='bundle exec'
  alias br='bundle exec rake'
  bs() {
    args=
    if test -f $HOME/.fuubar-paths && grep -q `pwd` $HOME/.fuubar-paths; then
      args="$args --format Fuubar"
    fi
    bundle exec rspec $args "$@"
  }
  #alias bs='bundle exec rspec --format Fuubar'
  alias brs='bundle exec rescue rspec'
  alias bpa='bundle pack --all'
  alias rrake='rm -f *.lock; rake'
  
  xbss() {
	sed -e 's/^ *//' -e 's/[ :].*//' -e 's,^lib/,spec/,' -e 's/\.rb$/_spec.rb/' |xargs ls |xargs bundle exec rspec "$@"
  }
fi

if have irb; then
  export RUBY_DEBUG_IRB_CONSOLE=1
fi
