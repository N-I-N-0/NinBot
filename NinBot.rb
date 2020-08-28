require 'open-uri'
require 'socket'
require 'openssl'
require 'discordrb'
require 'json'
require 'uri'
require 'date'
require 'rss'

class Numeric
    def minutes; (self*60); end
    def hours; (self*3600); end
    def days; (self*86400); end
    def weeks; (self*604800); end
    alias_method :minute, :minutes
    alias_method :hour, :hours
    alias_method :day, :days
    alias_method :week, :weeks
end

module Discordrb
    class Bot
        def send_embed(channel, message = '', embed = nil)
            embed ||= Discordrb::Webhooks::Embed.new
            yield(embed) if block_given?
            send_message(channel, message, false, embed)
        end
    end
end


$prefix = '::'
token = File.read("/home/pi/Desktop/NinBot/token")
$bot = Discordrb::Commands::CommandBot.new token: token, prefix: $prefix


def reaction_add_loop
    event = nil
    loop do
        event = $bot.add_await!(Discordrb::Events::ReactionAddEvent)
        if event.message.id == 748921232878993490
            case event.emoji.name
            when "1️⃣"
                role = event.server.role(713523176566554664)
            when "2️⃣"
                role = event.server.role(732981603604889712)
            when "3️⃣"
                role = event.server.role(732982013849763911)
            when "4️⃣"
                role = event.server.role(732982181491769445)
            when "5️⃣"
                role = event.server.role(732982439030292540)
            when "6️⃣"
                role = event.server.role(732983241472081940)
            when "7️⃣"
                role = event.server.role(741236836684529664)
            when "8️⃣"
                role = event.server.role(748603339264229507)
            when "9️⃣"
                role = event.server.role(732981108546732103)
            else
                role = nil
            end
            if not role == nil
                pp event.user.add_role(role)
            end
        end
    rescue => error
        pp error.methods
        reaction_add_loop
    end
end

def reaction_remove_loop
    event = nil
    loop do
        event = $bot.add_await!(Discordrb::Events::ReactionRemoveEvent)
        if event.message.id == 748921232878993490
            case event.emoji.name
            when "1️⃣"
                role = event.server.role(713523176566554664)
            when "2️⃣"
                role = event.server.role(732981603604889712)
            when "3️⃣"
                role = event.server.role(732982013849763911)
            when "4️⃣"
                role = event.server.role(732982181491769445)
            when "5️⃣"
                role = event.server.role(732982439030292540)
            when "6️⃣"
                role = event.server.role(732983241472081940)
            when "7️⃣"
                role = event.server.role(741236836684529664)
            when "8️⃣"
                role = event.server.role(748603339264229507)
            when "9️⃣"
                role = event.server.role(732981108546732103)
            else
                role = nil
            end
            if not role == nil
                event.user.remove_role(role)
            end
        end
    rescue => error
        pp error.backtrace
        reaction_remove_loop
    end
end

$bot.command(:roles, help_available: false) do |event, *code|
    break unless event.user.id == 308514332566880256
    response = "Roles\n"
    event.server.roles.each do |role|
        response += "#{role.name}: #{role.id}\n"
    end
    event.user.pm response
end

$bot.command(:channels, help_available: false) do |event, *code|
    break unless event.user.id == 308514332566880256
    response = "Channels:\n"
    event.server.channels.each do |channel|
        response += "#{channel.name}: #{channel.id}\n" if !channel.category?
        puts channel
    end
    event.user.pm response
end

$bot.command(:categories, help_available: false) do |event, *code|
    break unless event.user.id == 308514332566880256
    response = "Categories\n"
    event.server.channels.each do |channel|
        response += "#{channel.name}: #{channel.id}\n" if channel.category?
        puts channel
    end
    event.user.pm response
end

$bot.command(:emojis, help_available: false) do |event, *code|
    break unless event.user.id == 308514332566880256
    response = "Emojis\n"
    event.server.emoji.each do |emoji|
        response += emoji.to_s + "\n"
    end
    event.user.pm response
end

$bot.command(:ip, help_available: false) do |event, *code|
    break unless event.user.id == 308514332566880256
    event.user.pm open('https://api.ipify.org').read
end
                                                          
$bot.command(:invite, help_available: false) do |event, *code|
    break unless event.user.id == 308514332566880256
    event.user.pm event.channel.make_invite.url
end

                                                          
def send_embed(channel, title: nil, url: nil, image: nil, color: nil, author_name: nil, author_url: nil, author_icon_url: nil, description: nil, thumbnail_url: nil, footer_text: nil, footer_icon_url: nil, fields: Array.new)
    channel.send_embed do |embed|
        embed.title = title
        embed.url = url
        embed.image = Discordrb::Webhooks::EmbedImage.new(url: image)
        embed.color = color
        embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: author_name, url: author_url, icon_url: author_icon_url)
        embed.description = description
        embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: thumbnail_url)
        embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: footer_text, icon_url: footer_icon_url)
        fields.each do |field|
            embed.add_field(name: field[0], value: field[1], inline: field[2])
        end
    end
end


def send_roles_embed
    $bot.send_embed(714863150717075589) do |embed|
        embed.title = "Roles"
        embed.color = 0x00FFFF
        embed.description = "Add/remove reactions to add/remove roles!"
        fields = [["NSMBWii", "1️⃣", true], ["Graphics Designer", "2️⃣", true], ["Level Designer", "3️⃣", true], ["Tool Development", "4️⃣", true], ["Map Creator", "5️⃣", true], ["3D Modeler", "6️⃣", true], ["Music", "7️⃣", true], ["iOS Jailbreaking", "8️⃣", true], ["Programmer", "9️⃣", true]]
        fields.each do |field|
            embed.add_field(name: field[0], value: field[1], inline: field[2])
        end
    end
end
                                                          
$bot.command(:eval, help_available: false) do |event, *code|
    break unless event.user.id == 308514332566880256
    begin
        eval code.join(' ')
    rescue StandardError
        'An error occurred 😞'
    end
end
                                                          
def set_status(bot, status = 'online')
    case status
    when 'online'
        bot.online
    when 'dnd'
        bot.dnd
    when 'invisible'
        bot.invisible
    when 'idle'
        bot.idle
    end
end

$bot.command(:stream, help_available: false) do |event, *code|
    break unless event.user.id == 308514332566880256
    $bot.stream(code.join(' '), '')
    set_status($bot, 'invisible')
    set_status($bot)
    break
end

$bot.command(:rename, help_available: false) do |event, *code|
    break unless event.user.id == 308514332566880256
    event.channel.name = code.join(' ')
    break
end


$bot.run(true)
pp $bot.servers

$bot.stream('n-i-n-0.github.io | Nin0#2257', 'https://n-i-n-0.github.io/')

set_status($bot, 'online')

reaction_add_thread_1 = Thread.new {reaction_add_loop}
reaction_add_thread_2 = Thread.new {reaction_add_loop}
reaction_add_thread_3 = Thread.new {reaction_add_loop}
reaction_remove_thread_1 = Thread.new {reaction_remove_loop}
reaction_remove_thread_2 = Thread.new {reaction_remove_loop}
reaction_remove_thread_3 = Thread.new {reaction_remove_loop}


#event.channel.start_typing => 5 sec.


$bot.join
