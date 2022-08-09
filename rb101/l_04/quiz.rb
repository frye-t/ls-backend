mailing_campaign_leads = [
  {name: 'Emma Lopez', email: 'emma.lopez@some_mail.com', days_since_login: 423, mailing_list: true},
  {name: 'mike richards', email: 'michael.richards@some_mail.com', days_since_login: 23, mailing_list: false},
  {name: 'JANE WILLIAMS', email: 'jane_w95@my_mail.com', days_since_login: 16, mailing_list: true},
  {name: 'Ash Patel', email: 'ash_patel@my_mail.com', days_since_login: 22, mailing_list: true}
]

counter = 0
## Capitalize lead names in the array of hashes
# Loop through each hash in the array
loop do
  break if counter == mailing_campaign_leads.size
  
  # Grab name from hash we're iterating on and split into array
  full_name = mailing_campaign_leads[counter][:name]
  names = full_name.split

  # Loop over array, capitalize each name
  names_counter = 0
  loop do
    break if names_counter == names.size
    name = names[names_counter]
    names[names_counter] = name.capitalize

    names_counter += 1
  end

  # Join array of name strings back into a single string and replace name in orig hash
  capitalized_full_name = names.join(' ')
  mailing_campaign_leads[counter][:name] = capitalized_full_name

  counter += 1
end

## Create an array of usable leads, based on login and mailing list
# Loop through each hash in the array
usable_leads = []
counter = 0

loop do
  break if counter == mailing_campaign_leads.size
  # Grab the days for last login, and bool value for if they are subbed to mailing list
  last_login = mailing_campaign_leads[counter][:days_since_login]
  subscribed_to_list = mailing_campaign_leads[counter][:mailing_list]

  # If logged in within 60 days and are a part of the mailing list, add them to usable leads
  if last_login < 60 && subscribed_to_list
    usable_leads << mailing_campaign_leads[counter]
  end

  counter += 1
end

p usable_leads
p mailing_campaign_leads