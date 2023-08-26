package com.multi.cookies.snack.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SnackDTO {
    int snack_id;
    String snack_name;
    String company;
    String snack_img;
    String snack_ingredients;
    boolean snack_sweet;
    boolean snack_salty;
    String snack_reportNo;
//   String allergy;


//   @Data
//   @Builder
//   @AllArgsConstructor
//   @NoArgsConstructor
//   public static class SearchDTO {
//       int snack_id;
//       String snack_name;
//       String company;
//       String snack_ingredients;
//       String allergy;
//       float avg_score;
//   }

//   private SearchDTO searchDTO;
//   public void setSearchDTO(SearchDTO searchDTO){
//       this.searchDTO = searchDTO;
//   }
//   public SearchDTO getSearchDTO(){
//       return searchDTO;
//    }


}