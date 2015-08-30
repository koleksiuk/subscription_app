require 'spec_helper'
require_relative '../../../../apps/web/views/page/index'

describe Web::Views::Page::Index do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Lotus::View::Template.new('apps/web/templates/page/index.html.erb') }
  let(:view)      { Web::Views::Page::Index.new(template, exposures) }
  let(:rendered)  { view.render }

  it "exposes #foo" do
    expect(view.foo).to eq exposures.fetch(:foo)
  end
end
