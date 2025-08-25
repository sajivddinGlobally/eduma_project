// To parse this JSON data, do
//
//     final messageListResponse = messageListResponseFromJson(jsonString);

import 'dart:convert';

MessageListResponse messageListResponseFromJson(String str) => MessageListResponse.fromJson(json.decode(str));

String messageListResponseToJson(MessageListResponse data) => json.encode(data.toJson());

class MessageListResponse {
    bool success;
    String message;
    int attachmentId;
    String avatarUrl;
    FileInfo fileInfo;

    MessageListResponse({
        required this.success,
        required this.message,
        required this.attachmentId,
        required this.avatarUrl,
        required this.fileInfo,
    });

    factory MessageListResponse.fromJson(Map<String, dynamic> json) => MessageListResponse(
        success: json["success"],
        message: json["message"],
        attachmentId: json["attachment_id"],
        avatarUrl: json["avatar_url"],
        fileInfo: FileInfo.fromJson(json["file_info"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "attachment_id": attachmentId,
        "avatar_url": avatarUrl,
        "file_info": fileInfo.toJson(),
    };
}

class FileInfo {
    String filename;
    String filesize;
    String filetype;

    FileInfo({
        required this.filename,
        required this.filesize,
        required this.filetype,
    });

    factory FileInfo.fromJson(Map<String, dynamic> json) => FileInfo(
        filename: json["filename"],
        filesize: json["filesize"],
        filetype: json["filetype"],
    );

    Map<String, dynamic> toJson() => {
        "filename": filename,
        "filesize": filesize,
        "filetype": filetype,
    };
}
