# IT2011.CH181-PostgreSQL
IT2011.CH181-PostgreSQL


## Start-up: 
- Spin up `docker-compose`  
``` 
docker-compose up --build -d 
``` 

- Connect to PostgreSQl 
``` 
# enter container 
docker exec -ti it2011_ch181_postgres bash; 

# connect to it 
psql -U myuser -d mydatabase -h localhost -p 5432
```


## Details 
### Full-Backup: 
``` 
chmod +x ./scripts/full_backup.sh
./scripts/full_backup.sh
```





