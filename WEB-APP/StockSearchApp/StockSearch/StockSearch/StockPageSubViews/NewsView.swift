//
//  NewsView.swift
//  StockSearch
//
//  Created by Karthik Kancharla on 4/7/24.
//

import SwiftUI

//struct NewsView: View {
//    let articles: [NewsArticle]
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}

// 20 images, check if something is null or not
// check if those twitter and facebook functions are proper

//struct ArticleDetailView: View {
//    let article: NewsArticle
//
//    var body: some View {
//        Text("hello from article detail")
//    }
//
////}
//
//struct ArticleDetailView: View {
//    let article: NewsArticle
//    @Binding var showingDetail: Bool
//    
//    var body: some View {
//        //        Text("hello")
//        NavigationView {
//            VStack {
//                ScrollView {
//                    VStack(alignment: .leading) {
//                        Text(article.source)
//                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
//                            .fontWeight(.bold)
//                        Text(article.formattedDate)
//                            .padding(.vertical, 0)
//                            .foregroundColor(.secondary)
//                        Divider()
//                        
//                        Text(article.headline)
//                            .font(.title3)
//                            .fontWeight(.semibold)
//                            .padding(.vertical, 0)
//                        
//                        Text(article.summary)
//                            .font(.footnote)
//                            .padding(.vertical, 0)
//                        //                                    .padding(.top, 5)
//                        HStack(){
//                            Text("For more details click")
//                                .font(.footnote)
//                                .foregroundColor(.secondary)
//                            Link("here", destination: URL(string: article.url)!)
//                                .foregroundColor(.blue)
//                                .font(.footnote)
//                            
//                            
//                        }
//                        .padding(.vertical, 0)
//                        
//                        HStack {
//                            
//                            Button(action: {
//                                shareOnTwitter(article: article)
//                            }) {
//                                Image("twitter_icon")
//                                    .resizable()  // Make the image resizable
//                                    .scaledToFit()  // Maintain the aspect ratio
//                                    .frame(width: 50)  // Explicitly set the size you want
//                            }
//                            
//                            Button(action: {
//                                shareOnFacebook(article: article)
//                            }) {
//                                Image("facebook_icon")
//                                    .resizable()  // Make the image resizable
//                                    .scaledToFit()  // Maintain the aspect ratio
//                                    .frame(width: 50)  // Explicitly set the size you want
//                                
//                            }
//                            
//                            
//                            
//                            
//                        }
//                        .padding(.top, 2)
//                        
//                    }
//                    .padding(.top, 0)
//                    .padding()
//                }
//                .navigationBarItems(trailing:
//                                        Button(action: {
//                    // Your button action here
//                    self.showingDetail = false
//                }) {
//                    Image(systemName: "xmark")
//                        .foregroundColor(.black)
//                }
//                )
//            }
//        }
//        
//        
//        
//        
//        
//    }
//    
//    private func shareOnTwitter(article: NewsArticle) {
//        let tweetText = article.headline
//        let tweetUrl = article.url
//        let tweetHashtags = "News" // Add hashtags if needed
//        
//        let twitterUrl = "https://twitter.com/intent/tweet?text=\(tweetText)&url=\(tweetUrl)&hashtags=\(tweetHashtags)"
//        openUrl(twitterUrl)
//    }
//    
//    private func shareOnFacebook(article: NewsArticle) {
//        let facebookUrl = "https://www.facebook.com/sharer/sharer.php?u=\(article.url)"
//        openUrl(facebookUrl)
//    }
//    
//    private func openUrl(_ urlString: String) {
//        if let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") {
//            UIApplication.shared.open(url)
//        }
//    }
//}
//
//
//struct NewsView: View {
//    let articles: [NewsArticle]
//    
//    @State private var showingDetail = false
//    @State private var selectedArticle: NewsArticle?
//    
//    var filteredArticles: [NewsArticle] {
//        Array(articles.filter { $0.isComplete }.prefix(20))
//    }
//    
//    var body: some View {
//        //        Text("hello")
//        //        Text("Articles Count: \(articles.count)")
//        
//        VStack(alignment: .leading, spacing: 10) {
//            Text("News")
//                .font(.title)
//                .bold()
//                .padding(.vertical)
//            
//            ForEach(Array(filteredArticles.enumerated()), id: \.element.id) { (index, article) in
//                VStack(alignment: .leading) {
//                    if index == 0 {
//                        // Special formatting for the first article
//                        articleView(article: article, isFeatured: true)
//                        Divider()
//                    } else {
//                        articleView(article: article, isFeatured: false)
//                    }
//                }
//            }
//        }
//        
//        
//        .sheet(isPresented: $showingDetail) {
//            if let article = selectedArticle {
//                // If selectedArticle is not nil, show the ArticleDetailView
//                
//                ArticleDetailView(article: article, showingDetail: $showingDetail)
//            } 
//            else {
//                // If selectedArticle is nil, show "hello 1"
//                Text("hello 1")
//            }
//            //            ArticleDetailView(article: selectedArticle ?? nil)
//            //                Text("hello 2")
//        }
//        
//    }
//    
//    
//    private func articleView(article: NewsArticle, isFeatured: Bool) -> some View {
//        
//        
//        VStack(alignment: .leading) {
//            if isFeatured {
//                // For the featured article, the image should fit the width of the device
//                if let imageUrl = URL(string: article.image), !article.image.isEmpty {
//                    AsyncImage(url: imageUrl) { image in
//                        image.resizable()
//                    } placeholder: {
//                        ProgressView()
//                    }
//                    .aspectRatio(contentMode: .fit)
//                    .cornerRadius(10)
//                }
//                
//                // Source and time below the image for the featured article
//                HStack {
//                    Text(article.source)
//                        .font(.caption)
//                        .fontWeight(.bold)
//                        .foregroundColor(.secondary)
//                    Text(article.timeAgo)
//                        .font(.caption)
//                        .foregroundColor(.secondary)
//                }
//                .padding([.top, .bottom], 1)
//                
//                // Headline below the source and time for the featured article
//                Text(article.headline)
//                    .font(.callout)
//                    .fontWeight(.semibold)
//                    .foregroundColor(.primary)
//                //                    .padding(.horizontal)
//            } else {
//                // Layout for non-featured articles
//                HStack(alignment: .top) {
//                    VStack(alignment: .leading) {
//                        HStack {
//                            Text(article.source)
//                                .font(.caption)
//                                .fontWeight(.bold)
//                                .foregroundColor(.secondary)
//                            
//                            Text(article.timeAgo)
//                                .font(.caption)
//                                .foregroundColor(.secondary)
//                        }
//                        .padding(.bottom, 1)
//                        
//                        Text(article.headline)
//                            .font(.callout)
//                            .fontWeight(.semibold)
//                            .foregroundColor(.primary)
//                            .lineLimit(3)
//                    }
//                    
//                    Spacer()
//                    
//                    if let imageUrl = URL(string: article.image), !article.image.isEmpty {
//                        AsyncImage(url: imageUrl) { image in
//                            image.resizable()
//                        } placeholder: {
//                            ProgressView()
//                        }
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 100, height: 100)
//                        .clipped()
//                        .cornerRadius(10)
//                    }
//                }
//                .padding(.bottom)
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .contentShape(Rectangle())  // Ensure the tappable area includes the entire HStack
//                .onTapGesture {
//                    // Implement the action when the article is tapped
//                    
//                    print("Article tapped: \(article)")
//                    
//                    self.selectedArticle = article
//                    self.showingDetail = true
//                }
//            }
//            
//            
//        }
//    }
//    
//    
//    
//}
//
//



