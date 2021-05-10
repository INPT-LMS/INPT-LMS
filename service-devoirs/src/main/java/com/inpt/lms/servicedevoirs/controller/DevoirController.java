package com.inpt.lms.servicedevoirs.controller;

import com.inpt.lms.servicedevoirs.dto.DevoirDTO;
import com.inpt.lms.servicedevoirs.dto.DevoirReponseDTO;
import com.inpt.lms.servicedevoirs.dto.NoteDTO;
import com.inpt.lms.servicedevoirs.exception.DevoirNotFoundException;
import com.inpt.lms.servicedevoirs.exception.RenduNotFoundException;
import com.inpt.lms.servicedevoirs.model.Devoir;
import com.inpt.lms.servicedevoirs.model.DevoirReponse;
import com.inpt.lms.servicedevoirs.service.DevoirService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@AllArgsConstructor
public class DevoirController {
   private final DevoirService devoirService;

   @GetMapping("/devoirs/{courseId}")
   public List<Devoir> getDevoirs(@RequestHeader(name ="X-USER-ID")Long userId, @PathVariable UUID courseId){
      return devoirService.recupererDevoirs(userId,courseId);
   }

   @GetMapping("/devoirs/{courseId}/{devoirId}")
   public Devoir getDevoir(@RequestHeader(name = "X-USER-ID") Long userId, @PathVariable UUID courseId, @PathVariable String devoirId){
      Devoir devoir = null;
      try {
         devoir = devoirService.recupererDevoir(userId, courseId,devoirId);
      } catch (DevoirNotFoundException e) {
         // TODO return error
         System.out.println("Devoir not found");
      }catch (IllegalAccessError e) {
         // TODO return error
         System.out.println("Access denied");
      }
      return devoir;
   }

   @PostMapping("/devoirs/{courseId}")
   public Devoir addDevoir(@RequestHeader(name = "X-USER-ID") Long userId,@PathVariable UUID courseId, @RequestBody DevoirDTO devoirDTO){
      Devoir devoir = null;
      try {
         devoir = devoirService.addDevoir(userId, courseId, devoirDTO);
      }catch (IllegalAccessError e) {
         // TODO return error
         System.out.println("Access denied");
      }
      return devoir;
   }

   @PutMapping("/devoirs/{courseId}/{devoirId}/rendu")
   public DevoirReponse rendreDevoir(@RequestHeader(name = "X-USER-ID") Long userId, @PathVariable UUID courseId, @PathVariable String devoirId, @RequestBody DevoirReponseDTO devoirReponseDTO){
      DevoirReponse devoirReponse = null;
      try {
         devoirReponse = devoirService.rendreDevoir(userId, courseId,devoirId,devoirReponseDTO);
      } catch (DevoirNotFoundException e) {
         // TODO return error
         e.printStackTrace();
      }catch (IllegalAccessError e) {
         // TODO return error
         System.out.println("Access denied");
      }

      return devoirReponse;
   }

   @PutMapping("/devoirs/{courseId}/{devoirId}/rendu/{idReponse}")
   public DevoirReponse noterDevoir(@RequestHeader(name = "X-USER-ID") Long userId, @PathVariable UUID courseId, @PathVariable String devoirId,@PathVariable String idReponse,@RequestBody NoteDTO noteDTO){
      DevoirReponse devoirReponse = null;
      try {
         devoirReponse = devoirService.noterDevoir(userId, courseId, devoirId,idReponse,noteDTO);
      } catch (DevoirNotFoundException e) {
         // TODO return error
         e.printStackTrace();
      } catch (RenduNotFoundException e) {
         // TODO return error
         e.printStackTrace();
      }catch (IllegalAccessError e) {
         // TODO return error
         System.out.println("Access denied");
      }
      return devoirReponse;
   }
}
