PicPic
=========

Developer: Luming, Hao, Diwei

This is a demo APP.



# Django settings for data_dashboard project.
import os
import logging
from dateutil.relativedelta import relativedelta

DEBUG = True

TEMPLATE_DEBUG = DEBUG
PROJECT_ROOT = os.path.abspath(os.path.dirname(__file__))

# Public url for the site
SITE_URL = "http://localhost:8000/"

SITE_NAME = 'Data Dashboard'

IS_PROD = False

# URL prefix for static files.
# Example: "http://media.lawrence.com/static/"
STATIC_URL = '/static/'

INSTALLED_APPS = (
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.staticfiles',
    'test_framework',
    'ddapi',
    'vialogues',
    'research',
    'ssk',
    'nlt',
    'campaigns',
    'cas',
    'mschool',
    #'update',
    #'funnel',
    'accounts',
    'dashboard',
    'reports',
)

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        # this database is imported from real product data
        'NAME': 'dd_prod',
        'USER': 'root',
        'PASSWORD': '',
        # 'NAME': 'dd_dev',
        # 'USER': 'luming',
        # 'PASSWORD': '123',
        'HOST': '',
        'PORT': '3306',
    },
}

# Controls the length of time each search term stays active.
# Included here because it is used across several apps.
DATE_ADJUSTER = relativedelta(day=1, hour=0, minute=0, second=0, microsecond=0)
###########################################################################

IMPORTANT_FIELDS = {
    # Search fields to keep track of when logging search terms
    'pundit': ['q'],
    'research': ['q'],
    'dev-vialogues': ['q', 'tags', 'title', 'description'],
}

STOP_WORDS = [
    # Words to ignore when logging search query terms
    # List from http://www.ranks.nl/resources/stopwords.html
    "a", "about", "above", "after", "again", "against", "all", "am", "an",
    "and", "any", "are", "aren't", "as", "at", "be", "because", "been",
    "before", "being", "below", "between", "both", "but", "by", "can't",
    "cannot", "could", "couldn't", "did", "didn't", "do", "does", "doesn't",
    "doing", "don't", "down", "during", "each", "few", "for", "from",
    "further", "had", "hadn't", "has", "hasn't", "have", "haven't", "having",
    "he", "he'd", "he'll", "he's", "her", "here", "here's", "hers", "herself",
    "him", "himself", "his", "how", "how's", "i", "i'd", "i'll", "i'm",
    "i've", "if", "in", "into", "is", "isn't", "it", "it's", "its", "itself",
    "let's", "me", "more", "most", "mustn't", "my", "myself", "no", "nor",
    "not", "of", "off", "on", "once", "only", "or", "other", "ought", "our",
    "ours", "ourselves", "out", "over", "own", "same", "shan't", "she",
    "she'd", "she'll", "she's", "should", "shouldn't", "so", "some", "such",
    "than", "that", "that's", "the", "their", "theirs", "them", "themselves",
    "then", "there", "there's", "these", "they", "they'd", "they'll",
    "they're", "they've", "this", "those", "through", "to", "too", "under",
    "until", "up", "very", "was", "wasn't", "we", "we'd", "we'll", "we're",
    "we've", "were", "weren't", "what", "what's", "when", "when's", "where",
    "where's", "which", "while", "who", "who's", "whom", "why", "why's",
    "with", "won't", "would", "wouldn't", "you", "you'd", "you'll", "you're",
    "you've", "your", "yours", "yourself", "yourselves"
]

FIXTURE_DIRS = (
   os.path.join(PROJECT_ROOT, 'ddapi', 'fixtures'),
)

ADMINS = (
    # ('Your Name', 'your_email@example.com'),
)

MANAGERS = ADMINS


# Local time zone for this installation. Choices can be found here:
# http://en.wikipedia.org/wiki/List_of_tz_zones_by_name
# although not all choices may be available on all operating systems.
# On Unix systems, a value of None will cause Django to use the same
# timezone as the operating system.
# If running in a Windows environment this must be set to the same as your
# system time zone.
TIME_ZONE = 'UTC'

# Language code for this installation. All choices can be found here:
# http://www.i18nguy.com/unicode/language-identifiers.html
LANGUAGE_CODE = 'en-us'

SITE_ID = 1

# If you set this to False, Django will make some optimizations so as not
# to load the internationalization machinery.
USE_I18N = True

# If you set this to False, Django will not format dates, numbers and
# calendars according to the current locale
USE_L10N = True

# Absolute filesystem path to the directory that will hold user-uploaded files.
# Example: "/home/media/media.lawrence.com/media/"
MEDIA_ROOT = ''

# URL that handles the media served from MEDIA_ROOT. Make sure to use a
# trailing slash.
# Examples: "http://media.lawrence.com/media/", "http://example.com/media/"
MEDIA_URL = ''

