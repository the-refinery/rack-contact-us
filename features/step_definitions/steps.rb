def build_mailer(mailer,config)
  ContactUs.mailer_dir.tap do |root|
    FileUtils.mkdir_p root if !File.directory? root
    File.open File.join(root, mailer), "w" do |f|
      f.write config.to_yaml
    end
  end
  config
end

Given /^a mailer named "(.*?)" exists with:$/ do |filename,config|
  @mailer = build_mailer(filename,config.hashes.first)
end

When /^I post to "(.*?)"$/ do |path|
  post path
end

Then /^the designated recipient receives an email$/ do
  expect(find_email(@mailer[:to])).to_not be_nil
end

When /^I post to "(.*?)" with:$/ do |path, table|
  params = table.hashes.first
  post path, params
end

Then /^the designated recipient receives an email from "(.*?)"$/ do |from|
  email = find_email(@mailer[:to])
  expect(email.from).to include(from)
end

Given /^a mailer named "(.*?)" exists with headers:$/ do |filename, table|
  @mailer = build_mailer(filename, to: "doo@diddy.com", headers: table.hashes.first)
end

Then /^the designated recipient receives an email with headers:$/ do |table|

end

