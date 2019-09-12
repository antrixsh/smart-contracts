pragma solidity ^0.4.0;

contract VendorAddition {
    
    //Structure to hold details of Person
    struct Person {
        uint id; //id of Person
        string name; //name of Person
        uint ranNo; //stores part of randon no. for verifical of new vendor addition.
        
    }
    //Structure to hold details of Vendor
    struct Vendor {
        uint8 id; // id of Vendor
        string vendorName; // name of vendor
    }
    
    Person[5] employeeVerifiers; // Array containing 5 person objects
    Vendor[1] vendors; // Array containing 1 vendor
    
    uint8 empCount = 0; uint8 venCount = 0; //counters for employee and vendor
    uint randNoHold = 0; // stores the random no. generated to be available outside the random no. generator function
    uint8 vendorProspectId; string vendorProspectName; //temporarily stores vendor details
    
    //functions
    function createEmpVerifiers (uint _x, string _nm) public {
        employeeVerifiers[empCount].id = _x;
        employeeVerifiers[empCount].name = _nm;
        empCount++;
        
    }
    
    function captureProspectVendorDetails (uint8 _venId, string _venName) public {
       vendorProspectId = _venId;
       vendorProspectName = _venName;
       
    }

    function genRandomNo () public payable {
        //view returns (uint)
        uint randomHash = 0;
        while (randomHash <=9999) {
            randomHash = uint(keccak256(block.difficulty, now)) % 100000;
        }
        
        //distribute portion of random no. to Verifyign Employees
        randNoHold = randomHash;
        uint8 i = 4;
        while (i > 0) {
            employeeVerifiers[4-i].ranNo = randNoHold;
            i--;
        } employeeVerifiers[4].ranNo = randNoHold;
    }
    function matchNo() public view returns (bool){
        uint8 i = 0;
        while (i<5) {
            if (employeeVerifiers[i].ranNo != randNoHold) return (false);
            i++;
        } return (true);
        
    }
    function vendorAddToList() public {
       
        vendors[venCount].id = vendorProspectId;
        vendors[venCount].vendorName = vendorProspectName;

    }
    function getEmpVerifiers (uint m) public view returns (uint, string, uint){
        return(employeeVerifiers[m].id, employeeVerifiers[m].name, employeeVerifiers[m].ranNo);
    }
    function getVenDetails (uint m) public view returns (uint, string){
        return(vendors[m].id, vendors[m].vendorName);
    }
    //function getIndividualDigits (uint8 r) public returns (uint) {return EmployeeVerifiers[r].ranNo;}

}