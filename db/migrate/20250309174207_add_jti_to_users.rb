class AddJtiToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :jti, :string

    # Заповнюємо стовпець jti унікальними значеннями для кожного користувача
    User.find_each do |user|
      user.update!(jti: SecureRandom.uuid)
    end

    change_column_null :users, :jti, false
    add_index :users, :jti, unique: true
  end
end
