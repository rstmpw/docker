#
import os
import shutil
import tempfile
import uuid
from wsgiref.simple_server import make_server

from pyramid.config import Configurator
from pyramid.response import FileResponse
from weasyprint import HTML

# путь к каталогу с ресурсами
app_dir_path = os.path.dirname(os.path.realpath(__file__))
res_dir_path = os.path.join(app_dir_path, 'resources')
del app_dir_path


def html_to_pdf(request):
    # код набора CSS-стилей
    css_code = request.matchdict['code']

    # создать во временном каталоге каталог с актуальными CSS-файлами
    temp_dir_path = os.path.join(tempfile.gettempdir(), css_code)
    if not os.path.exists(temp_dir_path):
        os.mkdir(temp_dir_path)

    # скопировать CSS-файлы во временный каталог
    # наверное, это стоит делать только при старте сервера
    css_dir_path = os.path.join(res_dir_path, 'css', css_code)
    for item in os.listdir(css_dir_path):
        s = os.path.join(css_dir_path, item)
        d = os.path.join(temp_dir_path, item)
        shutil.copy2(s, d)

    #
    file_path = os.path.join(temp_dir_path, '%s.html' % uuid.uuid4())
    temp_file_path = file_path + '~'

    # сохранить файл из http-запроса во временный файл
    input_file = request.POST['html'].file
    input_file.seek(0)
    with open(temp_file_path, 'wb') as output_file:
        shutil.copyfileobj(input_file, output_file)

    # временный файл становится "постоянным"
    os.rename(temp_file_path, file_path)

    # HTML -> PDF
    HTML(filename=file_path).write_pdf(file_path + '.pdf')

    return FileResponse(file_path + '.pdf', request=request, content_type='application/pdf')


def index(request):
    # страница с простой формой для тестирования
    index_html_file_path = os.path.join(res_dir_path, 'index.html')
    return FileResponse(index_html_file_path, request=request, content_type='text/html', content_encoding='UTF-8')


def main():
    with Configurator() as config:
        config.add_route('index', '/')
        config.add_view(index, route_name='index')

        config.add_route('html_2_pdf', '/html2pdf/{code}')
        config.add_view(html_to_pdf, route_name='html_2_pdf')

        app = config.make_wsgi_app()

    server = make_server('0.0.0.0', 4652, app)  # 4652 = (50) 46 52 = (P)FR
    server.serve_forever()


if __name__ == '__main__':
    main()
