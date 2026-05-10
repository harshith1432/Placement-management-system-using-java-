package com.placement.utils;

import io.github.cdimascio.dotenv.Dotenv;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailService {
    private static final Dotenv dotenv = Dotenv.load();
    private static final String SMTP_EMAIL = dotenv.get("SMTP_EMAIL");
    private static final String SMTP_PASSWORD = dotenv.get("SMTP_PASSWORD");
    private static final String SMTP_HOST = dotenv.get("SMTP_HOST", "smtp.gmail.com");
    private static final String SMTP_PORT = dotenv.get("SMTP_PORT", "587");

    public static void sendOtpEmail(String toEmail, String otp, String role) {
        if (SMTP_EMAIL == null || SMTP_EMAIL.isEmpty() || SMTP_EMAIL.contains("your-gmail")) {
            System.out.println("==========================================");
            System.out.println("[DEV MODE] OTP for " + toEmail + " (" + role + "): " + otp);
            System.out.println("==========================================");
            return;
        }

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SMTP_EMAIL, SMTP_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SMTP_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Password Reset OTP - Placement Management System");

            String htmlContent = "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: auto; padding: 20px; border: 1px solid #e0e0e0; border-radius: 10px;'>" +
                    "<h2 style='color: #4F46E5; text-align: center;'>Placement Management System</h2>" +
                    "<p>Hello,</p>" +
                    "<p>You requested a password reset for your <strong>" + role + "</strong> account.</p>" +
                    "<div style='background: #f3f4f6; padding: 15px; text-align: center; border-radius: 8px; margin: 20px 0;'>" +
                    "<span style='font-size: 24px; font-weight: bold; letter-spacing: 5px; color: #1f2937;'>" + otp + "</span>" +
                    "</div>" +
                    "<p>This OTP is valid for <strong>5 minutes</strong>. If you did not request this, please ignore this email.</p>" +
                    "<hr style='border: 0; border-top: 1px solid #e0e0e0; margin: 20px 0;'>" +
                    "<p style='font-size: 12px; color: #6b7280; text-align: center;'>&copy; 2026 Placement Management System. All rights reserved.</p>" +
                    "</div>";

            message.setContent(htmlContent, "text/html");

            Transport.send(message);
            System.out.println("[EmailService] OTP sent successfully to " + toEmail);

        } catch (MessagingException e) {
            System.err.println("[EmailService] Error sending email: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
