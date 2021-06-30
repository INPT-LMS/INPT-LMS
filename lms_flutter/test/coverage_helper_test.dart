// Helper file to make coverage work for all dart files

import 'package:lms_flutter/components/consts/custom_colors.dart';
import 'package:lms_flutter/components/course_elements/AboutSection.dart';
import 'package:lms_flutter/components/course_elements/AddPost.dart';
import 'package:lms_flutter/components/course_elements/CourseExtras.dart';
import 'package:lms_flutter/components/course_elements/course_settings.dart';
import 'package:lms_flutter/components/devoirs/devoir.dart';
import 'package:lms_flutter/components/discussions/discussion.dart';
import 'package:lms_flutter/components/discussions/message.dart';
import 'package:lms_flutter/components/posts/comment.dart';
import 'package:lms_flutter/components/posts/like_comment.dart';
import 'package:lms_flutter/components/posts/post.dart';
import 'package:lms_flutter/components/profile/CoverPic.dart';
import 'package:lms_flutter/components/profile/ProfileCourseSection.dart';
import 'package:lms_flutter/components/profile/ProfilePic.dart';
import 'package:lms_flutter/components/settings/ProfilePic.dart';
import 'package:lms_flutter/components/settings/SettingsElement.dart';
import 'package:lms_flutter/components/settings/generalInfosEdit.dart';
import 'package:lms_flutter/components/settings/passwordEdit.dart';
import 'package:lms_flutter/components/stockage/fichier_resume.dart';
import 'package:lms_flutter/main.dart';
import 'package:lms_flutter/mock_components/CoursePageStatique.dart';
import 'package:lms_flutter/mock_components/mock_home_screen.dart';
import 'package:lms_flutter/mock_components/mock_post.dart';
import 'package:lms_flutter/model/consts.dart';
import 'package:lms_flutter/model/course/course_data.dart';
import 'package:lms_flutter/model/course/member.dart';
import 'package:lms_flutter/model/course/professor.dart';
import 'package:lms_flutter/model/course/visibility_data.dart';
import 'package:lms_flutter/model/devoir/devoir_data.dart';
import 'package:lms_flutter/model/devoir/devoir_infos.dart';
import 'package:lms_flutter/model/devoir/devoir_reponse_data.dart';
import 'package:lms_flutter/model/devoir/fichier_reponse.dart';
import 'package:lms_flutter/model/discussion/discussion_data.dart';
import 'package:lms_flutter/model/discussion/message_data.dart';
import 'package:lms_flutter/model/pagination/pagination_devoir.dart';
import 'package:lms_flutter/model/pagination/pagination_discussion.dart';
import 'package:lms_flutter/model/pagination/pagination_fichier.dart';
import 'package:lms_flutter/model/pagination/pagination_message.dart';
import 'package:lms_flutter/model/pagination/pagination_post.dart';
import 'package:lms_flutter/model/post/commentaire_data.dart';
import 'package:lms_flutter/model/post/like_data.dart';
import 'package:lms_flutter/model/post/post_data.dart';
import 'package:lms_flutter/model/stockage/fichier.dart';
import 'package:lms_flutter/model/stockage/fichier_info.dart';
// ignore_for_file: unused_import
import 'package:lms_flutter/model/user_infos.dart';
import 'package:lms_flutter/model/user_register_form.dart';
import 'package:lms_flutter/screens/CoursePage.dart';
import 'package:lms_flutter/screens/LoginPage.dart';
import 'package:lms_flutter/screens/ProfilePage.dart';
import 'package:lms_flutter/screens/Settings.dart';
import 'package:lms_flutter/screens/SignUpPage.dart';
import 'package:lms_flutter/screens/devoir_details_screen.dart';
import 'package:lms_flutter/screens/discussion_screen.dart';
import 'package:lms_flutter/screens/envoyer_message_screen.dart';
import 'package:lms_flutter/screens/fichier_details_screen.dart';
import 'package:lms_flutter/screens/home_screen.dart';
import 'package:lms_flutter/screens/liste/liste_data.dart';
import 'package:lms_flutter/screens/liste_devoirs_cours_screen.dart';
import 'package:lms_flutter/screens/liste_discussion_screen.dart';
import 'package:lms_flutter/screens/liste_reponses_devoir.dart';
import 'package:lms_flutter/screens/scaffold_app_bar.dart';
import 'package:lms_flutter/screens/stockage_cours_screen.dart';
import 'package:lms_flutter/screens/stockage_sac_screen.dart';
import 'package:lms_flutter/screens/utils.dart';
import 'package:lms_flutter/screens/view_models/infos_model.dart';
import 'package:lms_flutter/screens/view_models/liste_data_model.dart';
import 'package:lms_flutter/services/base_service.dart';
import 'package:lms_flutter/services/compte_service.dart';
import 'package:lms_flutter/services/course_service.dart';
import 'package:lms_flutter/services/data_list/data_list_service.dart';
import 'package:lms_flutter/services/data_list/devoir_list_service.dart';
import 'package:lms_flutter/services/data_list/discussion_list_service.dart';
import 'package:lms_flutter/services/data_list/fichier_list_service.dart';
import 'package:lms_flutter/services/data_list/message_list_service.dart';
import 'package:lms_flutter/services/data_list/post_cours_list_service.dart';
import 'package:lms_flutter/services/data_list/post_list_service.dart';
import 'package:lms_flutter/services/devoir_service.dart';
import 'package:lms_flutter/services/dio_client.dart';
import 'package:lms_flutter/services/exceptions/authentication_exception.dart';
import 'package:lms_flutter/services/exceptions/forbidden_exception.dart';
import 'package:lms_flutter/services/exceptions/no_permission_exception.dart';
import 'package:lms_flutter/services/message_service.dart';
import 'package:lms_flutter/services/post_service.dart';
import 'package:lms_flutter/services/service_locator.dart';
import 'package:lms_flutter/services/settings_service.dart';
import 'package:lms_flutter/services/stockage_service.dart';

void main() {}
