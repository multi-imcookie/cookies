package com.multi.cookies.member.service;

import org.jasypt.util.text.BasicTextEncryptor;
import org.springframework.stereotype.Service;

@Service
public class JasyptEncoderService {
        public String encrypt(String plainText) {
            BasicTextEncryptor textEncryptor = new BasicTextEncryptor();
            textEncryptor.setPassword("local");
            String encodeText = textEncryptor.encrypt(plainText);
            return encodeText;
        }
        public String decrypt(String encrypt) {
            BasicTextEncryptor textEncryptor = new BasicTextEncryptor();
            textEncryptor.setPassword("local");
            String plaintText = textEncryptor.decrypt(encrypt);
            return plaintText;
        }
}