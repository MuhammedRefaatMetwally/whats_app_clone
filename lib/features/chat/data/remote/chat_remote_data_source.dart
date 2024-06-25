


import '../../domain/entities/chat_entity.dart';
import '../../domain/entities/message_entity.dart';
import '../models/chat_model.dart';

abstract class ChatRemoteDataSource {

  Future<void> sendMessage(ChatEntity chat, MessageEntity message);
  Stream<List<ChatModel>> getMyChat(ChatEntity chat);
  Stream<List<MessageEntity>> getMessages(MessageEntity message);
  Future<void> deleteMessage(MessageEntity message);
  Future<void> seenMessageUpdate(MessageEntity message);

  Future<void> deleteChat(ChatEntity chat);
}