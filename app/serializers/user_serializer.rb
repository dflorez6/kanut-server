class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :first_name, :last_name, :name
end

# Reference
# >> rails g serializer user id email name
# It generates a serializer with the attributes mentioned that we can later call using the following command:
#
# UserSerializer.new(#user).serializable_hash[:data][:attributes]
# replace #user with the actual variable containing the user information.