# Absolute path to the directory static files should be collected to.
# Don't put anything in this directory yourself; store your static files
# in apps' "static/" subdirectories and in STATICFILES_DIRS.
# Example: "/home/media/media.lawrence.com/static/"
STATIC_ROOT = ''


SITE_STATIC_URL = STATIC_URL + 'lib/'
APPS_STATIC_URL = STATIC_URL + 'apps/'
SITE_DIR = '/dashboard'

# URL prefix for admin static files -- CSS, JavaScript and images.
# Make sure to use a trailing slash.
# Examples: "http://foo.com/static/admin/", "/static/admin/".
ADMIN_MEDIA_PREFIX = '/static/admin/'

# Additional locations of static files
STATICFILES_DIRS = (
    # Put strings here, like "/home/html/static" or "C:/www/django/static".
    # Always use forward slashes, even on Windows.
    # Don't forget to use absolute paths, not relative paths.
    # ('dashboard', os.path.join(PROJECT_ROOT, 'static')),
    os.path.join(PROJECT_ROOT, 'static'),
)

# List of finder classes that know how to find static files in
# various locations.
STATICFILES_FINDERS = (
    'django.contrib.staticfiles.finders.FileSystemFinder',
    'django.contrib.staticfiles.finders.AppDirectoriesFinder',
#    'django.contrib.staticfiles.finders.DefaultStorageFinder',
)

# Make this unique, and don't share it with anybody.
SECRET_KEY = 'am3p((s8)p*w=$b))+%_vr0*a(%$_rr^atk%=t0qwlf*1#-l#e'

API_KEYS = {
    'NLT': 'a0b1c1d2e3f5g8h13i21j34l55',
    "RB": "3CmkfVm0iX7iekxgM",
    'SSK': 'a0b1c1d2e3f5g8h13i21j34l55',
    'VIALOGUES': '1081b612f4732fb26614bcf864654bfa23edf565'
}

API_URLS = {
    'NLT' : 'https://newlearningtimes.com/reporting',
    'RB': 'https://researchbroker.tc.columbia.edu/reporting',
    'SSK': 'https://surveysidekick.com/reporting',
    # For now, the Vialogues reporting is based on the dev server rather than product server.
    'VIALOGUES': 'http://vlg-cloud.tc-library.org/reporting',
    # 'VIALOGUES': 'https://dev-vialogues.tc-library.org/reporting',
}

# List of callables that know how to import templates from various sources.
TEMPLATE_LOADERS = (
    'django.template.loaders.filesystem.Loader',
    'django.template.loaders.app_directories.Loader',
    #'django.template.loaders.eggs.Loader',
)

TEMPLATE_CONTEXT_PROCESSORS = (
    "django.contrib.auth.context_processors.auth",
    "django.core.context_processors.debug",
    #"django.core.context_processors.i18n",
    #"django.core.context_processors.media",
    "django.core.context_processors.request",
    "context_processors.dd_settings",
)

MIDDLEWARE_CLASSES = (
    #'debug_toolbar.middleware.DebugToolbarMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'accounts.middleware.CASMiddleware',
    'test_framework.RequestLoggingMiddleware.RequestLoggingMiddleware',
)

AUTHENTICATION_BACKENDS = (
    'django.contrib.auth.backends.ModelBackend',
    'accounts.backends.CASBackend',
)

ROOT_URLCONF = 'urls'

TEMPLATE_DIRS = (
    # Put strings here, like "/home/html/django_templates"
    # or "C:/www/django/templates".
    # Always use forward slashes, even on Windows.
    # Don't forget to use absolute paths, not relative paths.
    os.path.join(PROJECT_ROOT, 'static'),
    os.path.join(PROJECT_ROOT, 'accounts'),
    os.path.join(PROJECT_ROOT, 'templates')
)

if DEBUG:
    from logging_conf import DEBUG_LOGGING as LOGGING
else:
    from logging_conf import PRODUCTION_LOGGING as LOGGING

'''
DEBUG_TOOLBAR_PANELS = (
    'debug_toolbar.panels.version.VersionDebugPanel',
    'debug_toolbar.panels.timer.TimerDebugPanel',
    'debug_toolbar.panels.settings_vars.SettingsVarsDebugPanel',
    'debug_toolbar.panels.headers.HeaderDebugPanel',
    'debug_toolbar.panels.request_vars.RequestVarsDebugPanel',
    'debug_toolbar.panels.template.TemplateDebugPanel',
    'debug_toolbar.panels.sql.SQLDebugPanel',
    'debug_toolbar.panels.signals.SignalDebugPanel',
    'debug_toolbar.panels.logger.LoggingPanel',
)
'''

INTERNAL_IPS = (
    '127.0.0.1',
    '160.39.94.35',
    '160.39.74.86',
)

