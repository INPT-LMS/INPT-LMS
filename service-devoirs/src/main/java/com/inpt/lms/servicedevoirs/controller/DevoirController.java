package com.inpt.lms.servicedevoirs.controller;

import com.inpt.lms.servicedevoirs.dto.DevoirDTO;
import com.inpt.lms.servicedevoirs.dto.DevoirReponseDTO;
import com.inpt.lms.servicedevoirs.dto.NoteDTO;
import com.inpt.lms.servicedevoirs.model.Devoir;
import com.inpt.lms.servicedevoirs.model.DevoirReponse;
import com.inpt.lms.servicedevoirs.service.DevoirService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

// TODO Verifier autorisation
@RestController
@AllArgsConstructor
public class DevoirController {
   private final DevoirService devoirService;

   @GetMapping("/devoir")
   public List<Devoir> getDevoirs(){
      List<Devoir> l = devoirService.recupererDevoirs();
      return l;
   }

   @PostMapping("/devoir")
   public Devoir addDevoir(@RequestBody DevoirDTO devoirDTO){
      return devoirService.addDevoir(devoirDTO);
   }

   @GetMapping("/devoir/{idDevoir}")
   public Devoir getDevoir(@PathVariable String idDevoir){
     Devoir devoir = devoirService.recupererDevoir(idDevoir);
      return devoir;
   }

   @PutMapping("/devoir/{idDevoir}/rendu")
   public DevoirReponse rendreDevoir(@PathVariable String idDevoir, @RequestBody DevoirReponseDTO devoirReponseDTO){
      return devoirService.rendreDevoir(idDevoir,devoirReponseDTO);
   }

   @PutMapping("/devoir/{idDevoir}/rendu/{idReponse}")
   public DevoirReponse noterDevoir(@PathVariable String idDevoir,@PathVariable String idReponse,@RequestBody NoteDTO noteDTO){
      return devoirService.noterDevoir(idDevoir,idReponse,noteDTO);
   }
}
