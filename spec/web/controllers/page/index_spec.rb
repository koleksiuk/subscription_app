require 'spec_helper'
require_relative '../../../../apps/web/controllers/page/index'

describe Web::Controllers::Page::Index do
  let(:action) { Web::Controllers::Page::Index.new }
  let(:params) { Hash[] }

  it "is successful" do
    response = action.call(params)
    expect(response[0]).to eq 200
  end
end