MAX_INPUT_FIELD_LENGTH = 100 # The maximum length of user input in the registration form
MIN_PASSWORD_LENGTH = 6 # The minimum allowed length of a user's password
CAS_SERVER_URL = 'https://dev-cas.tc-library.org/' # Production use 'https://edlabaccounts.tc-library.org/'
CAS_ADMIN_PREFIX = None
CAS_EXTRA_LOGIN_PARAMS = None
CAS_LOGOUT_COMPLETELY = True
CAS_IGNORE_REFERER = False
CAS_REDIRECT_URL = "/"
CAS_RETRY_LOGIN = False
RESET_PW_WINDOW = 30
PISTON_EMAIL_ERRORS = False
PISTON_DISPLAY_ERRORS = False


















# Migration script for 7/29/14

from django.db import connection
cursor = connection.cursor()

updated_edlab_name_list = ['abagigah92', 'AbdulMalik', 'abdulmalik2', 'Ananya', 'Abagigah92', 'afteredtv', 'agsharath',
                           'aimee', 'Allen.Foresta', 'ap3267', 'arielhan', 'Authorlaura', 'avichal', 'avichalbadaya',
                           'badaya', 'badaya\\', 'bdiarrassouba35', 'Beccachov', 'Bhughes', 'Bizapp', 'bob', 'bra2108',
                           'Brian.Sweeting', 'BridgetJane1', 'bugaboob', 'Carla', 'Carla busconi', 'carmen', 'carmenejames',
                           'cferrara', 'Cheerio', 'chingfu', 'ChloeChloe', 'Chloe Smith', 'ChloeSmith', 'ChrisGotthis',
                           'christophergu', 'cjimenez', 'Clark', 'Clark Larson', 'coach', 'costa.lales', 'danahaugh',
                           'dannyvergara18', 'ddiroy', 'delsibay', 'Dlales', 'dmgarbou', 'EdLabStudios', 'EdMod', 'EdwinH',
                           'elyseed', 'emilygann', 'fanwar', 'Francisco.Mendoza', 'Fredrossoff', 'g7status', 'garg',
                           'garg1', 'gargtc.edu', 'gnatriello', 'George', 'Gonzalo', 'gvc', 'hanshuguang', 'hapj2011',
                           'helmimouni', 'Henry', 'HSC', 'interlib', 'Jagnitti', 'janicesunjoo', 'jazcap53', 'Jennifer',
                           'JHeltz', 'jjolly', 'Jmanlapid', 'johnlee', 'JordaJean', 'Jorda Jean', 'Josh', 'jriinaferrie',
                           'jrs', 'JRS1', 'kafou', 'Katezvdp', 'Khalil', 'kingyoussef', 'kiraluo163', 'kkefgen', 'Ktudaniel',
                           'LauraCostello', 'Laurascheibe', 'laurascheiber', 'laurelangrist', 'leej744', 'Linchpin', 'lmalone',
                           'Lola', 'Luibrain7', 'Luming', 'mableyiu', 'mabelzhuang', 'mabel.zhuang’', 'Mafe', 'MariaSanchez',
                           'MartinPaper', 'Martin Paper', 'Maria Sanchez', 'manav', 'Mason', 'Meercat', 'Megha123', 'megha94in',
                           'melAIL8', 'micblee', 'milramyah', 'MrNantwi', 'mpowers', 'mxnkim', 'myz2102', 'Nantwi', 'Nara',
                           'natepr', 'nlt', 'Oumar', 'pramnab1', 'Pranav.garg', 'Pranav_garg', 'pranav12', 'pranavgarg007',
                           'rbkim', 'rebecca', 'RemytheCat', 'RemyV', 'Remy Vazquez', 'rendy', 'Rita', 'RitaBobita', 'Sakark',
                           'sally620', 'Sappho', 'sarpong18', 'scottk92', 'Sesackey', 'sha', 'sharon_hsiao', 'Skanda', 'soum',
                           'soumoumar', 'Steve Mandel', 'SteveMandel', 'TaylorJones', 'TCLibrary', 'Tcr', 'Test1', 'test3', 'test11',
                           'test12', 'test13', 'thanhnguyen', 'ting', 'test2', 'TheVoice', 'tzaffi', 'UFR', 'umcreate', 'usaedlab',
                           'user', 'uusa', 'vforvenn', 'vialogues', 'wang', 'welmer', 'Wjhoyle', 'wkp2102', 'xiehan', 'yangyang',
                           'yaotse', 'yiu.mable', 'ykehrlein', 'YogiP', 'YoungArtsMasterClass', 'Yudanlidev', 'Yudanli', 'yudanli2011',
                           'yudanli2012', 'yudanli2013', 'yudanli2014', 'yxzhang.cugmail.com', 'Zhou', 'zjjhfy', 'Zsa Zsa Vazquez',
                           'zz2111', 'zzhou']

query_session = "INSERT INTO edlab_users(username) VALUES (%s)"

cursor.execute(query_session, [updated_edlab_name_list])

