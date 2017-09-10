module ApplicationHelper

  def device_columns
    [
      "Name",
      "Status",
      "Created At",
      "User Name"
    ]
  end

  def user_columns
    [
      "Name",
      "Provider",
      "Email",
      "OAuth Expires At",
      "Created At"
    ]
  end
end

