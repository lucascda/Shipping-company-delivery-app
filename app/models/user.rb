class User < ApplicationRecord
  before_validation :set_carrier
  validates :name, presence: true
 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  belongs_to :carrier
  
  
  private
  

  def set_carrier
    if self.email.present?
      email = self.email    
      self.carrier = check_email_domain(email) 
    end   
  end

  def check_email_domain(email)
    carrier = Carrier.find_by(email_domain: extract_email_domain(email))
    if carrier.nil?
      nil
    else
      carrier
    end      
  end

  # @@ gera a string dominio de email a partir do input do usuario
  def extract_email_domain(email)
    # identifica posicao do @ no email
    arroba_pos = email.index('@')
    # monta a string final
    my_string = 'www.' + email.slice(arroba_pos + 1..-1)        
  end  
end
