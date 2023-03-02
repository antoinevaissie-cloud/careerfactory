class AddCompanyDescriptionsToCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :company_descriptions, :text
  end
end
