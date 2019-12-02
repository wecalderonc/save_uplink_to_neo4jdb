#!bin/bash
echo "Borrando zip"
sudo rm lambda_function.zip
# echo "Borrando Vendor"
# sudo rm -r vendor
# echo "Corriendo docker"
# docker run -it --rm -v "$PWD":/var/task lambci/lambda:build-ruby2.5 bundle install --without test development --path vendor/bundle
# echo "Borrando cache de vendor"
# sudo rm -r vendor/bundle/ruby/2.5.0/cache
echo "Comprimiendo"
zip -9 -r lambda_function.zip lambda_function.rb vendor app config lib
echo "Subiendo a Lambda"
aws lambda update-function-code --function-name  arn:aws:lambda:us-east-1:247246293844:function:SaveToNeo4jDB --zip-file fileb://lambda_function.zip
