package com.multi.cookies.snack.api;
//
//import com.multi.cookies.snack.api.controller.DBApiController;
//import org.springframework.context.ApplicationContext;
//import org.springframework.context.annotation.AnnotationConfigApplicationContext;
//
//public class TestMain {
//
//    public static void main(String[] args) {
//        ApplicationContext context = new AnnotationConfigApplicationContext(TestConfig.class);
//
//        // DBApiController 빈을 가져와서 메소드 호출
//        DBApiController dbApiController = context.getBean(DBApiController.class);
//        try {
//            dbApiController.RefreshDB();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        ((AnnotationConfigApplicationContext) context).close();
//    }
//}