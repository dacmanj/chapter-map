# config/initializers/paperclip.rb
Paperclip::Attachment.default_options[:url] = ':s3_domain_url'
Paperclip::Attachment.default_options[:path] = ':databaseid/:files/:filename'
# next year: Paperclip::Attachment.default_options[:path] = ':class/:attachment/:id/:filename'
Paperclip::Attachment.default_options[:s3_permissions] = 'public-read'
