class RemoveEmailDomainFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :email_domain, :string
  end
end
