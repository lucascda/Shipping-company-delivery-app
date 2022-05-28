require 'rails_helper'

RSpec.describe OrderService, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'attr source_adress deve estar presente' do
        order = OrderService.new(source_adress: '')
        order.valid?
        expect(order.errors.include? :source_adress).to eq true
      end

      it 'attr dest_adress deve estar presente' do
        order = OrderService.new(dest_adress: '')
        order.valid?
        expect(order.errors.include? :dest_adress).to eq true        
      end

      it 'attr code deve estar presente' do
        first_carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
          email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
          adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
          country: 'Brasil', status: 0)
        first_vehicle = Vehicle.create!(plate: 'GVX-5062', brand_name: 'Honda' , model: 'Fit EXL 1.5 Flex/Flexone 16V 5p Aut',
                                        fab_year: '2009', max_cap: 85 , carrier: first_carrier)
        first_order = OrderService.new(source_adress: 'Rua das Olimpias, Sâo Geraldo, 200, São Paulo, SP',
              dest_adress: 'Rua 21 de Abril, Setor Estrela Dalva, Goiânia, GO ',
              volume: 0.005, weight: 5.5, carrier: first_carrier, product_code: 'SAMSU-TV32-4570',
              coordinates: '14:50 -16.67861, -49.25389', accepted_status: 1, order_status: 1, vehicle: first_vehicle)
        
        expect(first_order.valid?).to be true
      end

      it 'attr product_code deve estar presente' do
        order = OrderService.new(product_code: '')
        order.valid?
        expect(order.errors.include? :product_code).to eq true
      end

     

      it 'attr volume deve estar presente' do
        order = OrderService.new(volume: '')
        order.valid?
        expect(order.errors.include? :volume).to eq true
      end

      it 'attr weight deve estar presente' do
        order = OrderService.new(weight: '')
        order.valid?
        expect(order.errors.include? :weight).to eq true
      end

      
      it 'attr order_status deve estar presente' do
        order = OrderService.new(order_status: '')
        order.valid?
        expect(order.errors.include? :order_status).to eq true
      end

      it 'attr order_status deve estar presente e é zero por default' do
        order = OrderService.new()
        order.valid?
        expect(order.order_status).to eq 'awaiting_approval'
      end

      it 'attr accepted_status deve estar presente e é zero por default' do
        order = OrderService.new()
        order.valid?
        expect(order.accepted_status).to eq 'waiting'       
      end

      it 'attr accepted_status deve estar presente' do
        order = OrderService.new(accepted_status: '')
        order.valid?
        expect(order.errors.include? :accepted_status).to eq true
      end

      it 'attr carrier deve estar presente' do
        order = OrderService.new(carrier: nil)
        order.valid?
        expect(order.errors.include? :carrier).to eq true
      end

      
    end

    context 'comparison' do
      it 'attr volume deve ser maior que zero' do
        order = OrderService.new(volume: -0.1)
        second_order = OrderService.new(volume: 0)
        third_order = OrderService.new(volume: 1)
        order.valid?
        second_order.valid?
        third_order.valid?
        expect(order.errors.include? :volume).to eq true
        expect(second_order.errors.include? :volume).to eq true
        expect(third_order.errors.include? :volume).to eq false
      end

      it 'attr weight deve ser maior que zero' do
        order = OrderService.new(weight: -0.1)
        second_order = OrderService.new(weight: 0)
        third_order = OrderService.new(weight: 1)
        order.valid?
        second_order.valid?
        third_order.valid?
        expect(order.errors.include? :weight).to eq true
        expect(second_order.errors.include? :weight).to eq true
        expect(third_order.errors.include? :weight).to eq false

      end
    end
  end

  describe 'gera um attr code aleatorio de 15 caracteres' do
    it 'ao criar uma nova ordem de serviço' do
      first_carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
        email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
        adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
        country: 'Brasil', status: 0)
      first_vehicle = Vehicle.create!(plate: 'GVX-5062', brand_name: 'Honda' , model: 'Fit EXL 1.5 Flex/Flexone 16V 5p Aut',
                                      fab_year: '2009', max_cap: 85 , carrier: first_carrier)
      first_order = OrderService.new(source_adress: 'Rua das Olimpias, Sâo Geraldo, 200, São Paulo, SP',
            dest_adress: 'Rua 21 de Abril, Setor Estrela Dalva, Goiânia, GO ',
            volume: 0.005, weight: 5.5, carrier: first_carrier, product_code: 'SAMSU-TV32-4570',
            coordinates: '14:50 -16.67861, -49.25389', accepted_status: 1, order_status: 1, vehicle: first_vehicle)
      first_order.save!
      result = first_order.code
      expect(result).not_to be_empty
      expect(result.length).to eq 15
    end
    
    it 'e o código gerado é unico' do
      first_carrier = Carrier.create!(corporate_name: 'Jamef Transportes Eireli', brand_name: 'Jamef',
        email_domain: 'www.jamef.com.br',registration_number: '20147617002276',
        adress: 'Rodovia Marechal Rondon, Km 348', city: 'Barueri', state: 'São Paulo',
        country: 'Brasil', status: 0)
      first_vehicle = Vehicle.create!(plate: 'GVX-5062', brand_name: 'Honda' , model: 'Fit EXL 1.5 Flex/Flexone 16V 5p Aut',
                                      fab_year: '2009', max_cap: 85 , carrier: first_carrier)
      first_order = OrderService.new(source_adress: 'Rua das Olimpias, Sâo Geraldo, 200, São Paulo, SP',
            dest_adress: 'Rua 21 de Abril, Setor Estrela Dalva, Goiânia, GO ',
            volume: 0.005, weight: 5.5, carrier: first_carrier, product_code: 'SAMSU-TV32-4570',
            coordinates: '14:50 -16.67861, -49.25389', accepted_status: 1, order_status: 1, vehicle: first_vehicle)
      second_order = OrderService.new(source_adress: 'Rua das Olimpias, Sâo Geraldo, 200, São Paulo, SP',
              dest_adress: 'Rua 21 de Abril, Setor Estrela Dalva, Goiânia, GO ',
              volume: 0.005, weight: 5.5, carrier: first_carrier, product_code: 'SAMSU-TV32-4570',
              coordinates: '14:50 -16.67861, -49.25389', accepted_status: 1, order_status: 1, vehicle: first_vehicle)
      first_order.save!
      second_order.save!
      expect(first_order.code).not_to eq second_order.code
    end
  end

  
end
