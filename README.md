## Step-by-Step Instructions for Self-Hosting Impostor

NOTE: For Debian based distributions, just run `sudo wget https://raw.githubusercontent.com/DarrenAlex/Impostor/master/install.sh | chmod a+x install.sh | sudo ./install.sh` to automatically run the bot with pm2. Alternatively, follow the steps below:

0. Install Node.js + npm, .NET Core, PostgreSQL, and any others needed.
1. Clone the repository recursively (`git clone --recursive https://github.com/molenzwiebel/Impostor`)
2. Navigate to `.env.template`, duplicate the file, rename to `.env`, and fill in the blanks. The result will look something like this:
  ```
  DISCORD_TOKEN=<your token here>
  AU_CLIENT_DIR=../client/bin/Debug/netcoreapp3.1
  DATABASE_URL=postgresql://postgres:<your password here>@localhost:5432/postgres
  BOT_INVITE_LINK=https://discord.com/api/oauth2/authorize?client_id=<your bot id here>&permissions=0&scope=bot
  ```
3. Update the code associated with the emojis in `bot/src/constants.ts` (add the ID, name, etc)
4. Navigate to `/bot` in your cmd/PowerShell/terminal
5. Run `npm install` to install dependencies.
6. Run `./node_modules/.bin/tsc` to compile TypeScript to JavaScript.
7. Run `node dist/index.js` ([pm2](https://pm2.keymetrics.io/) is recommended to keep it running for long periods)
8. Change directory to `/client`
9. Open cmd/PowerShell/terminal and run `dotnet build`
