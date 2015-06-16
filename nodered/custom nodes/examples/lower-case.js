module.exports = function(RED) {

	//The node itself is defined by a function, 
	//LowerCaseNode that gets called whenever a new instance 
	//of the node is created.
    function LowerCaseNode(config) {
        RED.nodes.createNode(this,config);
        var node = this;
        this.on('input', function(msg) {
            msg.payload = msg.payload.toLowerCase();
            node.send(msg);
        });
    }
    //The function calls the RED.nodes.createNode function to 
    //initialise the features shared by all nodes.
    //After that, the node-specific code lives
    RED.nodes.registerType("lower-case",LowerCaseNode);
}