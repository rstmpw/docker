import os
import logging.config
import uuid

from flask import Flask, render_template, request, make_response
from weasyprint import HTML
from weasyprint.text.fonts import FontConfiguration

font_config = FontConfiguration()
app_dir = os.path.dirname(os.path.realpath(__file__))
conf_dir = os.path.join(app_dir, 'conf')
res_dir = os.path.join(app_dir, 'resources')
css_dir = os.path.join(res_dir, 'css')

logging.config.fileConfig(conf_dir + "/log.conf")
logger = logging.getLogger("app")
app_flask = Flask(__name__)

@app_flask.route("/", methods=['POST', 'GET'])
def index():
    logger.info("--Program started INDEX--")

    for d, dirs, files in os.walk(css_dir):
        break

    html_tpl = {'options': dict.fromkeys(dirs), 'code': dirs[0]}
    logger.info("   Read list of directories")
    logger.info("--Done INDEX--")
    return render_template("index.html", **html_tpl)

@app_flask.route("/h2p/<code>", methods=['POST'])
def h2p(code):

    if not bool(request.files["fileselect"].filename):
        logger.info("File not found!!!")
        return "<p>File not found!!!</p>"

    fname = "%s.html" % uuid.uuid4()
    f = request.files['fileselect']
    bs_dir = os.path.join(css_dir, code)

    pdf = HTML(string=f, base_url=bs_dir).write_pdf(font_config=font_config, optimize_size=('fonts',))

    rsp = make_response(pdf)
    rsp.headers['Content-Type'] = 'application/pdf'
    rsp.headers['Content-Disposition'] = 'inline; filename=%s.pdf' % fname
    return rsp

if __name__ == "__main__":
    app_flask.run(host='0.0.0.0')