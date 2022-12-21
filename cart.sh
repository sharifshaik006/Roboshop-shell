set -e

echo setting NOdeJs repos
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash &>>/tmp/cart.log

echo installing NodeJs
yum install nodejs -y  &>>/tmp/cart.log


echo Adding Application user
useradd roboshop  &>>/tmp/cart.log

echo Downloading application content

curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip"  &>>/tmp/cart.log
cd /home/roboshop  &>>/tmp/cart.log

echo cleaning application content
rm -rf cart  &>>/tmp/cart.log

echo extract Application Archive
unzip -o /tmp/cart.zip  &>>/tmp/cart.log
mv cart-main cart  &>>/tmp/cart.log
cd cart  &>>/tmp/cart.log

echo installing NodeJs Dependencies
npm install  &>>/tmp/cart.log

echo configuring SystemD service
mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service  &>>/tmp/cart.log
systemctl daemon-reload  &>>/tmp/cart.log

echo starting cart service
systemctl start cart  &>>/tmp/cart.log
systemctl enable cart  &>>/tmp/cart.log