workspace "hhhh" {

    !identifiers hierarchical

    model {

        user = person "User" "Пользователь системы, который регистрируется, проходит опросник, получает рекомендации и оставляет отзывы."


        admin = person "Admin" "Администратор системы, который управляет данными и отвечает на отзывы пользователей."


        movieSystem = softwareSystem "Movie Recommendation System" "Система, которая управляет пользователями, рекомендациями, отзывами и взаимодействует с нейронной сетью." {

            authService = container "Authentication Service" "Сервис для регистрации и аутентификации пользователей и администраторов."
            questionnaireService = container "Questionnaire Service" "Сервис для обработки опросника пользователя и сохранения предпочтений."
            recommendationService = container "Recommendation Service" "Сервис для генерации рекомендаций фильмов на основе предпочтений пользователя."
            neuralNetwork = container "Neural Network" "Нейронная сеть, которая обрабатывает запросы пользователей и возвращает список подходящих фильмов."
            feedbackService = container "Feedback Service" "Сервис для обработки и хранения отзывов пользователей."
            database = container "Database" "База данных, которая хранит информацию о пользователях, администраторах, предпочтениях, отзывах и фильмах." {
                tags "Database"
            }
        }

        user -> movieSystem.authService "Регистрируется и входит в систему"
        user -> movieSystem.questionnaireService "Проходит опросник для выявления предпочтений"
        user -> movieSystem.recommendationService "Получает рекомендации фильмов"
        user -> movieSystem.neuralNetwork "Отправляет запрос с пожеланиями о фильме"
        user -> movieSystem.feedbackService "Оставляет отзыв"

        admin -> movieSystem.authService "Регистрируется и входит в систему"
        admin -> movieSystem.database "Имеет доступ ко всем данным"
        admin -> movieSystem.feedbackService "Отвечает на отзывы пользователей"

        movieSystem.authService -> movieSystem.database "Сохраняет данные о пользователях и администраторах"
        movieSystem.questionnaireService -> movieSystem.database "Сохраняет предпочтения пользователей"
        movieSystem.recommendationService -> movieSystem.database "Читает предпочтения пользователей"
        movieSystem.recommendationService -> movieSystem.neuralNetwork "Запрашивает рекомендации фильмов"
        movieSystem.feedbackService -> movieSystem.database "Сохраняет отзывы пользователей"
    }
}