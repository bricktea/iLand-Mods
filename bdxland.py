import leveldb

db=leveldb.LevelDB('./input-data/bdxland')
for key, value in db.RangeIter():
    a=key.decode('unicode_escape')
    b=value.decode('unicode_escape')
    print(key,value)
    print (a,b)