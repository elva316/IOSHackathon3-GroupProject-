import GoogleAPIClientForREST
import GoogleSignIn
import UIKit
import WebKit

class ViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    // If modifying these scopes, delete your previously saved credentials by
    // resetting the iOS simulator or uninstall the app.
    private let scopes = [kGTLRAuthScopeYouTubeReadonly]
    
    private let service = GTLRYouTubeService()
//    let signInButton = GIDSignInButton()
//    let output = UITextView()
    
    var apiKey = "AIzaSyDWjAu0-oQsd-yq5RzhJru48PYGJbYIiu0"
    
    var desiredChannelsArray = ["Apple", "Google", "Microsoft"]
    
    var channelIndex = 0
    
    var channelsDataArray: Array<Dictionary<NSObject, AnyObject>> = []
    
    var likesPlaylist = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure Google Sign-in.
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().scopes = scopes
        GIDSignIn.sharedInstance().signInSilently()
        
        // Add the sign-in button.
//        view.addSubview(signInButton)
        
//        // Add a UITextView to display output.
//        output.frame = view.bounds
//        output.isEditable = false
//        output.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
//        output.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//        output.isHidden = true
//        view.addSubview(output);
        
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error! ) {
        if let error = error {
            showAlert(title: "Authentication Error", message: error.localizedDescription)
            self.service.authorizer = nil
        } else {
            self.signInButton.isHidden = true
//            self.output.isHidden = false
            self.service.authorizer = user.authentication.fetcherAuthorizer()
            fetchChannelResource()
            
            
//            performSegue(withIdentifier: "toWatchLater", sender: self)
        }
    }
    
    
    // List up to 10 files in Drive
    func fetchChannelResource() {
        let query = GTLRYouTubeQuery_ChannelsList.query(withPart: "snippet,contentDetails,statistics")
//        query.identifier = "UC_x5XG1OV2P6uZZ5FSM9Ttw"
        // To retrieve data for the current user's channel, comment out the previous
        // line (query.identifier ...) and uncomment the next line (query.mine ...)
         query.mine = true
//        print("This is the query:  \(query)")
        service.executeQuery(query,
                             delegate: self,
                             didFinish: #selector(displayResultWithTicket(ticket:finishedWithObject:error:)))
    }
    
    // Process the response and display output
    @objc func displayResultWithTicket(
        ticket: GTLRServiceTicket,
        finishedWithObject response : GTLRYouTube_ChannelListResponse,
        error : NSError?) {
        
//        print("This is the response: \(response)")
        
        if let error = error {
            showAlert(title: "Error", message: error.localizedDescription)
            return
        }
        
        var outputText = ""
        if let channels = response.items, !channels.isEmpty {
            print("This is the response: \(response)")

            let channel = response.items![0]
            
            print("this is the channel \(channel)")
            
            let relatedPlaylists = channel.contentDetails?.relatedPlaylists
            let snippetData = channel.snippet!
            print("this is the snippet Data: \(snippetData)")
            
            
            likesPlaylist = (relatedPlaylists?.likes)!
            
            print("Likes playlist = \(likesPlaylist)")
            
            print("This is the related playlists:  \(relatedPlaylists?.likes)")
            
//            let watchLater = relatedPlaylists!.watchLater
//            print("Watch Later: \(String(describing: watchLater))")
            
            let title = channel.snippet!.title
            let description = channel.snippet?.descriptionProperty
            let viewCount = channel.statistics?.viewCount
//            let playlist = channel?.allPlaylists
            
            
            outputText += "title: \(title!)\n"
            outputText += "description: \(description!)\n"
            outputText += "view count: \(viewCount!)\n"
        }
//        output.text = outputText

        performSegue(withIdentifier: "toWatchLater", sender: self)
    }
    
    
    
    // Helper for showing an alert
    func showAlert(title : String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.alert
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.default,
            handler: nil
        )
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    
    
//    func getVideo(useChannelIDParam: Bool){
//        var urlString: String!
//        if !useChannelIDParam {
//            urlString = "https://www.googleapis.com/youtube/v3/channels?part=contentDetails,snippet&forUsername=\(desiredChannelsArray[channelIndex])&key=\(apiKey)"
//        }
//        else {
//            print("Oops")
//        }
//
//        let targetURL = NSURL(string: urlString)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let videoController = segue.destination as! VideoController

        let myLikes = likesPlaylist

        videoController.likes = myLikes

    }
    
    @IBAction func logout(_ sender: UIStoryboardSegue){
        
        GIDSignIn.sharedInstance().signOut()
        self.signInButton.isHidden = false
        GIDSignIn.sharedInstance().disconnect()
        dismiss(animated: true, completion: nil)
        //        if sender.source is AddItemViewController{
//        let controller = sender.source as! AddItemViewController  //force cast
//        let item = NSEntityDescription.insertNewObject(forEntityName: "ToDoList", into: context) as! ToDoList
        
//        item.title = controller.titleField.text
//        item.detail = controller.detailField.text
//        item.date = controller.datePickerField.date
//        item.completed = false
        //            let dateFormatter = DateFormatter()
        //            dateFormatter.dateFormat = "MMM dd, YYYY"
        //            let toDoListItem.date = dateFormatter.string(from: controller.datePickerField.date)
        
        
//        saveContext()
//
//        items.append(item)
//        tableView.reloadData()
        
        //                print("\(TableViewCell.title) is the title, \(TableViewCell.detail) is the detail and \(TableViewCell.date) is the date")
        
        
    }
    
}
