docker exec -it it2011_ch181_postgres psql -U myuser -d mydatabaseexport -c "SELECT * FROM pg_available_extensions WHERE name = 'pgaudit';"; 
docker exec -it it2011_ch181_postgres psql -U myuser -d mydatabaseexport -c "SHOW shared_preload_libraries;"; 
docker exec -it it2011_ch181_postgres psql -U myuser -d mydatabaseexport -c "SHOW pgaudit.log;"; 
