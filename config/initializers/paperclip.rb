Paperclip.options[:command_path] = "/usr/local/bin/"

Paperclip::Attachment.default_options.merge!(
  storage: :s3,
  s3_host_name: 's3-ap-southeast-1.amazonaws.com',
  s3_region: ENV['AWS_REGION'],
  s3_credentials: {
    access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    bucket: 'aot-test'
  },
  s3_headers: {
    "Expires": (Time.zone.now + 10 * 12 * 30 * 24 * 3600).httpdate,
    "Cache-Control": "max-age = #{10 * 12 * 30 * 24 * 3600}" # 10 years
  }
)
