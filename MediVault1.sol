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
        string specialization;
        string problemDescription;
        address doctor;
        string symptoms;
    }

    Case[] public cases;

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

    mapping(address => mapping(uint => Case)) public doctorPatientCases;

    function addCase(
        uint _pId, 
        string memory _specialization, 
        string memory _problemDescription, 
        address _doctor, 
        string memory _symptoms
    ) public {
        Case memory newCase = Case(_pId, _specialization, _problemDescription, _doctor, _symptoms);
        cases.push(newCase);
        doctorPatientCases[_doctor][_pId] = newCase;
    }

    function getCase(uint pId, address doctorAddress) public view returns (uint, string memory, string memory, address, string memory) {
        Case memory caseInfo = doctorPatientCases[doctorAddress][pId];
        return (caseInfo.pId, caseInfo.specialization, caseInfo.problemDescription, caseInfo.doctor, caseInfo.symptoms);
    }
}