import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home/data/controller/ticketDetails.provider.dart';

class TicketDetailsPage extends ConsumerStatefulWidget {
  final String tiketId;
  const TicketDetailsPage({Key? key, required this.tiketId}) : super(key: key);

  @override
  ConsumerState<TicketDetailsPage> createState() => _TicketDetailsPageState();
}

class _TicketDetailsPageState extends ConsumerState<TicketDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final ticketDetail = ref.watch(ticketDetailsProvider(widget.tiketId));
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 243, 235),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 232, 243, 235),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  'Ticket Details',
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: ticketDetail.when(
        data: (snap) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ticket ID: ${snap.ticketDetails[0].ticketId}',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          snap.ticketDetails[0].subject,
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 68, 128, 106),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            if (snap.ticketDetails[0].companyPhoto.isNotEmpty)
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                  snap.ticketDetails[0].companyPhoto,
                                ),
                              ),
                            const SizedBox(width: 8),
                            if (snap.ticketDetails[0].memberPhoto.isNotEmpty)
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                  snap.ticketDetails[0].memberPhoto,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: snap.ticketDetails[0].chatList.length,
                    itemBuilder: (context, index) {
                      final chat = snap.ticketDetails[0].chatList[index];
                      final isUser = chat.replyBy.toLowerCase().contains(
                        'user',
                      );
                      return Align(
                        alignment:
                            isUser
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color:
                                isUser
                                    ? const Color.fromARGB(255, 68, 128, 106)
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment:
                                isUser
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                            children: [
                              Text(
                                chat.description,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: isUser ? Colors.white : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                chat.dateSupport,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: isUser ? Colors.white70 : Colors.grey,
                                ),
                              ),
                              Text(
                                'By: ${chat.replyBy}',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: isUser ? Colors.white70 : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
        error: (err, stack) {
          return Center(
            child: Text(
              'Error: $err',
              style: GoogleFonts.inter(color: Colors.red, fontSize: 16),
            ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
      ),
      bottomSheet: Container(
        color: const Color.fromARGB(255, 232, 243, 235),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Type your message...',
              hintStyle: GoogleFonts.inter(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              fillColor: Colors.white,
              filled: true,
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.send,
                  color: Color.fromARGB(255, 68, 128, 106),
                ),
                onPressed: () {
                  // TODO: Implement send message functionality
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
