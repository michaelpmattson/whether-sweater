class BackgroundSerializer
  include JSONAPI::Serializer

  attributes :location, :url, :credit
end
