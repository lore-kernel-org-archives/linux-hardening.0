Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FF2C001B0
	for <linux-hardening@archiver.kernel.org>; Wed,  9 Aug 2023 00:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjHIAmA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 8 Aug 2023 20:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjHIAl7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 8 Aug 2023 20:41:59 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD2E10D1
        for <linux-hardening@vger.kernel.org>; Tue,  8 Aug 2023 17:41:57 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686bea20652so6192867b3a.1
        for <linux-hardening@vger.kernel.org>; Tue, 08 Aug 2023 17:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691541717; x=1692146517;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gO70/E4EaG4t7+XkuG0UPt3Gj33okm9THhusBvGtMF0=;
        b=k7wLKeBM6labbIjgfzhnYc+u3rrEg6qAh4FoPMk4G4C+OPk78v0vfyUYD1F7DKjnnn
         npLRG+4n+4LZH9AwiWu5tqP75GYbz/m4F8Pd/vK9hNRwG6K2uDLkfbnW5DjAq45h8ynS
         EdpQjuJNUoQOqWiuCbCh0dVdnDOdIhoa9InBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691541717; x=1692146517;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gO70/E4EaG4t7+XkuG0UPt3Gj33okm9THhusBvGtMF0=;
        b=Nqk80EL0hUCaPY3QNwxNUzsxOBsXTNtduQn8Uz5zr17UzlgoshoDHwHYiTidFSQ6Ai
         dBnFjYup2g8ufPmKt+5w5kqkdOzofGruT1o+OvelXN5xOWcOQ7u/Kx3mBwpbUa03Z7uF
         Zi4DTzzHH8tPY+cpfV0AF4CsPzQWRXsXel3nJpRr73xwptH93yWlgkXHKRN82Ww8ugqi
         /MacgXnbHyLLvge+xxuwnE0B59vpKonHCHCalv7jx7INkXlCvpwhpika2pVIUzZsv7m4
         snmU7KgFwqHt8hzxmDj1mKPU15d6eddCodpgV8QwoAIZc1ddWN49oQyfRsL8VAbk2/vj
         y37Q==
X-Gm-Message-State: AOJu0YyX7vA+qSxIx4IzXwKSYx/lzBoKxhnCDDRbWwGnVLZXUPnaAOMM
        vglFbH9uQ20F1gNVqTlNy05R5LHDkp6A+WL9A1o=
X-Google-Smtp-Source: AGHT+IHUfGme03tY4sw4mZxOh2mRx8YqmqNpdDuu11qg/Cqnc0DIUC6MT//VqcDAxNmuy9HVi9DmIw==
X-Received: by 2002:a05:6a20:8e09:b0:140:a6ec:de6b with SMTP id y9-20020a056a208e0900b00140a6ecde6bmr1585165pzj.51.1691541717032;
        Tue, 08 Aug 2023 17:41:57 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902bd0700b001b3bf8001a9sm9606285pls.48.2023.08.08.17.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 17:41:56 -0700 (PDT)
Date:   Tue, 8 Aug 2023 17:41:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Bill Wendling <morbo@google.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-hardening@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] um: refactor deprecated strncpy to strtomem
Message-ID: <202308081708.D5ADC80F@keescook>
References: <20230807-arch-um-v1-1-86dbbfb59709@google.com>
 <CAGG=3QVUqVdkzBo-=vGWprPBUhuV8p3bRSx3Qsvtqx_LDct05w@mail.gmail.com>
 <202308071636.AF290F0@keescook>
 <CAFhGd8oSGJ5=fk58wOSgbuXX_VaP14q0Re=Xfom=rdOR6fT1rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8oSGJ5=fk58wOSgbuXX_VaP14q0Re=Xfom=rdOR6fT1rQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Aug 08, 2023 at 10:28:57AM -0700, Justin Stitt wrote:
> On Mon, Aug 7, 2023 at 4:40 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Aug 07, 2023 at 03:36:55PM -0700, Bill Wendling wrote:
> > > On Mon, Aug 7, 2023 at 2:18 PM Justin Stitt <justinstitt@google.com> wrote:
> > > >
> > > > Use `strtomem` here since `console_buf` is not expected to be
> > > > NUL-terminated. We should probably also just use `MCONSOLE_MAX_DATA`
> >
> > How is it known that console_buf is not a C-string?
> There are a few clues that led me to believe console_buf was not a C-string:
> 1)  `n = min((size_t) len, ARRAY_SIZE(console_buf));` means that `n`
> can be equal to size of buffer which is then subsequently filled
> entirely by the `strncpy` invocation.
> 2) console_buf looks to be a circular buffer wherein once it's filled
> it starts again from the beginning.
> 3) ARRAY_SIZE is used on it as opposed to strlen or something like
> that (but not sure if ARRAY_SIZE is also used on C-strings to be fair)
> 4) It has `buf` in its name which I loosely associate with non
> C-strings char buffers.
> 
> All in all, it looks to be a non C-string but honestly it's hard to
> tell, especially since if it IS a C-string the previous implementation
> had some bugs with strncpy I believe.

I took a look at this. It's only used in that one function, and it's
always working from the start, and uses at max ARRAY_SIZE(console_buf),
as you mentioned. Then it's passed to mconsole_reply_len() with "len",
so we can examine that:

	do {
		...
                len = MIN(total, MCONSOLE_MAX_DATA - 1);
		...
                memcpy(reply.data, str, len);
                reply.data[len] = '\0';
                total -= len;
		...
	} while (total > 0);

It's sending it as NUL-terminated, possibly breaking it up. If this used
the whole MCONSOLE_MAX_DATA, it would send MCONSOLE_MAX_DATA - 1 bytes
followed by NUL, and then 1 byte, followed by NUL. :P

Anyway, point being, yes, it appears that console_buf is a nonstring.
But it's a weird one...

In your v2 patch, you use strtomem(), which is probably close, but in
looking at the implementation details here, I'm starting to think that
strtomem() needs to return the number of bytes copied. Initially I was
thinking it could actually just be replaced with memcpy(), but there
are some side-effects going on in the original code.

First:

static void console_write(..., const char *string, unsigned int len)
	...
                n = min((size_t) len, ARRAY_SIZE(console_buf));
                strncpy(console_buf, string, n);

The 'n' is being passed in, so it's possible that "string" has NUL-bytes
in it. (Though I would assume, unlikely -- I haven't tracked down the
callers of console_write() here...)

That means that strncpy() will stop the copy at the first NUL and
then NUL pad the rest to 'n', and that's what gets passed down to
mconsole_reply_len() (which is specifically using memcpy and will carry
those NUL bytes forward). So we should not lose the NUL-padding behavior.

Additionally, when "len" is smaller than MCONSOLE_MAX_DATA, the padding
will only go up to "len", not MCONSOLE_MAX_DATA. So there's a weird
behavioral difference here where the new code is doing more work, but,
okay fine.

I find this original code to be rather confused about whether it is
dealing with C-strings or byte arrays. :|

So now I wanted to find the callers of struct console::write. My
Coccinelle script:

@found@
struct console *CON;
@@

*       CON->write(...)

show hits in kernel/printk/printk.c, which is dealing with a
NUL-terminated string constructed by vsnprintf():

	console_emit_next_record

Technically there could be NUL bytes in such a string, but almost
everything else expects to be dealing with C-strings here. This looks
really fragile.

So, I'm back around to thinking this should just be memcpy():

-		strncpy(console_buf, string, n);
+		memcpy(console_buf, string, n);


-- 
Kees Cook
