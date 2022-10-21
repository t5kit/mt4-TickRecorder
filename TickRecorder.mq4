//+------------------------------------------------------------------+
//|                                                 TickRecorder.mq4 |
//|                                                                  |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright ""
#property link      ""
#property version   "1.00"
#property strict

int FileHandle;
string FileDate;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit() {
//---
    newFile();
//---
    return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {
//---
    if (FileHandle != INVALID_HANDLE) {
        FileClose(FileHandle);
    }
}
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick() {
//---
    if (FileDate != TimeToString(Time[0], TIME_DATE)) {
        newFile();
    }
    
    string time = TimeToString(TimeCurrent(), TIME_DATE | TIME_MINUTES | TIME_SECONDS);
    string ask = DoubleToString(Ask, Digits);
    string bid = DoubleToString(Bid, Digits);
    FileWrite(FileHandle, time + "," + ask + "," + bid);
}

void newFile() {
    if (FileHandle != INVALID_HANDLE) {
        FileClose(FileHandle);
    }
    FileDate = TimeToString(TimeCurrent(), TIME_DATE);
    string fileName = Symbol() + "_" + FileDate + ".csv";
    FileHandle = FileOpen(fileName, FILE_WRITE | FILE_CSV); 
}
//+------------------------------------------------------------------+
