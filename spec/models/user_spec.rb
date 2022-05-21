require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    it 'deve receber uma carrier automaticamente' do
      user = User.new(email: 'joao@transportadora.com.br')
      result = user.valid?
      expect(user.errors.include? :carrier).to be true      
    end

    it 'o nome deve ser obrigatório' do
      user = User.new(name: '')
      result = user.valid?
      expect(user.errors.include? :name).to be true      
    end

    it 'o email deve ser obrigatorio' do
      user = User.new(email: '')
      result = user.valid?
      expect(user.errors.include? :email).to be true
      
    end

    it 'a senha deve ser obrigatoria' do
      user = User.new(password: '')
      result = user.valid?
      expect(user.errors.include? :password).to be true
    end

  end
  
end
