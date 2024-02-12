// type RegistrationResponse = {
//     message: string;
//     activationToken: string;
//   };



enum Gender {
    Male = "MALE",
    Female = "FEMALE",
  }
enum Role {
    Customer = "Customer",
    Admin = "Admin",
    Broker = "Broker",
}
  
type RegistrationResponse = {
    _id: string;
    firstName: string;
    middleName: string;
    sirName: string;
    email: string;
    phoneNumber: string;
    region: string;
    gender: Gender;
    photos: String[];
    password: string;
    isVerified: boolean;
    role: Role;
};



  
type RegistrationData = {
    firstName : string
    middleName : string
    sirName : string
    email : string
    phoneNumber : string
    password : string
    gender : string
    region : string
};