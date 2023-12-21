
// ignore_for_file: non_constant_identifier_names

class StatusCodeConstant {
  // Note: Only the widely used HTTP status codes are documented

  // Informational

  static int CONTINUE = 100;
  static int SWITCHING_PROTOCOLS = 101;
  static int PROCESSING = 102;            // RFC2518

  // Success

  /*
   * The request has succeeded
   */
  static int OK = 200;

  /*
   * The server successfully created a new resource
   */
  static  int CREATED = 201;
  static  int ACCEPTED = 202;
  static  int NON_AUTHORITATIVE_INFORMATION = 203;

  /*
   * The server successfully processed the request, though no content is returned
   */
  static  int NO_CONTENT = 204;
  static  int RESET_CONTENT = 205;
  static  int PARTIAL_CONTENT = 206;
  static  int MULTI_STATUS = 207;          // RFC4918
  static  int ALREADY_REPORTED = 208;      // RFC5842
  static  int IM_USED = 226;               // RFC3229

  // Redirection

  static int MULTIPLE_CHOICES = 300;
  static int MOVED_PERMANENTLY = 301;
  static int FOUND = 302;
  static int SEE_OTHER = 303;

  /*
   * The resource has not been modified since the last request
   */
  static int NOT_MODIFIED = 304;
  static int USE_PROXY = 305;
  static int RESERVED = 306;
  static int TEMPORARY_REDIRECT = 307;
  static int PERMANENTLY_REDIRECT = 308;  // RFC7238

  // Client Error

  /*
   * The request cannot be fulfilled due to multiple errors
   */
  static int BAD_REQUEST = 400;

  /*
   * The user is unauthorized to access the requested resource
   */
  static int UNAUTHORIZED = 401;
  static int PAYMENT_REQUIRED = 402;

  /*
   * The requested resource is unavailable at this present time
   */
  static int FORBIDDEN = 403;

  /*
   * The requested resource could not be found
   *
   * Note: This is sometimes used to mask if there was an UNAUTHORIZED (401) or
   * FORBIDDEN (403) error, for security reasons
   */
  static int NOT_FOUND = 404;

  /*
   * The request method is not supported by the following resource
   */
  static int METHOD_NOT_ALLOWED = 405;

  /*
   * The request was not acceptable
   */
  static int NOT_ACCEPTABLE = 406;
  static int PROXY_AUTHENTICATION_REQUIRED = 407;
  static int REQUEST_TIMEOUT = 408;

  /*
   * The request could not be completed due to a conflict with the current state
   * of the resource
   */
  static int CONFLICT = 409;
  static int GONE = 410;
  static int LENGTH_REQUIRED = 411;
  static int PRECONDITION_FAILED = 412;
  static int REQUEST_ENTITY_TOO_LARGE = 413;
  static int REQUEST_URI_TOO_LONG = 414;
  static int UNSUPPORTED_MEDIA_TYPE = 415;
  static int REQUESTED_RANGE_NOT_SATISFIABLE = 416;
  static int EXPECTATION_FAILED = 417;
  static int I_AM_A_TEAPOT = 418;                                               // RFC2324
  static int UNPROCESSABLE_ENTITY = 422;                                        // RFC4918
  static int LOCKED = 423;                                                      // RFC4918
  static int FAILED_DEPENDENCY = 424;                                           // RFC4918
  static int RESERVED_FOR_WEBDAV_ADVANCED_COLLECTIONS_EXPIRED_PROPOSAL = 425;   // RFC2817
  static int UPGRADE_REQUIRED = 426;                                            // RFC2817
  static int PRECONDITION_REQUIRED = 428;                                       // RFC6585
  static int TOO_MANY_REQUESTS = 429;                                           // RFC6585
  static int REQUEST_HEADER_FIELDS_TOO_LARGE = 431;                             // RFC6585

  // Server Error

  /*
   * The server encountered an unexpected error
   *
   * Note: This is a generic error message when no specific message
   * is suitable
   */
  static int INTERNAL_SERVER_ERROR = 500;

  /*
   * The server does not recognise the request method
   */
  static int NOT_IMPLEMENTED = 501;
  static int BAD_GATEWAY = 502;
  static int SERVICE_UNAVAILABLE = 503;
  static int GATEWAY_TIMEOUT = 504;
  static int VERSION_NOT_SUPPORTED = 505;
  static int VARIANT_ALSO_NEGOTIATES_EXPERIMENTAL = 506;                        // RFC2295
  static int INSUFFICIENT_STORAGE = 507;                                        // RFC4918
  static int LOOP_DETECTED = 508;                                               // RFC5842
  static int NOT_EXTENDED = 510;                                                // RFC2774
  static int NETWORK_AUTHENTICATION_REQUIRED = 511;

}