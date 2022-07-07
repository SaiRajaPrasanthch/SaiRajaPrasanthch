String Main_URL = 'http://182.72.162.182:8080'; //global

// String Main_URL = 'http://192.168.10.49'; //local

String strGetUserInfoURL = '$Main_URL/userservice/api/User/GetUserInfo?'; // get call with user info

String URL_POST_CREATEQUICKBLOXID = '$Main_URL/quickbloxservice/api/QuickBlox/CreateQuickBloxId'; // post call with create account of quick blox details in Our DB.

String URL_POST_VALIDATEUSER = '$Main_URL/securityService/api/User/ValidateUser'; // post call to valid a user directly

String URL_POST_CHNAGEPASSWORD = '$Main_URL/securityService/api/User/ChangePassword'; // post call to valid a user to change password

String URL_GET_CARRIER_TERMINAL_BY_OPERATIONTYPE =
    '$Main_URL/Carrierservice/api/Carrier/GetCarriersAndTerminalInfoByOperationType?operationTypeId='; // GET call to get  carrier and terminal by operation type

String URL_GET_CARRIER_TERMINAL_BY_USERID_OPERATIONID = '$Main_URL/terminalservice/api/Terminal/GetTerminalsByOpsType?'; // GET call to get  carrier and terminal by operation id and user id

String URL_GET_OPERATION_TYPES = '$Main_URL/Carrierservice/api/Carrier/GetAllOperationTypes';// GET call to get  openration types
