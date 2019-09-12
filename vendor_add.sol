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
    bool randomDigitMatch = false;  // to strore the outcome of the match of random digits.
    
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
            // extracting the last digit and assigning to verifying vendor.
            employeeVerifiers[i].ranNo = randomHash % 10;  
            randomHash /= 10;  // removing the last digit that is already extracted.
            i--;
        } employeeVerifiers[0].ranNo = randomHash;
    }
    
    function matchNo() public payable returns (bool){
        uint i = 4;
        while (i > 0) {
            if (employeeVerifiers[i].ranNo != randNoHold % 10) return (false);
            randNoHold /= 10;
            i--;
        }
        if (employeeVerifiers[0].ranNo == randNoHold) {
            randomDigitMatch = true;
            return (true);
        }
        else return (false);
        
    }
    function vendorAddToList() public {
        if (randomDigitMatch == true) {
            vendors[venCount].id = vendorProspectId;
            vendors[venCount].vendorName = vendorProspectName;
        }

    }
    function getEmpVerifiers (uint m) public view returns (uint, string, uint){
        return(employeeVerifiers[m].id, employeeVerifiers[m].name, employeeVerifiers[m].ranNo);
    }
    function getVenDetails (uint m) public view returns (uint, string){
        return(vendors[m].id, vendors[m].vendorName);
    }
    //function getIndividualDigits (uint8 r) public returns (uint) {return EmployeeVerifiers[r].ranNo;}

}