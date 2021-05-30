// Helper file to make coverage work for all dart files

import 'package:lms_flutter/model/consts/base_url.dart';
import 'package:lms_flutter/model/course/course_data.dart';
import 'package:lms_flutter/model/course/visibility_data.dart';
import 'package:lms_flutter/model/discussions/discussion_data.dart';
import 'package:lms_flutter/model/discussions/message_data.dart';
import 'package:lms_flutter/model/pagination/pagination_discussion.dart';
import 'package:lms_flutter/model/pagination/pagination_message.dart';
import 'package:lms_flutter/model/pagination/pagination_post.dart';
import 'package:lms_flutter/model/posts/commentaire_data.dart';
import 'package:lms_flutter/model/posts/like_data.dart';
import 'package:lms_flutter/model/posts/post_data.dart';
// ignore_for_file: unused_import
import 'package:lms_flutter/model/user_infos.dart';
import 'package:lms_flutter/model/user_register_form.dart';
import 'package:lms_flutter/services/auth_service.dart';
import 'package:lms_flutter/services/base_service.dart';
import 'package:lms_flutter/services/course_service.dart';
import 'package:lms_flutter/services/data_list/data_list_service.dart';
import 'package:lms_flutter/services/data_list/discussion_list_service.dart';
import 'package:lms_flutter/services/data_list/message_list_service.dart';
import 'package:lms_flutter/services/data_list/post_list_service.dart';
import 'package:lms_flutter/services/exceptions/authentication_exception.dart';
import 'package:lms_flutter/services/exceptions/bad_request_exception.dart';
import 'package:lms_flutter/services/exceptions/network_exception.dart';
import 'package:lms_flutter/services/exceptions/not_found_exception.dart';
import 'package:lms_flutter/services/exceptions/unknown_exception.dart';
import 'package:lms_flutter/services/message_service.dart';
import 'package:lms_flutter/services/post_service.dart';
import 'package:lms_flutter/services/service_locator.dart';

void main() {}
