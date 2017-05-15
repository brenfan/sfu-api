require 'json'
require 'htmlentities'
require 'open-uri'
require 'sanitize'

module Roads
=begin
    Module for reading from the SFU Road Conditions API
    Returns pretty formatted plaintext strings for whatever use.
    API URL: http://www.sfu.ca/security/sfuroadconditions/api/2/current
=end

  def Roads.get
    #opens the API url and returns parsed JSON
    response = open "roads.json"
    #puts response.status
    doc = ""
    response.each do |line|
      doc << line
    end
    response.close
    #parse it
    JSON.parse(doc)
  end

  def Roads.announcements
    #fetch data
    data = Roads.get
    str = data['announcements'][0]

    #sanitize and prep as plaintext
    Sanitize.clean HTMLEntities.new.decode str
  end

  def Roads.conditions(campus="burnaby")
    #fetch data
    data = Roads.get
    #begin building return string
    doc = "#{campus.capitalize} road conditions\n"
    begin
      data['conditions'][campus].each do |property|
        doc << "#{property[0].capitalize}: #{property[1]}"
        doc << "\n"
      end

    rescue NoMethodError
      #error handling here
      return
    end
    #a bit of regex magic and gsub
    doc.gsub(/"|{|}/, "").gsub(/_/, " and ")
  end
end
