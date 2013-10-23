module.exports =
    # 'env': 'production' || process.env.NODE_ENV || 'development'
    'env': process.env.NODE_ENV || 'development'
    'dbUri': 'mongodb://heroku:b2f675c713d836e95dad17fddca025a6@paulo.mongohq.com:10097/app18469829' || process.env.MONGOHQ_URL || 'mongodb://localhost/uwcV'
    #'dbUri': process.env.MONGOHQ_URL || 'mongodb://localhost/uwcV'
    'apiUrl': '/api'
