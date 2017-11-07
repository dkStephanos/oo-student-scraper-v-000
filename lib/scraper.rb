require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    profile_page = Nokogiri::HTML(html)
    students = []

    #Iterate through the students, adding them to the hash
    profile_page.css("div.student-card").each do |student|
      students << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a")[0]["href"]
      }
    end

    #return the students hash
    students
  end

  def self.scrape_profile_page(profile_url)

    linkedin_src = "../assets/img/linkedin-icon.png"
    facebook_src = "../assets/img/facebook-icon.png"
    twitter_src = "../assets/img/twitter-icon.png"
    github_src = "../assets/img/github-icon.png"
    youtube_src = "../assets/img/rss-icon.png"

    html = File.read(profile_url)
    profile_page = Nokogiri::HTML(html)
    student = {}

    #Iterate through the student, adding their profile_quote and bio to the hash
    profile_page.css("div.student-card").each do |profile_entry|
      student[:profile_quote] << profile_entry.css("div.profile-quote").text
      student[:bio] << profile_entry.css("div.description-holder>p").text
    end
    #Iterate through the student again, grabbing any links they appear and adding them to the hash
    #profile_page.css("div.social-container a").each do |link|
      #if link.css("img.social-icon").attribute("src").value == linkedin_src
        #student[:linkedin] << link.css("a")[0]["href"]
      #elsif link.css("img.social-icon").attribute("src").value == facebook_src
      #  student[:facebook] << link.css("a")[0]["href"]
  #    elsif link.css("img.social-icon").attribute("src").value == twitter_src
#        student[:twitter] << link.css("a")[0]["href"]
  #    elsif link.css("img.social-icon").attribute("src").value == github_src
  #3      student[:github] << link.css("a")[0]["href"]
#      elsif link.css("img.social-icon").attribute("src").value == youtube_src
  #      student[:youtube] << link.css("a")[0]["href"]
#      end
#    end

    #return the students hash
    student
  end

end
