/****************************
Declaring all common types used in 2PC
*****************************/

//operations
enum AccountOperations {
    ADD_AMOUNT,
    SUBS_AMOUNT
}

//type of operation
type OperationType = (
    op: AccountOperations, 
    val: int
);

//Defines the transaction type 
type TransactionType =
(
    source: ClientInterface,
    op1: OperationType,
    op2: OperationType
);

//Account status ac: acount id and val: value in the account.
type ParticipantStatusType = 
(
    part: int,
    val: int
);

// Interface type declarations
type ClientInterface((CoorClientInterface, int)) = { eRespPartStatus, eTransactionFailed, eTransactionSuccess};
type CoorClientInterface() = { eTransaction, eReadPartStatus };
type CoorParticipantInterface() = { ePrepared, eNotPrepared, eStatusResp };
type ParticipantInterface((CoorParticipantInterface, int)) = { ePrepare, eCommit, eAbort, eStatusQuery };

/*************************************
Declaring all the events used in 2PC
*************************************/

//Events used for interaction between client and coordinator
event eTransaction : TransactionType;
event eTransactionFailed;
event eTransactionSuccess;
event eReadPartStatus: (source: ClientInterface, part:int);
event eRespPartStatus: ParticipantStatusType;

//Events used for interaction between coordinator and participants
event ePrepare : (tid: int, op: OperationType);
event ePrepared : (tid: int);
event eNotPrepared : (tid: int);
event eCommit : (tid: int);
event eAbort : (tid: int);
event eStatusQuery;
event eStatusResp : ParticipantStatusType;


//events used by specification.
event eParticipantCommitted: (part: int, tid:int);
event eParticipantAborted: (part: int, tid: int);