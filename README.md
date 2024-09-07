# COP_FRIENDLY-APP
#Its just a simple app made with flutter 
#flutter
step-1 
  >>> install the required packages that includes(Flutter ,dart ,Vs_code or Android studio)
step-2  
  >>> In terminal run ("flutter pub get")
step-3
  >>>  After installation go to lib folder in that (HomeScreen.dart) change the :
                var userEmail = 'YOUR_MAIL_ADDRESS';(in line 87)
                ..recipients.add('reciver_mail'); (in line 90)
                **get your APP PASSWORD KEY FOR YOUR_MAIL_ADDRESS
                final smtpServer = gmail(userEmail, 'PAST_THE_APPPASSWORD_KEY'); ( in line 96)
Step-4
  >>> Same as in (complintscreen.dart [in line 30,44] ,acc_comp_screen.dart [in line 34,48])
Step-5
  >>> Now your project is ready you may able to run this app
## if not ##
  >>> run in terminal ('flutter clean') and then ('flutter build')
  now run ('flutter pub get')


NOTE:
  !!--firebase authentication has been not used 
  email and pass for user_login:
        >>test@gmail.com(email)
        >>Admin@123(pass)
  email and pass for Admin_login:
        >>admin@gmail.com(email)
        >>Admin@123(pass)