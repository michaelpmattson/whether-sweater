class Activity
  attr_reader :name,
              :type,
              :participants,
              :price

  def initialize(data)
    @name         = data[:activity]
    @type         = data[:type]
    @participants = data[:participants]
    @price        = data[:price]
  end
end
