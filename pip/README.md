Uses nogil/manylinux2014_x86_64 image.
To rebuild image clone colesbury/manylinux -b nogil
And run:

```
PLATFORM=$(uname -m) POLICY=manylinux2014 COMMIT_SHA=latest ./build.sh
```
