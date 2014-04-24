class Que < ActiveRecord::Base
  validates :name, presence: true

  def display_name
    "Mr. #{name}"
  end

  include Workflow
  workflow do
    state :new do
      event :nick_visit, transitions_to: :in_progress
    end
    state :in_progress do
      event :nick_leave, transitions_to: :completed
      event :nick_tried_helping, transitions_to: :still_confused
    end
    state :still_confused do
      event :nick_visit, transitions_to: :in_progress
    end
    state :completed
  end  
end
