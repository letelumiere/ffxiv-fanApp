import csv
import json

# CSV 데이터를 읽고 JSON으로 변환하는 함수
def csv_to_json(csv_file_path, json_file_path):
    data = []
    with open(csv_file_path, encoding='utf-8') as csvfile:
        reader = csv.reader(csvfile)
        for row in reader:
            if row[0].isdigit():  # 숫자인 경우만 변환
                item = {
                    "key": int(row[0]),  # int 형 변환
                    "xivString": str(row[1]),  # str 형 변환
                    "icon": str(row[2]),  # str 형 변환
                    "order{Minor}": int(row[3]),  # byte (int로 변환)
                    "order{Major}": int(row[4])  # byte (int로 변환)
                }
                data.append(item)

    # JSON 파일로 저장
    with open(json_file_path, 'w', encoding='utf-8') as jsonfile:
        json.dump(data, jsonfile, ensure_ascii=False, indent=4)

# CSV 파일 경로와 변환 후 저장할 JSON 파일 경로
csv_file_path = 'C:/Users/jhk88/Desktop/ffxiv-db/ItemUICategory.csv';
json_file_path = 'C:/Users/jhk88/Desktop/ffxiv-db/ItemUICategory.json';

# 변환 함수 실행
csv_to_json(csv_file_path, json_file_path)
