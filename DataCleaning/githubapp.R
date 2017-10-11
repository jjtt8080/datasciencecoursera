library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at 
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("DSCleaningData",
  key = "Iv1.04bb418214209584",
  secret = "2153c02194154477218c3d50717947f5786fe79e")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos")
stop_for_status(req)
rJ <-fromJSON(req)
require(data.table)
dt <- data.table(rJ)
## access the created_at when the name is sharing
dt[which(dt$name=="datasharing"), created_at]

