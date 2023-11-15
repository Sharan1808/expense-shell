source common.sh

if [ -z "$1" ]; then
  echo Password is Missing
  exit
fi

MYSQL_ROOT_PASSWORD=$1

echo -e "${color} Disable MySQL default version \e[0m"
dnf module disable mysql -y &>>$log_file
status_check

echo -e "${color} Copy MySQL Repo File \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
status_check

echo -e "${color} Install MySQL Server \e[0m"
dnf install mysql-community-server -y &>>$log_file
status_check

echo -e "${color} Start MySQL Server \e[0m"
systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file
status_check

echo -e "${color} Set MySQL Password \e[0m"
mysql_secure_installation --set-root-pass ${MYSQL_ROOT_PASSWORD } &>>$log_file
status_check
