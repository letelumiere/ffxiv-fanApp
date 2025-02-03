import {https} from 'firebase-functions';
import {initializeApp, storage} from 'firebase-admin';
import {Extract} from 'unzipper';
import {readdirSync} from 'fs';
import {join} from 'path';

initializeApp();
const bucket = storage().bucket('ffxiv-database-a42b0.appspot.com'); // 버킷 이름 설정

export const unzipFile = https.onRequest((req, res) => {
  const filePath = 'ffxiv-datamining.zip'; // 압축 파일 경로

  // Firebase Storage에서 파일 다운로드
  bucket.file(filePath).createReadStream()
    .pipe(Extract({ path: '/tmp/extracted' })) // 압축 해제
    .on('close', () => {
      const extractedData = readdirSync('/tmp/extracted');
      extractedData.forEach(file => {
        const localFilePath = join('/tmp/extracted', file);
        const storageFilePath = `extracted/${file}`; // Firebase Storage 내 경로 설정

        // 파일 업로드
        bucket.upload(localFilePath, {
          destination: storageFilePath,
          metadata: {
            // 원하는 메타데이터 설정 (예: Content-Type)
          }
        })
        .then(() => {
          console.log(`파일 ${file} 업로드 완료`);
        })
        .catch(err => {
          console.error(`파일 ${file} 업로드 오류:`, err);
        });
      });

      res.send('압축 해제 및 파일 업로드 완료!');
    })
    .on('error', (err) => {
      console.error('압축 해제 오류:', err);
      res.status(500).send('압축 해제 오류 발생');
    });
});
