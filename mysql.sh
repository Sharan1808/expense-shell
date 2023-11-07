log_file="/tmp/expense.log"
color="\e[33m"

echo -e "${color} Disable MySQL default version \e[0m"
dnf module disable mysql -y &>>$log_file
echo $?

echo -e "${color} Copy MySQL Repo File \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
echo $?

echo -e "${color} Install MySQL Server \e[0m"
dnf install mysql-community-server -y &>>$log_file
echo $?

echo -e "${color} Start MySQL Server \e[0m"
systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file
echo $?

echo -e "${color} Set MySQL Password \e[0m"
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$log_file
echo $?
