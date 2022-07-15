from flask import Flask
import os

app = Flask(__name__)

@app.route('/')

#version_from_file = 'none'
#print("[ricc] Starting the super-duper vanilla server in python to say HelloWorld!\n")


def index():
  with open("VERSION", "r") as f:
    version_from_file = "".join(f.readlines())
  version = version_from_file # "1.1a"
  fav_color = os.environ.get('FAVORITE_COLOR')
  env_app_name = os.environ.get('APP_NAME')

  print("[ricc][web.py] INDEX: the super-duper vanilla server in python to say HelloWorld - v{}!\n".format(version))
  return """<h1>App01 (🐍) v<b>{ver}</b></h1>

        Hello world from Skaffold in python! This is a demonstrative app to demonstrate CI/CD with Cloud Deploy and Cloud Build<br/>

        I read version from file and this ./VERSION file is actually read by the build pipeline
        into the Cloud Deploy release name - wOOOt!<br/>

        FAVORITE_COLOR={fav_color}<br/>

        APP_NAME={env_app_name} <br/>
        RICCARDO_MESSAGE= TODO

        Favorite Color from v14: <b style='background-color:#{fav_color};' >#{fav_color}</b><br/>

        <hr/>
          <center>
            App01 (🐍) v<b>{ver}</b>
          </center>
  """.format(
    ver=version,
    fav_color=fav_color)
