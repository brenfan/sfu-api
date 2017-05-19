import json
import requests
from datetime import date

#Module for handling queries to the SFU Course Outlines API.
#API URL: http://www.sfu.ca/bin/wcm/course-outlines

#fetches data
def get_outline(dept, num, sec, year = 'current', term = 'current'):
    #setup params
    params = "?{0}/{1}/{2}/{3}/{4}".format(year, term, dept, num, sec)
    #api request
    response = requests.get("http://www.sfu.ca/bin/wcm/course-outlines" + params)
    return response.json()

#fetches sections
def get_sections(dept, num, year = 'current', term = 'current'):
    #setup params
    params = "?{0}/{1}/{2}/{3}/".format(year, term, dept, num)
    #api request
    response = requests.get("http://www.sfu.ca/bin/wcm/course-outlines" + params)
    return response.json()
