// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

contract MediVault1 {
    struct Patient {
        uint256 pId;
        string name;
        uint48 age;
        string gender;
        string email;
        string addressp;
        string bloodGroup;
        string guardian;
        uint256 guardianp;
        address metamaskAddress;
    }

    struct Doctor{
        string name;
        uint48 age;
        string gender;
        string email;
        uint48 experience;
        string specialization;
        address metamaskAddress;
    }

    struct Hospital{
        string name;
        string addressh;
        string email;
        uint256 phoneno;
    }

    mapping(address => Patient) public patients;

    function addPatient(
        uint256 pId,
        string memory name, 
        uint48 age, 
        string memory gender, 
        string memory email, 
        string memory addressp, 
        string memory bloodGroup, 
        string memory guardian,
        uint256 guardianp,
        address metamaskAddress
    ) public {
        Patient memory newPatient = Patient(pId,name, age, gender, email, addressp, bloodGroup, guardian, guardianp, metamaskAddress);
        patients[metamaskAddress] = newPatient;
    }

    mapping(address => Doctor) public doctors;

    function addDoctor(
        string memory name, 
        uint48 age,
        string memory gender,
        string memory email, 
        uint48 experience, 
        string memory specialization, 
        address metamaskAddress
    ) public {
        Doctor memory newDoctor = Doctor(name, age, gender,email, experience, specialization, metamaskAddress);
        doctors[metamaskAddress] = newDoctor;
    }

    mapping(address => Hospital) public hospitals;

    function addHospital(
        string memory name, 
        string memory addressh, 
        string memory email, 
        uint256 phoneno, 
        address hospitalAddress
    ) public {
        Hospital memory newHospital = Hospital(name, addressh, email, phoneno);
        hospitals[hospitalAddress] = newHospital;
    }


    struct Diagnosis {
        string description;
        address doctorAddress;
    }

    struct MedicalRecord {
        Diagnosis[] diagnoses;
        mapping(address => Diagnosis) doctorDiagnoses; 
    }

    MedicalRecord[] private medicalRecords; 

    function getMedicalRecord(uint index) public view returns (Diagnosis[] memory) {
        return medicalRecords[index].diagnoses;
    }

    function getDiagnosis(uint recordIndex, address doctorAddress) public view returns (string memory) {
        return medicalRecords[recordIndex].doctorDiagnoses[doctorAddress].description;
    }

    function addDiagnosis(uint recordIndex, address doctorAddress, string memory description) public {
        Diagnosis memory newDiagnosis = Diagnosis(description, doctorAddress);
        medicalRecords[recordIndex].diagnoses.push(newDiagnosis);
        medicalRecords[recordIndex].doctorDiagnoses[doctorAddress] = newDiagnosis;
    }


}