//#Preview {
//    NewsView()
//}


import SwiftUI

struct ArticleDetailView: View {
    let article: NewsArticle
    var dismissAction: () -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        Text(article.source)
                            .font(.title)
                            .fontWeight(.bold)
                        Text(article.formattedDate)
                            .padding(.vertical, 0)
                            .foregroundColor(.secondary)
                        Divider()
                        
                        Text(article.headline)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.vertical, 0)
                        
                        Text(article.summary)
                            .font(.footnote)
                            .padding(.vertical, 0)
                        
                        HStack{
                            Text("For more details click")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                            Link("here", destination: URL(string: article.url)!)
                                .foregroundColor(.blue)
                                .font(.footnote)
                        }
                        .padding(.vertical, 0)
                        
                        HStack {
                            socialButton(action: { shareOnTwitter(article: article) }, imageName: "twitter_icon")
                            socialButton(action: { shareOnFacebook(article: article) }, imageName: "facebook_icon")
                        }
                        .padding(.top, 2)
                    }
                    .padding()
                }
                .navigationBarItems(trailing: Button(action: {
                    dismissAction()
                }) {
                    Image(systemName: "xmark").foregroundColor(.black)
                })
            }
        }
    }
    
    private func socialButton(action: @escaping () -> Void, imageName: String) -> some View {
        Button(action: action) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 50)
        }
    }

    private func shareOnTwitter(article: NewsArticle) {
        let twitterUrl = "https://twitter.com/intent/tweet?text=\(article.headline)&url=\(article.url)&hashtags=News"
        openUrl(twitterUrl)
    }

    private func shareOnFacebook(article: NewsArticle) {
        let facebookUrl = "https://www.facebook.com/sharer/sharer.php?u=\(article.url)"
        openUrl(facebookUrl)
    }

    private func openUrl(_ urlString: String) {
        if let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") {
            UIApplication.shared.open(url)
        }
    }
}
struct NewsView: View {
    let articles: [NewsArticle]
    
