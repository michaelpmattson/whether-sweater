class Activity
  attr_reader :type,
              :participants,
              :price

  def initialize(data)
    @type         = data[:type]
    @participants = data[:participants]
    @price        = data[:price]
  end
end
