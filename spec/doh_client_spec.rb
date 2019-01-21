# frozen_string_literal: true

RSpec.describe DoHClient do
  it "has a version number" do
    expect(DoHClient::VERSION).not_to be nil
  end
end
