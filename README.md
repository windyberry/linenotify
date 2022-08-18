# linenotify
How to send LINE notification to mobile via a simple ruby code

1. Create/Choose LINE group for receiving LINE notification by script

2. Go to LINE notify website and log in
https://notify-bot.line.me/en/

3. Go to "My Pages"

4. Generate access token (For developers)
   - Enter name for notification speaker
   - Select LINE group (from 1)

5. Implement code for notification
   - document (Topic: Notification) https://notify-bot.line.me/doc/en/

6. Go to selected LINE group and invite LINE Notify into that group

7. Copy access token put in code and run in terminal with this command
   $python linenoti.py   
