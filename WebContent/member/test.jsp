
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <title>登入</title>
    <style type="text/css">
    #passwordHelp {
        padding-left: 2px;
    }

    #topicBar {
        border: 1px;
        border: solid;
        border-color: #7c7c7c;
        background-color: #7c7c7c;
        color: white;
        text-align: center;
        font-size: 20px;
        font-weight: bold;
    }

    .btn-primary {
        background-color: orange;
        border-color: orange;
    }
    #refreshconfirm {
        text-align: right;
        margin-bottom: 5px;
    }
    </style>
</head>

<body>
    <form method="post">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-4">
                    <label id="topicBar" class="col-12">SeakFoodTable 會員登入</label>
                    <div class="form-group">
                        <input type="text" name="account" class="form-control" placeholder="請輸入帳號" required>
                    </div>
                    <div class="form-group">
                        <input type="password" name="password" class="form-control" id="exampleInputPassword1" placeholder="請輸入密碼" required>
                        <small id="passwordHelp" class="form-text text-muted">英文字母需區分大小寫</small>
                    </div>
                    <div class="form-row">
                        <div class="col-8">
                            <input type="text" name="confirm" class="form-control" placeholder="請輸入右圖數字" required>
                        </div>
                        <div class="col">
                            <img src="dog.jpg" class="col-12">
                        </div>
                    </div>
                    <div>
                        <a href="#"><small id="refreshconfirm" class="form-text text-muted">重新產生</small></a>
                    </div>
                    <button type="submit" class="btn btn-primary col-12">登入 Login</button>
                </div>
            </div>
        </div>
        </div>
    </form>
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>

</html>