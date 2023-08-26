
package com.multi.cookies.snack.service;

import com.multi.cookies.snack.dao.NutritionalDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NutritionalServiceImpl implements NutritionalService {

    @Autowired
    NutritionalDAO nutritionalDAO;

}