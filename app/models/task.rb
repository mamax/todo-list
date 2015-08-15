class Task < ActiveRecord::Base
  belongs_to :project
  default_scope -> { order('created_at DESC') }
  validates :project_id, presence: true
  validates :content, presence: true, length: { maximum: 100 }
end
