class Box < ActiveRecord::Base
  attr_accessible :content_id, :content_type, :position
  belongs_to :content, polymorphic: true
  scope :active, where("position is not null").order("position ASC")
  validates_uniqueness_of :position, allow_nil: true

  def first_line
    [:teaser_text, :occurrence].each do |method_name|
      return content.send method_name if content.respond_to? method_name
    end

    return nil
  end

  def first_line?
    !!first_line
  end

  def second_line
    [:headline, :title].each do |method_name|
      return content.send method_name if content.respond_to? method_name
    end
  end

  def second_line?
    !!second_line
  end
end
