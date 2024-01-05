const express = require('express')
const mongoose = require('mongoose')
var app = express()
var Data = require('./noteSchema')

mongoose.connect('mongodb://localhost/newDB')
mongoose.connection.once("open", () => {
    console.log('connected to DB!')
}).on("error", (error) => {
    console.log("Failed to connect" + error)
})

//POST Request

app.post("/create",(req,res) => {
    var note = new Data({
        title: req.get("title"),
        date: req.get("date"),
        note: req.get("note")
    })
    note.save().then(() => {
        if (note.isNew == false){
            console.log("Saved Data!")
            res.send("Saved data!")
        }
        else {
        console.log("Failed to save data!")
        }

})
})


//Fetch Request

app.get('/fetch',(req,res) => {
    Data.find({}).then((DBitems) => {
        res.send(DBitems)
    })
})

//DELETE A NOTE

app.post('/delete', async (req,res) => {
  try {
    await  Data.findOneAndDelete({
        _id: req.get("id")
    })
    res.send("Deleted!!")
}
catch(error){
   
        console.log("Failed" + error)
    
}
    
})


//Updating Note

app.post('/update', async (req,res) => {
    try {
        await  Data.findOneAndUpdate({
            _id: req.get("id")
        },{
           note: req.get("note"),
           title: req.get("title"),
           date: req.get("date")
        })
        res.send("Updated!!")
    }
    catch(error){
       
            console.log("Failed to update" + error)
        
    }

})
var server = app.listen(8081,"192.168.1.5",() => {
    console.log("Server is running!")
})