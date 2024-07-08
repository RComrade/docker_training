# docker_training
В данном репозитории хранится результат тестового задания для позиции Junior DevOps специалист в Equip Group

Для запуска приложения необходимо убедиться, что используется сервер с ОС Linux (Тестировано на Ubuntu 22.04) 

## Необходимое ПО:
**git** - Можно установить с помощью команды `apt-get update && apt-get install git -y`  <br />
**docker** - Можно установить с помощью команды `curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh`  <br />
**docker-compose** - Можно установить с помощью команды `apt-get update && apt-get install docker-compose -y`  <br />

## Установка и запуск 
Скачиваем файлы из репозитория - `git clone https://github.com/RComrade/docker_training` <br />
Переходим в папку с проектом - `cd docker_training` <br />
Запускаем установочный скрипт - `bash app_install_w_replicaiton.sh` <br />

## Описание методов приложения
GET `/api/items` Обновляет список всех доступных задач <br />

Пример тела ответа:
```
[
    {
        "id": 1,
        "name": "\u0420\u0430\u0437\u0440\u0430\u0431\u043e\u0442\u0430\u0442\u044c Dockerfiles",
        "completed": true,
        "completed_at": "2024-07-08 22:16:21",
        "created_at": "2024-07-08T22:10:10.000000Z",
        "updated_at": "2024-07-08T22:16:21.000000Z"
    },
    {
        "id": 2,
        "name": "\u0420\u0430\u0437\u0440\u0430\u0431\u043e\u0442\u0430\u0442\u044c docker-compose",
        "completed": false,
        "completed_at": null,
        "created_at": "2024-07-08T22:10:10.000000Z",
        "updated_at": "2024-07-08T22:10:10.000000Z"
    },
    {
        "id": 3,
        "name": "\u041d\u0430\u0441\u0442\u0440\u043e\u0438\u0442\u044c \u0440\u0435\u043f\u043b\u0438\u043a\u0430\u0446\u0438\u044e",
        "completed": false,
        "completed_at": null,
        "created_at": "2024-07-08T22:10:10.000000Z",
        "updated_at": "2024-07-08T22:10:10.000000Z"
    },
    {
        "id": 4,
        "name": "\u0417\u0430\u043f\u0443\u0441\u0442\u0438\u0442\u044c php \u043f\u0440\u0438\u043b\u043e\u0436\u0435\u043d\u0438\u0435",
        "completed": false,
        "completed_at": null,
        "created_at": "2024-07-08T22:10:10.000000Z",
        "updated_at": "2024-07-08T22:10:10.000000Z"
    },
    {
        "id": 5,
        "name": "\u0421\u043e\u0441\u0442\u0430\u0432\u0438\u0442\u044c \u0438\u043d\u0441\u0442\u0440\u0443\u043a\u0446\u0438\u0438 \u043f\u043e \u0437\u0430\u043f\u0443\u0441\u043a\u0443",
        "completed": false,
        "completed_at": null,
        "created_at": "2024-07-08T22:10:10.000000Z",
        "updated_at": "2024-07-08T22:10:10.000000Z"
    },
    {
        "id": 6,
        "name": "\u0417\u0430\u043a\u043e\u043c\u043c\u0438\u0442\u0438\u0442\u044c \u0438\u0437\u043c\u0435\u043d\u0435\u043d\u0438\u044f",
        "completed": false,
        "completed_at": null,
        "created_at": "2024-07-08T22:10:10.000000Z",
        "updated_at": "2024-07-08T22:10:10.000000Z"
    },
    {
        "id": 7,
        "name": "\u041e\u0442\u043f\u0440\u0430\u0432\u0438\u0442\u044c \u0441\u0441\u044b\u043b\u043a\u0443 \u043d\u0430 \u0440\u0435\u043f\u043e\u0437\u0438\u0442\u043e\u0440\u0438\u0439",
        "completed": false,
        "completed_at": null,
        "created_at": "2024-07-08T22:10:10.000000Z",
        "updated_at": "2024-07-08T22:10:10.000000Z"
    }
]
```


PUT `/api/item/{id}` Обновляет задачу с заданным `{id}`
Пример запроса
```
completed :true
completed_at : "2024-07-08T22:16:21.711153Z"
created_at : "2024-07-08T22:10:10.000000Z"
id :1
name : "Разработать Dockerfiles"
updated_at : "2024-07-08T22:16:21.000000Z"
```
POST `/api/item/{id}` Создает задачу с заданным `{id}`  <br />
Пример запроса:  <br />
`item : {name: "New task"}`  <br />
Пример ответа:
```
{
    "name": "New task",
    "updated_at": "2024-07-08T22:35:21.000000Z",
    "created_at": "2024-07-08T22:35:21.000000Z",
    "id": 8
}
```
DELETE `/api/item/{id}` удаляет задачу с заданным `{id}`


В теле запроса\ответа методов `/api/items/` и `/api/item/{id}` находятся атрибуты: <br />
+ `id` - непосредственно `{id}` задачи <br />
+ `name` - передается строковое значение, отвечает за наименование задачи <br />
+ `created_at`  - передается время в формате Zulu, отвечает за дату создания задачи <br />
+ `updated_at` - передается время в формате Zulu, отвечает за время последнего изменения <br />
+ `completed` - true\false, отвечает за флаг завершенности задачи <br />
+ `completed_at` - передается время в формате Zulu, отвечает за время завершения задачи <br />

## Диаграмма приложения <br />
![Диаграмма взаимодействия компонентов]((https://github.com/RComrade/docker_training/blob/main/todoapp_diagramm.png))


## Вопросы <br />
Q: Почему для корректной работы приложению требуются права на запуск файлов? <br />
A: tbd

