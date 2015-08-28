require 'spec_helper'
require_relative '../../../../apps/api/views/dashboard/index'

describe Api::Views::Dashboard::Index do
  let(:view)      { Api::Views::Dashboard::Index.new(nil, {}) }
  let(:rendered)  { view.render }

  it "renders json" do
    expect(view.render).to eq(JSON.generate({foo: 'bar'}))
  end
end
