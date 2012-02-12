require 'rubygems'
require 'twitter'

def tweetToPost(tweet, template)
    title = tweet.text
    body = ""
    post = template.sub("#title", title).sub("#body",body)
    return post
end

# Read config file
conf = YAML.load_file("config.yml")

# Process tweet comments 
tweets = Twitter.user_timeline(conf["twitter"]["user"])
tweetFormat = conf["twitter"]["format"]
for index in 0 ... tweets.size
    tweet = tweets[index]
    post = tweetToPost(tweet, tweetFormat)
    time = tweet.created_at
    timeString = time.year.to_s + "-" + time.month.to_s + "-" + time.day.to_s
    destination = conf["output_dir"] + "/" + timeString  + "-" +
        tweet.text[0,64].tr('/','') + ".html"
    f = File.new(destination, "w")
    f.puts post
    f.close
end

