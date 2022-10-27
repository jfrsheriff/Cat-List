//
//  ProfileScreen.swift
//  EmeritusTakeHome
//
//  Created by Jaffer Sheriff U on 19/10/22.
//


import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack{
            ProfileImageWithNameView(imageName: "Profile",
                                     profileName: ProfileDetailsConstants.name)
            Spacer()
                .frame( height: 50)
            
            VStack(alignment: .leading, spacing: 15){
                HStack{
                    Image(systemName: "envelope")
                    Text(verbatim:ProfileDetailsConstants.emailId)
                }
                HStack{
                    Image(systemName: "phone")
                    Text(verbatim:ProfileDetailsConstants.mobileNumber)
                }
            }
            
            Spacer()
                .frame( height: 50)
            
            HStack(spacing: 40){
                
                ExtractedView()
                ExternalProfileLinkView(imageName: "GitHub",
                                        profileUrlStr: ProfileURLConstants.gitHub)
                ExternalProfileLinkView(imageName: "LeetCode",
                                        profileUrlStr: ProfileURLConstants.leetCode)
                ExternalProfileLinkView(imageName: "Instagram",
                                        profileUrlStr: ProfileURLConstants.instagram)
                
            }
        }
    }
    
}

struct ProfileImageWithNameView : View{
    
    var imageName : String
    var profileName : String
    
    var body: some View{
        VStack(spacing : 25){
            if #available(iOS 15.0, *) {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(.white, lineWidth: 2)
                        
                    }
                    .shadow(radius: 5)
            } else {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .shadow(radius: 5)
            }
            
            Text(profileName)
                .font(.headline)
                .fontWeight(.heavy)
        }
    }
}


struct ExtractedView: View {
    var body: some View {
        ExternalProfileLinkView(imageName: "LinkedIn",
                                profileUrlStr: ProfileURLConstants.linkedIn)
    }
}

struct ExternalProfileLinkView: View {
    let imageName : String
    let profileUrlStr : String
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View{
        Image(imageName)
            .resizable()
            .renderingMode(.template)
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .frame(width: 40, height: 40)
            .onTapGesture {
                openExternalUrl(urlString: profileUrlStr)
            }
    }
    
    func openExternalUrl(urlString : String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        UIApplication.shared.open(url)
    }
}



struct ProfileURLConstants {
    static let linkedIn = "https://www.linkedin.com/in/jaffer-sheriff-07354b68/"
    static let gitHub = "https://github.com/jfrsheriff"
    static let leetCode = "https://leetcode.com/jfrsheriff/"
    static let instagram = "https://www.instagram.com/jaffer.sheriff1/"
}

struct ProfileDetailsConstants {
    static let name = "Jaffer Sheriff U"
    static let mobileNumber = "+91-9688224325"
    static let emailId = "jfrsheriff@gmail.com"
}
