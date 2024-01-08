//package com.thewebaddicts.capef;
//import android.graphics.Bitmap;
//import android.graphics.BitmapFactory;
//import android.graphics.Canvas;
//import android.graphics.Color;
//import android.graphics.Matrix;
//import android.graphics.Paint;
//import androidx.annotation.NonNull;
//
//import com.google.zxing.BarcodeFormat;
//import com.google.zxing.WriterException;
//import com.mobiiot.androidqapi.api.CsPrinter;
//import com.mobiiot.androidqapi.api.MobiiotAPI;
//
//import java.math.BigInteger;
//
//import io.flutter.embedding.android.FlutterActivity;
//import io.flutter.embedding.engine.FlutterEngine;
//import io.flutter.plugin.common.MethodChannel;
//
//
//public class MainActivity extends FlutterActivity {
//
//    private static final String CHANNEL = "my_java_linker";
//
//    @Override
//    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
//        super.configureFlutterEngine(flutterEngine);
//        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
//                .setMethodCallHandler(
//                        (call, result) -> {
//                            if(call.method.equals("myJavaFunc")){
//                                System.out.println("FETT 3ala myJavaFunction");
//
//                                int returnedValue=  mp3Print(call.argument("data")
//                                        );
//                                if(returnedValue<0){
//
//
//                                    result.success("printing done good");
//                                }else{
//                                    result.error("unavailable","somthing went wrong",null);
//                                }
//                            }else{
//                                result.notImplemented();
//                            }
//
//
//                        }
//                );
//    }
//
//
//    @Override
//    protected void onResume() {
//        super.onResume();
//
//        //initialize mp3 printer
//        new MobiiotAPI(this);
//    }
//
//
//
//    private int mp3Print(byte[] data
////            ,
////                         BigInteger offlineId, String title, String answer, String agentName, String inscription, String cotisation
//    ) {
//
//        int result = 0;
//
//        System.out.println("before csprinter");
//
////        printBarCode();
//
//
//        CsPrinter.printText_FullParam("Ressortissant enregistré avec succès",
//4,
//                1,
//                1,
//                1,
//                true,false
//                );
//
//
//
//
//
//        System.out.println("after csprinter");
//
//
//        try {
//            if (data != null) {
//
//                Bitmap mBitmap = BitmapFactory.decodeByteArray(data, 0, data.length);
//
//                int mwidth = mBitmap.getWidth();
//
//                int deffInWidth = 384 - mwidth;
//
//
//
//                printBitmap(
//                        getResizedBitmap(mBitmap, 140, 140),
//                        Bitmap.Config.ARGB_8888
//                );
//
//                result = -1;
//            }
//
//        }catch (Exception ex){
//            System.out.println("mobiiot EXCEPTION ERROR" + ex);
//            result = 0;
//
//        }
//
//
////        CsPrinter.printText_FullParam("ID: " + offlineId,
////                4,
////                1,
////                1,
////                1,
////                true,false
////        );
////
////        CsPrinter.printText_FullParam(title,
////                3,
////                1,
////                1,
////                1,
////                false,false
////                );
////        CsPrinter.printText_FullParam(answer,
////                4,
////                1,
////                1,
////                1,
////                false,false
////        );
////
////        CsPrinter.printText_FullParam("Nom de l'agent",
////                3,
////                1,
////                1,
////                1,
////                false,false
////        );
////        CsPrinter.printText_FullParam(agentName,
////                4,
////                1,
////                1,
////                1,
////                false,false
////        );
////
////        CsPrinter.printText_FullParam("INSCRIPTION PAYÉE",
////                3,
////                1,
////                1,
////                1,
////                false,false
////        );
////        CsPrinter.printText_FullParam(inscription,
////                4,
////                1,
////                1,
////                1,
////                false,false
////        );
////
////        CsPrinter.printText_FullParam("COTISATION PAYÉE",
////                3,
////                1,
////                1,
////                1,
////                false,false
////        );
////        CsPrinter.printText_FullParam(cotisation,
////                4,
////                1,
////                1,
////                1,
////                false,false
////        );
//
//
//
//
//
//        return result;
//
//    }
//
//
//
//    public static Bitmap convert(Bitmap bitmap, Bitmap.Config config) {
//        System.out.println("FETT 3al CONVERT");
//        Bitmap convertedBitmap = Bitmap.createBitmap(bitmap.getWidth(), bitmap.getHeight(), config);
//        Canvas canvas          = new Canvas(convertedBitmap);
//        Paint paint           = new Paint();
//        paint.setColor(Color.BLACK);
//        canvas.drawBitmap(bitmap, 0, 0, paint);
//        return convertedBitmap;
//    }
//
//    public void printBitmap(Bitmap bitmap,Bitmap.Config config){
//        System.out.println("ENTERED printBitmap");
//        Bitmap bit=convert(bitmap,config);
////        CsPrinter.printText("-----------------------------");
////        CsPrinter.printText("width   = "+bit.getWidth());
////        CsPrinter.printText("width/8 = "+(float)bit.getWidth()/8);
////        CsPrinter.printText("bit     = "+bit.getConfig());
//        CsPrinter.printBitmap(bit);
//    }
//
//    public Bitmap getResizedBitmap(Bitmap bm, int newWidth, int newHeight) {
//        System.out.println("FETT 3ala RESIZE BITMAP");
//        int width = bm.getWidth();
//        int height = bm.getHeight();
//        float scaleWidth = ((float) newWidth) / width;
//        float scaleHeight = ((float) newHeight) / height;
//        // CREATE A MATRIX FOR THE MANIPULATION
//        Matrix matrix = new Matrix();
//        // RESIZE THE BIT MAP
//        matrix.postScale(scaleWidth, scaleHeight);
//
//        // "RECREATE" THE NEW BITMAP
//        Bitmap resizedBitmap = Bitmap.createBitmap(
//                bm, 0, 0, width, height, matrix, false);
//        bm.recycle();
//        return resizedBitmap;
//    }
//
//
//
//    public void printBarCode() {
//        try {
//            System.out.println("FETT 3ala create qr code function");
//            CsPrinter.createBarQrCode("654", BarcodeFormat.QR_CODE,16,16);
//        } catch (WriterException e) {
//            System.out.println("ERROR TRACK IS" + e.getMessage());
//            e.printStackTrace();
//        }
//    }
//
//
//
//}

