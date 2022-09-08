class GroupMember < ApplicationRecord
  belongs_to :group, class_name: 'Group', foreign_key: 'group_id'
  belongs_to :member, class_name: 'Member', foreign_key: 'member_id'
end
