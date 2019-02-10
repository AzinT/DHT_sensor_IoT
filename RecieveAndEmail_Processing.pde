//javamail libraries
import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
//processing serial library
import processing.serial.*;

void setup() {
  String ArduinoPort = Serial.list()[12];//PC port number
  Port = new Serial(this, ArduinoPort, 9600);
  noLoop();
}

//getting data from arduino constants
Serial Port;
String data; //data on arduino serial monitor
//email constants
String host = "smtp.gmail.com";
String from = "username"; //username
String[] to = { "ex@email.com" }; //recipients
String pass = "******";

void draw()
{
  if ( Port.available() > 0){ //if output of arduino not null 
    delay(3000); 
    data = Port.readStringUntil('\n');//read till the eol.
    //data = myPort.readString(); 
  } 
println(data); //print the data in console
//send email: 
//with the help of Daniel Shiffman Tutorial, http://www.shiffman.net  

Properties props = System.getProperties();
props.put("mail.smtp.host", host);
props.put("mail.smtp.user", from);
props.put("mail.smtp.password", pass);
props.put("mail.smtp.port", "587");
props.put("mail.smtp.auth", "true");
props.put("mail.smtp.socketFactory.port", "465");  
props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
Session session = Session.getInstance(props, null);
MimeMessage message = new MimeMessage(session);

try{
  message.setFrom(new InternetAddress(from));
  InternetAddress[] to_address = new InternetAddress[to.length];
  for( int i = 0; i < to.length; i++ ){
    to_address[i] = new InternetAddress(to[i]);
  }
  for( int i = 0; i < to_address.length; i++) {
    message.addRecipient(Message.RecipientType.TO, to_address[i]);
  }

  message.setSubject("Current Temp. and Hum.");
  message.setText(data);
  Transport transport = session.getTransport("smtp");
  transport.connect(null, from, pass);
  transport.sendMessage(message, message.getAllRecipients());
  transport.close();
  println("Sent!");
}
catch (AddressException ae){
  ae.printStackTrace();
}
catch (MessagingException me){
  me.printStackTrace();
}
}
