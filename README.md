SINATRA SERVICE(for candidates records application)
***
### How To Setup Locally

```bash
docker build . -t private_records
docker run -d -p 80:4567 --restart always --name private_records private_records
```
Open `localhost`

