import json
import psycopg2
import requests
from bs4 import BeautifulSoup
from elasticsearch6 import Elasticsearch, RequestsHttpConnection
from datetime import datetime




with open("config.json") as file:
    data = json.load(file)
    conn = psycopg2.connect(
        "dbname={0} user={1} password={2} host={3}".format(data["db_name"], data["db_user"], data["db_pass"],
                                                           data["db_host"]))
    cur = conn.cursor()

    file = open("onions_list.txt")
    # set up elastic search connection

    elasticUsername = 'Master'
    elasticPassword = 'Master0987#'

    es = Elasticsearch(
        hosts=[{'host': "search-mutinex-scrapped-data-cgswde67mvhm3nt6y4x4x5ojki.ap-southeast-2.es.amazonaws.com",
                'port': 443}],
        http_auth=(elasticUsername, elasticPassword),
        use_ssl=True,
        verify_certs=True,
        connection_class=RequestsHttpConnection
    )
    print(es.info())


    count = 1
    lines = file.readlines()
    for line in lines:
        proxies = {
            "http": "http://127.0.0.1:3129",
        }

        r = requests.get("https://cryptome.org/", proxies=proxies)

        print("URL:{0} Status {1}".format(line, r.status_code))
        sql = """INSERT INTO onion_scrape(text_data)
                     VALUES(%s) RETURNING scrape_id;"""
        cur.execute(sql, (r.text,))
        print("URL {0} Scraped".format(line))

        soup = BeautifulSoup(r.text)

        data = {"site": line, "html": soup.get_text(), 'timestamp': datetime.now()}

        res = es.index(index="onion-index-new", doc_type='html_scrape', id=count, body=data)
        print(res['result'])
        count = count + 1

    conn.commit()
    cur.close()
    conn.close()






