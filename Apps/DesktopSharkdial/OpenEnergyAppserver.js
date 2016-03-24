//OpenEnergy Appserver
var AppClient = function (url) {
  this.io = io.connect(url);
  this.connected = False;
  this.subscribers = {};
  this.retention = {};
  
  console.log('AppServer instantiated');


  this.io.on('connect', function () {
    console.log("CONNECTED!");

    //Subscribe
    for (var topic in this.subscribers) {
      // do something with key
      socket.emit('subscribe',{"topic":topic});
    }

    //Handle incomming MQTT messages
    socket.on('mqtt', function (msg) {

      //Any subscribers?

      for (var topic in this.subscribers) {

        //Match topics hand # sign
        
        //If topic end with # and msg.topic contains topic -1 char then call handlers
        if (topic.slice(-1) == "#" ) {
            if (msg.topic.indexOf(topic.slice(0,-1)) == 0) {
              var handlers = this.subscribers[topic];

              var arrayLength = handlers.lenght;

              for (var i = 0; i < arrayLength; i++) {
                handlers[i](msg.topic,msg.payload);
              }
            }

        } 
        //If topic does not contain # and is exact match with msg.topic call all handlers.
        else if (topic == msg.topic) {

          var handlers = this.subscribers[topic];
          var arrayLength = handlers.lenght;

          for (var i = 0; i < arrayLength; i++) {
            handlers[i](msg.topic,msg.payload);
          }


        }

        

      }

      //Update retention
      this.retention[msg.topic] = msg.payload;

    });



  });
  
};

//Add a function that handles incomming MQTT data
AppServer.prototype.subscribe = function (topic, handler) {

    //Check if topic exists
    if !(topic in appserver.subscribers) {
			//If not add topic and handler to subscribers list. 
      this.subscribers[topic] = [handler];
      //Subscribe to data. 
      if (self.connected) {
      	this.io.emit('subscribe',{"topic":topic});
      }
    }
    else {
    	// Otherwise just add handler to subscriber list
    	this.subscribers[topic].push(handler);
      
      //And send old data if any.
      if (topic in this.retention) {
        handler(topic, this.retention[topic]);
      }

    }
    
};

//Add a connection to set an text element to incomming MQTT data. 
AppServer.prototype.bind_textdata_to_id = function (topic, id) {

  this.subscribe(topic,function(topic,payload){

    // Only if string. 
    if (typeof payload === 'string' || payload instanceof String) {
      document.getElementById(id).innerHTML = payload;
    }

  });



};



//Create instance
appserver = AppClient("http://op-en.se:5000");

//Example 
//appsever.bind_textdata_to_id("test/hej","mydiv")
