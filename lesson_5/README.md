Lesson 5 project structure: 

```
lesson-5/
│
├── main.tf                  # Головний файл для підключення модулів
├── backend.tf               # Налаштування бекенду для стейтів (S3 + DynamoDB)
├── outputs.tf               # Загальне виведення ресурсів
│
├── modules/                 # Каталог з усіма модулями
│   │
│   ├── s3-backend/          # Модуль для S3 та DynamoDB
│   │   ├── s3.tf            # Створення S3-бакета
│   │   ├── dynamodb.tf      # Створення DynamoDB
│   │   ├── variables.tf     # Змінні для S3
│   │   └── outputs.tf       # Виведення інформації про S3 та DynamoDB
│   │
│   ├── vpc/                 # Модуль для VPC
│   │   ├── vpc.tf           # Створення VPC, підмереж, Internet Gateway
│   │   ├── routes.tf        # Налаштування маршрутизації
│   │   ├── variables.tf     # Змінні для VPC
│   │   └── outputs.tf       # Виведення інформації про VPC
│   │
│   └── ecr/                 # Модуль для ECR
│       ├── ecr.tf           # Створення ECR репозиторію
│       ├── variables.tf     # Змінні для ECR
│       └── outputs.tf       # Виведення URL репозиторію ECR
│
└── README.md                # Документація проєкту
```



Command:

terraform init - ініціалізація тераформу

terraform plan - перелік планованих змін в інфраструктурі

terraform apply - застосувати зміни

terraform destroy - виделити усі зміни, які були уроблені скриптами тераформ




Modules:

s3-backend - Цей модуль потрібен для  зберігання стану (state) інфраструктури в AWS S3 замість локального файлу та блокування змін до кінця роботи процеса

vpc - створення приватних та публічних підмереж, шлюза та роутінг таблиця

ecr - репозиторій для контейнерів, які пізніше будуть використані для побудови інстансів
