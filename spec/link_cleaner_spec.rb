require 'spec_helper'
require_relative '../lib/ruby/link_cleaner'

describe LinkCleaner do
  let(:cleaner) { described_class.new }

  describe '#clean_via_regexp' do
    [
      {
        name: 'amazon',
        input: 'https://www.amazon.com/RST-Tractech-Sport-Mens-Black/dp/B09VC7VS3D/ref=sr_1_6?crid=CMDLUM0P877K&dib=eyJ2IjoiMSJ9.cs6WxR-d6IYGCa5ttctABE-D0SfZkfBH0gTl9lySwkBDNog_xSUkATonrg-3D0_adcyrM4gQx6U-g6KtexJ2MBcPza-ZCeguETUGG5RaaSzcV26GlZtGnfbhPA3vYv0-xhFKaL0LAZ96OV1q22FixlqLhgwN2dmPn0jyjiPUyFoKMTMzP1b0g66bFRNN847_S7OTaCDOlZrcSLl2Y9Aj2ruSTLO7FI4zYxRoAaqknUbVMTyYQUfZBT9BQXh_a4AGSY1KlhXU-myFWRkOTqsIG0H6GfB9nODNPGHdLrNoT7g.vWmWSWklLRVAjKMqgsK41uLI-0Xv493cMjNmIj1M398&dib_tag=se&keywords=rst+boots&qid=1752863097&sprefix=rst+boots%2Caps%2C187&sr=8-6',
        output: 'https://www.amazon.com/RST-Tractech-Sport-Mens-Black/dp/B09VC7VS3D',
      },
    ].each do |spec|
      context(spec.fetch(:name)) do
        let(:input) { spec.fetch(:input) }
        let(:output) { spec.fetch(:output) }

        it 'transforms as expected' do
          cleaner.send(:clean_via_regexp, input).should == output
        end
      end
    end
  end
end
