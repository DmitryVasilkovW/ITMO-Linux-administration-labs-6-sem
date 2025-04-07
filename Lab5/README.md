# Лабораторная работа №5
**Управление ресурсами и изоляция с помощью cgroups, namespaces. Контейнеры**

# 1) Квоты на процессор для конкретного пользователя

````shell
sudo useradd -m user-67
````

````shell
sudo systemctl set-property user-$(id -u user-67).slice CPUQuota=50%
````

# 2) Ограничение памяти для процесса

````shell
sudo mkdir /sys/fs/cgroup/memory_test
echo "1170M" | sudo tee /sys/fs/cgroup/memory_test/memory.max >/dev/null

(echo $$ | sudo tee /sys/fs/cgroup/memory_test/cgroup.procs && tail /dev/zero) &
````

**Поскольку я использую ``fish``, последняя команда у меня выглядит так:**

````fish
set pid (echo %self); echo $pid | sudo tee /sys/fs/cgroup/memory_test/cgroup.procs; tail /dev/zero &
````

# 3) Ограничение дискового ввода-вывода для сценария резервного копирования

**backup.sh**
````shell
#!/bin/bash

dd if=/dev/zero of=/tmp/backup_test bs=1M count=1000 status=progress
````

```shell
chmod +x backup.sh
```

````shell
nice -n 19 ionice -c 2 -n 7 ./backup.sh
````

# 4) Закрепление к определенному ядру процессора для приложения

````shell
CPU_SET_PATH=$(mount | grep cpuset | awk '{print $3}')

sudo mkdir "$CPU_SET_PATH/cpu0"

echo 0 | sudo tee "$CPU_SET_PATH/cpu0/cpuset.cpus"
echo 0 | sudo tee "$CPU_SET_PATH/cpu0/cpuset.mems"

cat "$CPU_SET_PATH/cpu0/cpuset.cpus"
cat "$CPU_SET_PATH/cpu0/cpuset.mems"
````

````fish
set CPU_SET_PATH $(mount | grep cpuset | awk '{print $3}')

sudo mkdir "$CPU_SET_PATH/cpu0"

echo 0 | sudo tee "$CPU_SET_PATH/cpu0/cpuset.cpus"
echo 0 | sudo tee "$CPU_SET_PATH/cpu0/cpuset.mems"

cat "$CPU_SET_PATH/cpu0/cpuset.cpus"
cat "$CPU_SET_PATH/cpu0/cpuset.mems"
````

**Проверка**

````shell
top & PID=$!
echo $PID | sudo tee "$CPU_SET_PATH/cpu0/tasks" >/dev/null
taskset -p $PID
````

````fish
top & set PID $last_pid
echo $PID | sudo tee "$CPU_SET_PATH/cpu0/tasks" >/dev/null
taskset -p $PID
````

# 5) Динамическая корректировка ресурсов

**cpu_auto_control.sh**
````shell
#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <PID>"
    exit 1
fi

CG_DIR="/sys/fs/cgroup/cpu_auto"
sudo mkdir -p "$CG_DIR"

if ps -p "$1" > /dev/null; then
    echo "$1" | sudo tee "$CG_DIR/cgroup.procs" >/dev/null || {
        echo "Failed to add process to cgroup. Trying alternative method..."
        echo "$1" | sudo tee "/sys/fs/cgroup$(cat /proc/$1/cgroup | head -1 | cut -d: -f3)/cgroup.procs" >/dev/null
    }
else
    echo "Process $1 does not exist"
    exit 1
fi

while true; do
    USAGE=$(mpstat 1 1 | awk '/Average:/ {printf "%.0f", 100 - $NF}')

    if ! [[ "$USAGE" =~ ^[0-9]+$ ]]; then
        echo "Error getting CPU usage"
        sleep 5
        continue
    fi

    if [ "$USAGE" -lt 20 ]; then
        echo "80000 100000" | sudo tee "$CG_DIR/cpu.max" >/dev/null
        echo "Low load (<20%): Set CPU quota to 80%"
    elif [ "$USAGE" -gt 60 ]; then
        echo "30000 100000" | sudo tee "$CG_DIR/cpu.max" >/dev/null
        echo "High load (>60%): Set CPU quota to 30%"
    else
        echo "Normal load ($USAGE%): Keeping current CPU quota"
    fi

    sleep 5
done
````

# 6) Создание изолированного имени хоста (пространство имен UTS)

```shell
sudo unshare -u bash
hostname isolated-student-67
```

**Проверка**

```shell
hostname
```

# 7) Изоляция процессов (пространство имен PID)

```shell
sudo unshare --pid --fork bash
mount -t proc proc /proc

ps aux
```
# 8) Изолированная файловая система (пространство имен Mount)

