#Question 1

getwd()
library(httr)
library(jsonlite)
# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("instructinfo",
                   key = "658ac4eaecf72ab38a75",
                   secret = "6e7fa39d47398094db7b2ccaccea38bf157e51ad")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
json = jsonlite::toJSON(content(req))
df = jsonlite::fromJSON(json, simplifyDataFrame = TRUE )
creation_time = df[df$name=="datasharing", c("id", "name", "created_at")]

