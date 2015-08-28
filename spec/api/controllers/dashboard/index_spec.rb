require 'spec_helper'
require_relative '../../../../apps/api/controllers/dashboard/index'

describe Api::Controllers::Dashboard::Index do
  let(:action) { Api::Controllers::Dashboard::Index.new }
  let(:params) { Hash[] }

  it "is successful" do
    response = action.call(params)
    expect(response[0]).to eq(200)
  end
end
