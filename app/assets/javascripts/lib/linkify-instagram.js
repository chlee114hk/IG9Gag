// modify version from https://github.com/abh1nav/linkify-instagram
// Linkifies hashtags
// console.log(linkify('Hello #World'));
// Hello <a href="https://www.instagram.com/explore/tags/world" target="_blank">#World</a>

// The hastag template is customizable
// console.log(linkify('Hello #World', '<a href="https://www.instagram.com/explore/tags/{hashtag}">#{hashtag}</a>'));
// Hello <a href="https://www.instagram.com/explore/tags/world">#World</a>

// Linkifies usernames
// console.log(linkify('Hello @hodor'));
// Hello <a href="https://www.instagram.com/hodor" target="_blank">@hodor</a>

// The template is customizable
// console.log(linkify('Hello @hodor', undefined, '<a href="https://www.instagram.com/{username}">@{username}</a>'));
// Hello <a href="https://www.instagram.com/hodor">@hodor</a>

(function(window) {

    if (!Array.prototype.forEach) {
        Array.prototype.forEach = function (fn, arg) {
            var arr = this;
            var len = arr.length;
            var thisArg = arg ? arg : undefined;
            var i;
            for (i = 0; i < len; i += 1) {
                if (arr.hasOwnProperty(i)) {
                    fn.call(thisArg, arr[i], i, arr);
                }
            }
            return undefined;
        };
    }

    var hashtag = function(hashtag, template) {
        if (typeof hashtag !== 'string') {
            throw new Error('hashtag must be a string');
            return;
        }
        if (template && typeof template !== 'string') {
            throw new Error('template must be a string');
            return;
        }

        var defaultTmpl = '<a href="https://www.instagram.com/explore/tags/{hashtag}" target="_blank">#{hashtag}</a>';
        var tag = hashtag.replace(/#/ig, '');
        var tmpl;

        if (!template) {
            tmpl = defaultTmpl;
        } else {
            tmpl = template;
        }

        if (tmpl.indexOf('{hashtag}') === -1) {
            throw new Error('template must contain the {hashtag} token');
            return;
        }

        return tmpl.replace(/{hashtag}/g, tag);
    };

    var htmlEscape = function(text) {
        var esc = [
            {
                key: '&',
                val: '&amp;'
            },
            {
                key: '>',
                val: '&gt;'
            },
            {
                key: '<',
                val: '&lt;'
            }
        ];

        esc.forEach(function(escapeSequence) {
            text = text.replace(escapeSequence.key, escapeSequence.val);
        });
        return text;
    };

    var username = function(username, template) {
        if (typeof username !== 'string') {
            throw new Error('username must be a string');
            return;
        }
        if (template && typeof template !== 'string') {
            throw new Error('template must be a string');
            return;
        }

        var defaultTmpl = '<a href="https://www.instagram.com/{username}" target="_blank">@{username}</a>';
        var uname = username.replace(/@/ig, '');
        var tmpl = template ? template : defaultTmpl;

        if (tmpl.indexOf('{username}') === -1) {
            throw new Error('template must contain the {username} token');
            return;
        }

        return tmpl.replace(/{username}/g, uname);
    };

    linkify = function(text, htTemplate, unTemplate) {
        // Escape HTML characters
        text = htmlEscape(text);

        // Hashtags
        var hashtags = text.match(/[#]\w+/g);
        if (hashtags) {
            hashtags.forEach(function(ht) {
                text = text.replace(ht, hashtag(ht, htTemplate));
            });
        };

        // Usernames
        var usernames = text.match(/[@]\w+/g);
        if (usernames) {
            usernames.forEach(function(un) {
                text = text.replace(un, username(un, unTemplate));
            });
        }

        return text;
    };

    window.linkify = linkify;

}(('undefined' !== typeof window) ? window : {}));