    @State private var selectedArticle: NewsArticle?
    
    var filteredArticles: [NewsArticle] {
        Array(articles.filter { $0.isComplete }.prefix(20))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("News")
                .font(.title)
                .bold()
                .padding(.vertical)
            
            ForEach(Array(filteredArticles.enumerated()), id: \.element.id) { (index, article) in
                VStack(alignment: .leading) {
                    if index == 0 {
                        articleView(article: article, isFeatured: true)
                        Divider()
                    } else {
                        articleView(article: article, isFeatured: false)
                    }
                }
                .onTapGesture {
                    self.selectedArticle = article
                }
            }
        }
        .sheet(item: $selectedArticle, onDismiss: {
            print("Sheet dismissed")
        }) { article in
            ArticleDetailView(article: article, dismissAction: {
                self.selectedArticle = nil
            })
        }
    }

    private func articleView(article: NewsArticle, isFeatured: Bool) -> some View {
            
            
            VStack(alignment: .leading) {
                if isFeatured {
                    // For the featured article, the image should fit the width of the device
                    if let imageUrl = URL(string: article.image), !article.image.isEmpty {
                        AsyncImage(url: imageUrl) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                    }
                    
                    // Source and time below the image for the featured article
                    HStack {
                        Text(article.source)
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.secondary)
                        Text(article.timeAgo)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding([.top, .bottom], 1)
                    
                    // Headline below the source and time for the featured article
                    Text(article.headline)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    //                    .padding(.horizontal)
                } else {
                    // Layout for non-featured articles
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(article.source)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.secondary)
                                
                                Text(article.timeAgo)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.bottom, 1)
                            
                            Text(article.headline)
                                .font(.callout)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                                .lineLimit(3)
                        }
                        
                        Spacer()
                        
                        if let imageUrl = URL(string: article.image), !article.image.isEmpty {
                            AsyncImage(url: imageUrl) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipped()
                            .cornerRadius(10)
                        }
                    }
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .contentShape(Rectangle())  // Ensure the tappable area includes the entire HStack
                    .onTapGesture {
                        // Implement the action when the article is tapped
                        
                        print("Article tapped: \(article)")
                        
                        self.selectedArticle = article
                    }
                }
                
                
            }
        }
        
        
        
    }
