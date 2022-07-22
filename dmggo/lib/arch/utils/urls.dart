String mainURL = 'http://182.72.162.182:8080'; //global

// String Main_URL = 'http://192.168.10.49'; //local

String urlSubUserService = '$mainURL/userservice';


//local 
// String urlSubQuickBloxService = '$mainURL/quickbloxservice';
// String urlSubSecurityService = '$mainURL/securityService';
// String urlSubTerminalService = '$mainURL/terminalservice';

//Azure
String urlSubTerminalService = 'https://terminalservice.azurewebsites.net';
String urlSubQuickBloxService = 'https://quickbloxserviceapi.azurewebsites.net';
String urlSubSecurityService = 'https://securityservice.azurewebsites.net';

String urlGetUserInfoURL = '$urlSubUserService/api/User/GetUserInfo?'; // get call with user info

String urlPostCreateQuickBloxId = '$urlSubQuickBloxService/api/QuickBlox/CreateQuickBloxId'; // post call with create account of quick blox details in Our DB.

String urlPostValidateUser = '$urlSubSecurityService/api/User/ValidateUser'; // post call to valid a user directly

String urlPostChangePassword = '$urlSubSecurityService/api/User/ChangePassword'; // post call to valid a user to change password

String urlGetCarrierTerminalByOperationType =
    '$urlSubTerminalService/api/Carrier/GetCarriersAndTerminalInfoByOperationType?operationTypeId='; // GET call to get  carrier and terminal by operation type

String urlGetCarrierTerminalByUserIdOperationId = '$urlSubTerminalService/api/Terminal/GetTerminalsByOpsType?'; // GET call to get  carrier and terminal by operation id and user id

String urlGetOperationsType = '$urlSubTerminalService/api/Carrier/GetAllOperationTypes';// GET call to get  openration types
