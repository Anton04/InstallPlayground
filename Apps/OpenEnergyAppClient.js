
//OpenEnergy Appserver
var AppClient = function (url) {
  this.io = io.connect(url);
  this.io.appclient = this;
  this.connected = false;
  this.subscribers = {};
  this.retention = {};
  
  console.log('AppServer instantiated');


  //Handle incomming MQTT messages
  this.io.on('mqtt', function (msg) {

    console.log(msg.topic); 

    //Any subscribers?
    for (var topic in this.appclient.subscribers) {

      //Match topics hand # sign
      
      //If topic end with # and msg.topic contains topic -1 char then call handlers
      if (topic.slice(-1) == "#" ) {
          if (msg.topic.indexOf(topic.slice(0,-1)) == 0) {
            var handlers = this.appclient.subscribers[topic];

            var arrayLength = handlers.lenght;

            for (var i = 0; i < arrayLength; i++) {
              handlers[i](msg.topic,msg.payload);
            }
          }

      } 
      //If topic does not contain # and is exact match with msg.topic call all handlers.
      else if (topic == msg.topic) {

        var handlers = this.appclient.subscribers[topic];

        for (var i = 0; i < handlers.length; i++) {
          handlers[i](msg.topic,msg.payload);
        }
      }      
    }


    //Update retention
    this.appclient.retention[msg.topic] = msg.payload;

  });

  //Handle connection.
  this.io.on('connect', function () {
    console.log("CONNECTED!");
    this.connected = true;




    
    for (var topic in this.appclient.subscribers) {
      console.log("Subscribing to " + topic);
      this.emit('subscribe',{"topic":topic});
    }

    //Subscribe

  });
  
  //return this;
};

//Add a function that handles incomming MQTT data
AppClient.prototype.subscribe = function (topic, handler) {

    //Check if topic exists
    if (! (topic in this.subscribers)) {
			//If not add topic and handler to subscribers list. 
      this.subscribers[topic] = [handler];
      //Subscribe to data. 
      if (self.connected) {
        console.log("Subscribing to " + topic);
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
//Topic is the mqtt topic
//dom_id is the id of an html element. 
//If mqtt data is Json the optional subproperty can be used to get a specific property of the data. 
AppClient.prototype.bind_topic_to_html = function (topic, dom_id , subproperty = null) {

  this.subscribe(topic,function(topic,payload){
    if (subproperty != null) {
        payload = JSON.parse(payload);

        console.log(payload);

        var data = payload[subproperty];

        console.log(data);

    }
    else {

        var data = payload;
      
    }

    // Only if string. 
    document.getElementById(dom_id).innerHTML = "" + data;
    

  });



};


AppClient.prototype.bind_topic_to_style = function (topic, dom_id ,style, subproperty = null) {

  this.subscribe(topic,function(topic,payload){
    if (subproperty != null) {
        payload = JSON.parse(payload);

        console.log(payload);

        var data = payload[subproperty];

        console.log(data);

    }
    else {

        var data = payload;
      
    }

    // Only if string. 
    document.getElementById(dom_id)["style"][style] = "" + data;
    

  });



};






