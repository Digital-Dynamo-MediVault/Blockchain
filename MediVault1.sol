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
        uint256 phone;
        string addressp;
        string bloodGroup;
        string guardian;
        uint256 guardianp;
        address metamaskAddress;
    }

    struct Doctor{
        uint256 dId;
        string name;
        uint48 age;
        string gender;
        string email;
        uint phone;
        uint48 experience;
        string specialization;
        address metamaskAddress;
    }

    struct Case {
        uint pId;
        uint cId;
        string specialization;
        string problemDescription;
        address doctor;
        string symptoms;
    }

    Case[] public cases;

    struct Prescription {
        uint pId;
        uint cId;
        address doctor;
        string prescribed;
    }

    Prescription[] public prescribes;

    mapping(address => Patient) public patients;

    function addPatient(
        uint256 pId,
        string memory name, 
        uint48 age, 
        string memory gender, 
        string memory email, 
        uint256 phone,
        string memory addressp, 
        string memory bloodGroup, 
        string memory guardian,
        uint256 guardianp,
        address metamaskAddress
    ) public {
        Patient memory newPatient = Patient(pId,name, age, gender, email, phone,addressp, bloodGroup, guardian, guardianp, metamaskAddress);
        patients[metamaskAddress] = newPatient;
    }

    mapping(address => Doctor) public doctors;

    function addDoctor(
        uint256 dId,
        string memory name, 
        uint48 age,
        string memory gender,
        string memory email, 
        uint256 phone,
        uint48 experience, 
        string memory specialization, 
        address metamaskAddress
    ) public {
        Doctor memory newDoctor = Doctor(dId,name, age, gender,email, phone, experience, specialization, metamaskAddress);
        doctors[metamaskAddress] = newDoctor;
    }

    mapping(address => mapping(uint => mapping(uint => Case))) public doctorPatientCases;

    function addCase(
        uint _pId, 
        uint _cId,
        string memory _specialization, 
        string memory _problemDescription, 
        address _doctor, 
        string memory _symptoms
    ) public {
        Case memory newCase = Case(_pId, _cId, _specialization, _problemDescription, _doctor, _symptoms);
        cases.push(newCase);
        doctorPatientCases[_doctor][_pId][_cId]= newCase;
    }

    function getCase(uint pId, uint cId, address doctorAddress) public view returns (uint, uint,string memory, string memory, address, string memory) {
        Case memory caseInfo = doctorPatientCases[doctorAddress][pId][cId];
        return (caseInfo.pId, caseInfo.cId, caseInfo.specialization, caseInfo.problemDescription, caseInfo.doctor, caseInfo.symptoms);
    }

    mapping(address => mapping(uint => mapping(uint => Prescription))) public doctorPatientPrescriptions;


    function addPrescription(
        uint pId,
        uint cId,
        address doctor,
        string memory prescribed
    ) public {
        Prescription memory newPrescription = Prescription(pId, cId, doctor, prescribed);
        prescribes.push(newPrescription);
        doctorPatientPrescriptions[doctor][pId][cId] = newPrescription;
    }

    function getPrescription(uint pId, uint cId,address doctor) public view returns (uint, uint, address, string memory){
        Prescription memory prescriptionInfo = doctorPatientPrescriptions[doctor][pId][cId];
        return(prescriptionInfo.pId, prescriptionInfo.cId, prescriptionInfo.doctor, prescriptionInfo.prescribed);
    }
}