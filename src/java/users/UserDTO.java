/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package users;

/**
 *
 * @author Hammo
 */
public class UserDTO {
   private String userID;
    private String fullName;
    private String roleID;
    private String password;
    private String address;
    private String phone;
    private boolean status;

    public UserDTO() {
        this.userID = "";
        this.fullName = "";
        this.roleID = "";
        this.password = "";
        this.address = "";
        this.phone = "";
        this.status=true;
    }

    public UserDTO(String userID, String fullName, String roleID, String password, String address, String phone, boolean status) {
        this.userID = userID;
        this.fullName = fullName;
        this.roleID = roleID;
        this.password = password;
        this.address = address;
        this.phone = phone;
        this.status = status;
    }

    public UserDTO(String userID, String fullName , String roleID ) {
        this.userID = userID;
        this.fullName = fullName;
        this.roleID = roleID;
    }

 

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public void setRoleID(String roleID) {
        this.roleID = roleID;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void isStatus(boolean status) {
        this.status = status;
    }

    public String getUserID() {
        return userID;
    }

    public String getFullName() {
        return fullName;
    }

    public String getRoleID() {
        return roleID;
    }

    public String getPassword() {
        return password;
    }

    public String getAddress() {
        return address;
    }

    public String getPhone() {
        return phone;
    }

    public boolean isStatus() {
        return status;
    }

}

