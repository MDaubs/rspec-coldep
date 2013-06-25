require 'spec_helper'

describe 'usage' do
  it 'mocks an undefined constant' do
    dependency 'User' do
      User.find('1234') == 'a single fake user'
      User.all == 'a couple fake users'
    end

    expect(User.find('1234')).to eq('a single fake user')
    expect(User.all).to eq('a couple fake users')
  end

  it 'creates a test double' do
    user = collaborator do |user|
      user.first_name == 'Billy'
      user.last_name == 'Jean'
    end

    expect(user.first_name).to eq('Billy')
    expect(user.last_name).to eq('Jean')
  end

  it 'allows defining collaborators inside of dependencies' do
    dependency 'User' do
      User.find('1234') == collaborator do |user|
        user.permalink == '1234-billy-jean'
      end
    end

    expect(User.find('1234').permalink).to eq('1234-billy-jean')
  end
end
