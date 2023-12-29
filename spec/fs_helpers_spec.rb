require 'spec_helper'
require_relative '../lib/ruby/fs_helpers'

describe FsHelpers do
  describe '#relativize_symlink_target' do
    include FsHelpers

    TABLE = [
      ['/a/b/c', '/a/b/x', 'x'],
      #['/a/b/c', '/a/b', '..'],
      ['/a/b/c', '/a/x/y', '../x/y'],
    ]

    TABLE.each do |link_, target_, rel_|
      link, target, rel = link_, target_, rel_
      context "#{link} -> #{target}" do
        it 'returns correct result' do
          relativize_symlink_target(target, link).should == rel
        end
      end
    end
  end
end
