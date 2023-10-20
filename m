Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3354208C1
	for <linux-hardening@vger.kernel.org>; Fri, 20 Oct 2023 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X9zutY/W"
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C595D5B
	for <linux-hardening@vger.kernel.org>; Fri, 20 Oct 2023 10:56:51 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53fc7c67a41so2124081a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 20 Oct 2023 10:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697824610; x=1698429410; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F4wi3imaHP2uII6OBg2l5IRaJiEg3OU2WqP11N/v4Ns=;
        b=X9zutY/WqM+3WkhDKJkViI85FZ152N62zf9ss+VcnGp0DFn5nA55hjr1JxUl++E7BV
         r0EDy3dWgbG4hl74Z+Qt3P0Kf/zj4vlDraNns4iZBT4SnQcR/wbxUEFQJ8VboJuc9/PF
         CS6lbBs2M15DsGalnWkqYZ96wNwKbFyDebev8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697824610; x=1698429410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F4wi3imaHP2uII6OBg2l5IRaJiEg3OU2WqP11N/v4Ns=;
        b=deGr1CVS/ZI2eh5RB6Gef3AqDcG5dGpM14lEJnoh//5I6aLNm0/2YhTFMsV3pvH+Yf
         FoWa7buSxijUTPm3M+uFDHfBLPP3+BiuOLwO/Nl0ynoRw1jSyuLoD0jLgfS8XJ8N2dxy
         p54E55wRPTYebMJzZDMNL7TUftqYNKN6pnXk5o45bWi/q6rxiWCPsyqSSOqdjv7fb2Ok
         zdfD9IUIoI6IaBH7BEQztRSj0Ri1EYg3WTl9HVfe3RW7YbT0FUbDcz8+J0VN51nfdkHg
         DD3tov3IMx0a0MYk/+3IGU5vyLjiwBsG85Fl6VcGGWrN/6Y1UxVfIouERweZjUnQcWT1
         W6JA==
X-Gm-Message-State: AOJu0YyIybbJEA7ZXhnOzxEX4P+d5q6TUGfBaqZfgwCO94PMPn3Lpyoq
	E4T8TbO/hnoi8wvmSVhvlEALgl+SmVP3dFr/+Oe3Pmxr
X-Google-Smtp-Source: AGHT+IGTNXiFhEAvp+7npOBkhxjeYuYYRTDb+2Y5AdS+al7Utf6kKugG6zZMbg7HfttzZFJ432lBuQ==
X-Received: by 2002:a17:907:7212:b0:9bd:d405:4e8a with SMTP id dr18-20020a170907721200b009bdd4054e8amr2376807ejc.17.1697824609668;
        Fri, 20 Oct 2023 10:56:49 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id z15-20020a17090655cf00b0099bc038eb2bsm1902194ejp.58.2023.10.20.10.56.49
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 10:56:49 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so4624852a12.1
        for <linux-hardening@vger.kernel.org>; Fri, 20 Oct 2023 10:56:49 -0700 (PDT)
X-Received: by 2002:a17:907:94d0:b0:9ae:65d6:a51f with SMTP id
 dn16-20020a17090794d000b009ae65d6a51fmr5921646ejc.18.1697824608915; Fri, 20
 Oct 2023 10:56:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
 <20231019054642.GF14346@lst.de> <202310182248.9E197FFD5@keescook>
 <20231020044645.GC11984@lst.de> <CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com>
In-Reply-To: <CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 20 Oct 2023 10:56:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj4BZei4JTiX9qsAwk8PEKnPrvkG5FU0i_HNkcDpy7NGQ@mail.gmail.com>
Message-ID: <CAHk-=wj4BZei4JTiX9qsAwk8PEKnPrvkG5FU0i_HNkcDpy7NGQ@mail.gmail.com>
Subject: Re: the nul-terminated string helper desk chair rearrangement
To: Justin Stitt <justinstitt@google.com>
Cc: Christoph Hellwig <hch@lst.de>, Kees Cook <keescook@chromium.org>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Oct 2023 at 10:40, Justin Stitt <justinstitt@google.com> wrote:
>
> There's some docs at [1]. Perhaps there could be more?
>
> [1]: https://elixir.bootlin.com/linux/v6.6-rc6/source/include/linux/fortify-string.h#L292

Note that we have so few 'strlcpy()' calls that we really should
remove that horrid horrid interface. It's a buggy piece of sh*t.

'strlcpy()' is fundamentally unsafe BY DESIGN if you don't trust the
source string - which is one of the alleged reasons to use it.

That said, while 'strscpy()' fixes the fundamental conceptual bugs of
strlcpy(), it's worth noting that it has *two* differences wrt
strlcpy:

 - it doesn't have the broken return value

 - it copies things in word-size chunks to be more efficient

And because of that word-size thing it will possibly insert more than
one NUL character at the end of the result.

To give an example, if you have

   dst[64] = "abcdefghijklmnopqrstuvwxyz";
   src[64] = "123\0........";
   strlcpy(dst, src, 64);

then the strlcpy() will return 3 (the size of the copy), but the
destination will end up looking like

   dst[64] = "123\0\0\0\0\0ijklmnopqrstuvwxyz...";

This odd "possibly word padding" is basically never relevant (and it's
obviously always also limited by the size you gave it), but *if* you
are doing something really odd, and you expect the end of the
destination string to not be modified at all past the final NUL of the
copy, you need to be aware of this.

It does mean that if you used to have

    dst[4];
    strlcpy(dst, "abc", 8);

then that *used* to work (because it would copy four bytes: "abc\0"
and that fits in 'dst[]'). But

   dst[4];
   strscpy(dst, "abc", 8);

will overflow dst[], because it will do a word-copy and you told
'strscpy()' that you had a 8-byte buffer, and it will try to write
"abc\0\0\0\0\0" into the destination.

The above is insane code, but it's an example of why a blind
strlcpy->strscpy conversion might change semantics.

            Linus
