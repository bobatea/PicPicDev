PicPic
=========

Developer: Luming, Hao, Diwei

This is a demo APP.




















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