package com.thewebaddicts.capef;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Matrix;
import android.graphics.Paint;
import android.os.Bundle;
import android.os.PersistableBundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.mobiiot.androidqapi.api.CsPrinter;
import com.mobiiot.androidqapi.api.MobiiotAPI;
import com.mobiiot.androidqapi.api.Utils.BitmapUtils;
import com.mobiiot.androidqapi.api.Utils.PrinterServiceUtil;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;


public class MainActivity extends FlutterActivity {

    private static final String CHANNEL = "my_java_linker";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if(call.method.equals("myJavaFunc")){
                                int returnedValue=  mp3Print(call.argument("data"),
                                        call.argument("date_time"),
                                        call.argument("type"),
                                        call.argument("national_name"),
                                        call.argument("identification_id"),
                                        call.argument("national_phone_number"),
                                        call.argument("region_department"),
                                        call.argument("agent_name"),
                                        call.argument("assistance_phone"));
                                if(returnedValue<0){
                                    result.success("printing done good");
                                }else{
                                    result.error("unavailable","somthing went wrong",null);
                                }
                            }else{
                                result.notImplemented();
                            }


                        }
                );
    }


    @Override
    protected void onResume() {
        super.onResume();

        //initialize mp3 printer
        new MobiiotAPI(this);
    }





    private int mp3Print(byte[] data,
                         String dateTime,
                         String type,
                         String nationalName,
                         String identificationId,
                         String nationalPhone,
                         String regionAndDepartment,
                         String agentName,
                         String assistanceNumber
                         ) {
        int result = 0;
        System.out.println("before csprinter");

        CsPrinter.printText_FullParam("CAPEF", 3, 3, 1, 1, false, false);
        CsPrinter.printText_FullParam(dateTime, 1, 3, 1, 1, false, false);
        CsPrinter.printText_FullParam("Carte", 2, 3, 1, 1, false, false);
        CsPrinter.printText_FullParam(type, 2, 3, 1, 1, false, false);
        CsPrinter.printText_FullParam(nationalName, 2, 3, 1, 1, false, false);
        CsPrinter.printText_FullParam(identificationId, 2, 3, 1, 1, false, false);
        CsPrinter.printText_FullParam(nationalPhone, 2, 3, 1, 1, false, false);


        System.out.println("after csprinter");


        try {
            if (data != null) {

                Bitmap mBitmap = BitmapFactory.decodeByteArray(data, 0, data.length);

                int mwidth = mBitmap.getWidth();

                int deffInWidth = 384 - mwidth;

                System.out.println(mBitmap.getWidth() + deffInWidth);
                System.out.println(mBitmap.getHeight() + deffInWidth);

                printBitmap(
                        getResizedBitmap(mBitmap, mBitmap.getWidth() + deffInWidth, mBitmap.getHeight() + deffInWidth),
                        Bitmap.Config.ARGB_8888
                );

                CsPrinter.printText_FullParam(regionAndDepartment, 1, 3, 1, 1, false, false);
                CsPrinter.printText_FullParam(agentName, 1, 3, 1, 1, false, false);
                CsPrinter.printText_FullParam("Pour assistance, veuillez contacter le", 1, 3, 1, 1, false, false);
                CsPrinter.printText_FullParam(assistanceNumber, 1, 3, 1, 1, false, false);
                CsPrinter.printText_FullParam("", 3, 3, 1, 1, false, false);
                CsPrinter.printText_FullParam("", 3, 3, 1, 1, false, false);
                CsPrinter.printText_FullParam("", 3, 3, 1, 1, false, false);
                CsPrinter.printText_FullParam("", 3, 3, 1, 1, false, false);
                CsPrinter.printText_FullParam("", 3, 3, 1, 1, false, false);
                CsPrinter.printText_FullParam("", 3, 3, 1, 1, false, false);
                CsPrinter.printText_FullParam("", 3, 3, 1, 1, false, false);
                CsPrinter.printText_FullParam("", 3, 3, 1, 1, false, false);
                CsPrinter.printText_FullParam("", 3, 3, 1, 1, false, false);


                result = -1;
            }

        } catch (Exception ex) {
            System.out.println("something wrong on mobiiot");
            result = 0;

        }

        return result;

    }



    public static Bitmap convert(Bitmap bitmap, Bitmap.Config config) {
        Bitmap convertedBitmap = Bitmap.createBitmap(bitmap.getWidth(), bitmap.getHeight(), config);
        Canvas canvas          = new Canvas(convertedBitmap);
        Paint paint           = new Paint();
        paint.setColor(Color.BLACK);
        canvas.drawBitmap(bitmap, 0, 0, paint);
        return convertedBitmap;
    }

    public void printBitmap(Bitmap bitmap,Bitmap.Config config){
        Bitmap bit=convert(bitmap,config);
//        CsPrinter.printText("-----------------------------");
//        CsPrinter.printText("width   = "+bit.getWidth());
//        CsPrinter.printText("width/8 = "+(float)bit.getWidth()/8);
//        CsPrinter.printText("bit     = "+bit.getConfig());
        CsPrinter.printBitmap(bit);
    }

    public Bitmap getResizedBitmap(Bitmap bm, int newWidth, int newHeight) {
        int width = bm.getWidth();
        int height = bm.getHeight();
        float scaleWidth = ((float) newWidth) / width;
        float scaleHeight = ((float) newHeight) / height;
        // CREATE A MATRIX FOR THE MANIPULATION
        Matrix matrix = new Matrix();
        // RESIZE THE BIT MAP
        matrix.postScale(scaleWidth, scaleHeight);

        // "RECREATE" THE NEW BITMAP
        Bitmap resizedBitmap = Bitmap.createBitmap(
                bm, 0, 0, width, height, matrix, false);
        bm.recycle();
        return resizedBitmap;
    }





}