# == Schema Information
#
# Table name: connections
#
#  id                :bigint           not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  connected_user_id :integer          not null
#  user_id           :integer          not null
#
# Indexes
#
#  index_connections_on_connected_user_id              (connected_user_id)
#  index_connections_on_user_id                        (user_id)
#  index_connections_on_user_id_and_connected_user_id  (user_id,connected_user_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (connected_user_id => users.id)
#  fk_rails_...  (user_id => users.id)
#
class Connection < ApplicationRecord
  belongs_to :user
  belongs_to :connected_user, class_name: "User"
end