```shell
sudo unshare --mount bash
mkdir /tmp/private_$(whoami)
mount -t tmpfs tmpfs /tmp/private_$(whoami)
```

**Проверка с другого терминала**
```shell
ls -ld /tmp/private_*
```

# 9) Отключение доступа к сети (пространство имен Network)

```shell
unshare -n bash
ip addr
ping google.com
```

# 10) Создайте и проанализируйте монтирование OverlayFS

```shell
mkdir -p ~/overlay_/{lower,upper,work,merged}

echo "Оригинальный текст из LOWER" > ~/overlay_/lower/67_original.txt

sudo mount -t overlay overlay \
  -o lowerdir=/home/debian/overlay_/lower,\
upperdir=/home/debian/overlay_/upper,\
workdir=/home/debian/overlay_/work \
  /home/debian/overlay_/merged

ls ~/overlay_/merged
```

**b**
```shell
rm ~/overlay_/merged/67_original.txt
ls -la ~/overlay_/upper
echo "Восстановленный текст" > ~/overlay_/merged/67_original.txt
cat ~/overlay_/merged/67_original.txt
```

**c**
```shell
#!/bin/bash

LOWER_DIR="/home/debian/overlay_/lower"
UPPER_DIR="/home/debian/overlay_/upper"
MERGED_DIR="/home/debian/overlay_/merged"
LOG_FILE="67_audit.log"

echo "=== Whiteout files in upper ===" > $LOG_FILE
find "$UPPER_DIR" -name '.wh.*' >> $LOG_FILE

echo -e "\n=== Difference between lower and merged ===" >> $LOG_FILE
diff -rq "$LOWER_DIR" "$MERGED_DIR" >> $LOG_FILE 2>&1

echo -e "\n=== Whiteout contents ===" >> $LOG_FILE
for file in $(find "$UPPER_DIR" -name '.wh.*'); do
  echo "File: $file" >> $LOG_FILE
  echo "Size: $(stat -c %s "$file") byte" >> $LOG_FILE
done

echo "Finished audit. Results available in $LOG_FILE"

chmod +x 67_audit.sh
./67_audit.sh
```

**d**
## Вопросы и ответы

### 1. Как OverlayFS скрывает файлы из нижнего слоя при удалении в объединенном?

OverlayFS использует механизм "copy-up", чтобы скрыть файлы в нижнем слое при удалении. Когда файл из нижнего слоя удаляется в объединённой файловой системе (например, при записи в верхний слой), фактически не происходит его удаление, а создаётся новый пустой файл в верхнем слое. Это позволяет скрывать файл в нижнем слое, но на самом деле он всё ещё присутствует там. Таким образом, пользователь не видит его, так как OverlayFS отображает пустое место в верхнем слое.

### 2. Если вы удалите рабочий каталог work, сможете ли вы перемонтировать оверлей? Объясните, почему.

Если удалить рабочий каталог `work`, мы не сможем перемонтировать OverlayFS без его воссоздания. Это связано с тем, что каталог `work` необходим для функционирования OverlayFS. Он используется для временных файлов и данных во время операций монтирования. Если этот каталог удалить, OverlayFS не будет иметь подходящего места для выполнения операций, таких как копирование файлов или запись изменений, и система не сможет корректно монтировать оверлей.

### 3. Что произойдет с объединённым слоем, если верхний каталог будет пуст?

Если верхний каталог в OverlayFS окажется пустым, объединённый слой будет отображать только содержимое нижнего слоя. Поскольку OverlayFS использует верхний слой для изменений, при его отсутствии все изменения будут отображаться как если бы они были сделаны непосредственно в нижнем слое. Таким образом, в объединённой файловой системе будут видны только файлы и каталоги, присутствующие в нижнем слое.

# 11) Оптимизируйте Dockerfile для приведенного ниже приложения app.py

```dockerfile
FROM python:3.9-slim

RUN useradd -m appuser && mkdir /app && chown appuser:appuser /app
WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .
USER appuser

ENV STUDENT_NAME="Vasilkov Dmitry"
EXPOSE 5000
CMD ["python", "app.py"]
```

```dockerignore
__pycache__
*.pyc
*.pyo
*.pyd
*.db
*.sqlite
*.log
.env
*.git
*.gitignore
Dockerfile
.dockerignore
tests/
```

# 12) Установка платформы публикации WordPress с помощью Docker Compose

```yml
version: '3.8'

services:
  db:
    image: mariadb:10.6
    volumes:
      - dmitry-wp-data:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: dmitry_db_pass
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: wordpress

  wordpress:
    image: wordpress:6.0
    ports:
      - "2067:80"
    volumes:
      - ./wp-content:/var/www/html/wp-content
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: wordpress

volumes:
  dmitry-wp-data:
```
