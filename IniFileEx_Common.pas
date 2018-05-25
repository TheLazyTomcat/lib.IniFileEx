unit IniFileEx_Common;

{$INCLUDE '.\IniFileEx_defs.inc'}

interface

uses
  SysUtils, Classes,
  AuxTypes, CRC32;

{===============================================================================
    String types
===============================================================================}
type
  TIFXString = UnicodeString;
  TIFXChar   = UnicodeChar;       PIFXChar = ^TIFXChar;

  TIFXHashedString = record
    Str:  TIFXString;
    Hash: TCRC32;
  end;

{===============================================================================
    Value-bound types and constants
===============================================================================}
type
  TIFXValueEncoding = (iveBase2,iveBase64,iveBase85,iveHexadecimal,iveNumber,iveDefault);

const
  IFX_VALENC_BASE2   = 0;
  IFX_VALENC_BASE64  = 1;
  IFX_VALENC_BASE85  = 2;
  IFX_VALENC_HEXADEC = 3;
  IFX_VALENC_NUMBER  = 4;
  IFX_VALENC_DEFAULT = 5;

type
  TIFXValueState = (ivsReady,ivsNeedsEncode,ivsNeedsDecode,ivsUndefined);

  TIFXValueType = (ivtUndecided,ivtBool,ivtInt8,ivtUInt8,ivtInt16,ivtUInt16,
                   ivtInt32,ivtUInt32,ivtInt64,ivtUInt64,ivtFloat32,ivtFloat64,
                   ivtDate,ivtTime,ivtDateTime,ivtString,ivtBinary);

const
  IFX_VALTYPE_UNDECIDED = Byte(-1);
  IFX_VALTYPE_BOOL      = 0;
  IFX_VALTYPE_INT8      = 1;
  IFX_VALTYPE_UINT8     = 2;
  IFX_VALTYPE_INT16     = 3;
  IFX_VALTYPE_UINT16    = 4;
  IFX_VALTYPE_INT32     = 5;
  IFX_VALTYPE_UINT32    = 6;
  IFX_VALTYPE_INT64     = 7;
  IFX_VALTYPE_UINT64    = 8;
  IFX_VALTYPE_FLOAT32   = 9;
  IFX_VALTYPE_FLOAT64   = 10;
  IFX_VALTYPE_DATE      = 11;
  IFX_VALTYPE_TIME      = 12;
  IFX_VALTYPE_DATETIME  = 13;
  IFX_VALTYPE_STRING    = 14;
  IFX_VALTYPE_BINARY    = 15;

{===============================================================================
    Value data structure
===============================================================================}
type
  TIFXValueData = record
    StringValue:  TIFXString;
    case ValueType: TIFXValueType of
      ivtUndecided: ();
      ivtBool:      (BoolValue:         Boolean);
      ivtInt8:      (Int8Value:         Int8);
      ivtUInt8:     (UInt8Value:        UInt8);
      ivtInt16:     (Int16Value:        Int16);
      ivtUInt16:    (UInt16Value:       UInt16);
      ivtInt32:     (Int32Value:        Int32);
      ivtUInt32:    (UInt32Value:       UInt32);
      ivtInt64:     (Int64Value:        Int64);
      ivtUInt64:    (UInt64Value:       UInt64);
      ivtFloat32:   (Float32Value:      Float32);
      ivtFloat64:   (Float64Value:      Float64);
      ivtDate:      (DateValue:         TDateTime);
      ivtTime:      (TimeValue:         TDateTime);
      ivtDateTime:  (DateTimeValue:     TDateTime);
      ivtBinary:    (BinaryValuePtr:    Pointer;
                     BinaryValueSize:   TMemSize;
                     BinaryValueOwned:  Boolean);
      ivtString:    (); // stored in field StringValue
  end;
  PIFXValueData = ^TIFXValueData;

{===============================================================================
    INI formatting and other settings
===============================================================================}
type
  // options for textual ini
  TIFXTextIniSettings = record
    EscapeChar:         TIFXChar;
    QuoteChar:          TIFXChar;
    NumericChar:        TIFXChar;
    ForceQuote:         Boolean;
    CommentChar:        TIFXChar;
    SectionStartChar:   TIFXChar;
    SectionEndChar:     TIFXChar;
    ValueDelimChar:     TIFXChar;
    WhiteSpaceChar:     TIFXChar;
    KeyWhiteSpace:      Boolean;
    ValueWhiteSpace:    Boolean;
    ValueWrapLength:    Integer;
    LineBreak:          TIFXString;
    WriteByteOrderMask: Boolean;
  end;

  TIFXDuplicityBehavior = (idbDrop,idbReplace,idbRenameOld,idbRenameNew);

  TIFXWorkingStyle = (iwsStandalone,iwsOnStream,iwsOnFile);

  TIFXSettings = record
    FormatSettings:         TFormatSettings;
    TextIniSettings:        TIFXTextIniSettings;
    FullNameEval:           Boolean;
    ReadOnly:               Boolean;
    DuplicityBehavior:      TIFXDuplicityBehavior;
    DuplicityRenameOldStr:  TIFXString;
    DuplicityRenameNewStr:  TIFXString;
    WorkingStyle:           TIFXWorkingStyle;
    WorkingStream:          TStream;
    WorkingFile:            String;
  end;
  PIFXSettings = ^TIFXSettings;

{===============================================================================
    Other types and constants
===============================================================================}
type
  TIFXNodeIndices = record
    SectionIndex: Integer;
    KeyIndex:     Integer;
  end;

const
  IFX_INVALID_NODE_INDICES: TIFXNodeIndices = (SectionIndex: -1; KeyIndex: -1);

implementation

end.
