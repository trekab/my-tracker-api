class AddUserToCategories < ActiveRecord::Migration[6.0]
  def change
    add_reference :categories, :user, null: false, foreign_key: true
  end
end
