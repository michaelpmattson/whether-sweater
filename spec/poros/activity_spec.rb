require 'rails_helper'

RSpec.describe Activity do
  before(:each) do
    data = {:activity=>"Teach your dog a new trick", :type=>"relaxation", :participants=>1, :price=>0.05, :link=>"", :key=>"1668223", :accessibility=>0.15}
    @activity = Activity.new(data)
  end

  it 'exists and has attributes' do
    expect(@activity).to be_an(Activity)
    expect(@activity.type).to eq("relaxation")
    expect(@activity.participants).to eq(1)
    expect(@activity.price).to eq(0.05)
  end
end
