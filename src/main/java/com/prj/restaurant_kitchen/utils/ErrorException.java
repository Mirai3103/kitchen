package com.prj.restaurant_kitchen.utils;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ErrorException extends RuntimeException {

    private int statusCode;
    private String message;

    public ErrorException(int statusCode, String message) {
        super(message);
        this.statusCode = statusCode;
        this.message = message;
    }

}