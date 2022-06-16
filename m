Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07E6CCA47A
	for <linux-hardening@archiver.kernel.org>; Thu, 16 Jun 2022 16:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbiFPQNA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 16 Jun 2022 12:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378067AbiFPQM7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 16 Jun 2022 12:12:59 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFDFB20
        for <linux-hardening@vger.kernel.org>; Thu, 16 Jun 2022 09:12:58 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id s12so3710862ejx.3
        for <linux-hardening@vger.kernel.org>; Thu, 16 Jun 2022 09:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B7nG0bqPdDQFZmSsFMUEcSWlp2CbGSXVxl7p6eJduFo=;
        b=P53257MRq0PaCsnXR0yo3W9NK8xQW/61/UG/ASXpReWpNC4QQ4/sCTBKq1QbtQuXIc
         P4JQ95jDMrDVHrQSgnN6Kff9BQSy0ixclTE0nn0kcYQNSzYiY9ct4iZ57jyvEhCUWTLJ
         2iQT2Qc5OTEnrylWq4IoFB8fqMPhD8qamKT0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B7nG0bqPdDQFZmSsFMUEcSWlp2CbGSXVxl7p6eJduFo=;
        b=bV/ezRVZDTV33xVys7bUwglUmEpZxbQUc1AE6b5gVtPUdnrUeDK/1uKYyfBuySJWij
         WUqSPnzjEBT7/VTihdyfa44ReBbf7XzD/R+maqTrRTNDi+JHCHnGc8Br0pjjk8AQpgGu
         px4ZJnu274P3NUxyeSanzzD55PUHQDVUdDEJParRt7SF+BEIPm8RQC16DhPuZ1ewkYKv
         ZZpQ+02Vk5vW1OSMLUaHiWM1EGWYSnC9Y0fa/ij3C0jJnvXmWrJUg93kKEN0xLsCieVL
         L9KobSAalsKbjQ7KQoyi9eKOUjrM87tX/lJRpdlYewFrnry6bvQXDA0P22zWGPYrGcqK
         SMTw==
X-Gm-Message-State: AJIora8BVwprOoxunrC9X//cSZfFqCPuOdPD3YEt3WnNr6zPBErwzLSE
        02sLsBuo6LhAgtvH4uj98hJlaKHNFWn/24g+AO8=
X-Google-Smtp-Source: AGRyM1utv8d8qMDFClyxy8rIS+oixGhyI6FvEYz33tO10lExwKfXk4N3sRQL5ZpUCKaaWNLfRclUyw==
X-Received: by 2002:a17:907:a064:b0:711:c819:3cbf with SMTP id ia4-20020a170907a06400b00711c8193cbfmr5483067ejc.460.1655395976868;
        Thu, 16 Jun 2022 09:12:56 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id eq20-20020a056402299400b0042deea0e961sm1927792edb.67.2022.06.16.09.12.54
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 09:12:55 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id o8so2511955wro.3
        for <linux-hardening@vger.kernel.org>; Thu, 16 Jun 2022 09:12:54 -0700 (PDT)
X-Received: by 2002:a05:6000:16c4:b0:20f:cd5d:4797 with SMTP id
 h4-20020a05600016c400b0020fcd5d4797mr5320732wrf.193.1655395974456; Thu, 16
 Jun 2022 09:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220616143617.449094-1-Jason@zx2c4.com> <YqtAShjjo1zC6EgO@casper.infradead.org>
 <YqtDXPWdFQ/fqgDo@zx2c4.com> <YqtKjAZRPBVjlE8S@casper.infradead.org> <CAHk-=wj2OHy-5e+srG1fy+ZU00TmZ1NFp6kFLbVLMXHe7A1d-g@mail.gmail.com>
In-Reply-To: <CAHk-=wj2OHy-5e+srG1fy+ZU00TmZ1NFp6kFLbVLMXHe7A1d-g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Jun 2022 09:12:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgSvPVGZp56uFCjOZoKcgQp7xpsj3P-Hhg+NXvhPnzszg@mail.gmail.com>
Message-ID: <CAHk-=wgSvPVGZp56uFCjOZoKcgQp7xpsj3P-Hhg+NXvhPnzszg@mail.gmail.com>
Subject: Re: [PATCH] usercopy: use unsigned long instead of uintptr_t
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jun 16, 2022 at 8:59 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So no. There is ABSOLUTELY ZERO reason to ever use 'uintptr_t' in the
> kernel. It's wrong. It's wrong *even* for actual user space interfaces
> where user space might use 'uintptr_t', because those need to be
> specific kernel types so that we control them (think for compat
> reasons etc).

Ok, so I wrote that just because that particular issue has happened
before with other types.

But then I actually grepped for uintptr_t use in the kernel.

And guess what you find when you do that?

You find

  #ifdef BINDER_IPC_32BIT
  typedef __u32 binder_size_t;
  typedef __u32 binder_uintptr_t;
  #else
  typedef __u64 binder_size_t;
  typedef __u64 binder_uintptr_t;
  #endif

exactly because user space interfaces used this broken sh*t-for-brains
traditional model that we've done over and over, and that has been a
big mistake.

We have similar mistakes in things like 'off_t', where we have a
mishmash of different versions (off_t, loff_t, __kernel_loff_t,
compat_loff_t) and several duplicate interfaces due to that.

The drm people (who end up having had more of this kind of stuff than
most) actually learnt their lesson, and made things be fixed-size.
We've done that in some other places too. It turns out that "u64" is a
fairly good type, but even *that* has caused problems, because we
really should have had a special "naturally aligned" version of it so
that you don't get the odd alignment issues (x86-32: 'u64' is 4-byte
aligned. m68k: u64 is 2-byte aligned).

So yeah. size_t and uintptr_t are both disasters in the kernel.

size_t we just have to live with. But that doesn't mean we want to
deal with uintptr_t.

Another issue is that we can't always control where user space defines
their types. Which is why we really don't want to use POSIX namespace
types in any interfaces anyway. It turns out that "u8..u64" are great
types, and adding two underscores to them for the uapi headers is
simple and straightforward enough.

Because using other types ends up being really nasty from a namespace
and "core compiler header files declare them in compiler-specific
places" etc. Sometimes they are literally hardcoded *inside* the
compiler (size_t being that kind of type).

Anyway, that's more of an explanation of why the whole "just use the
standard types" is simply NOT a good argument at all. We end up often
having to actively avoid them, and the ones we do use are very *very*
core and traditional

So the whole "just use the standard type" _sounds_ sane. But it really
isn't, and has some real issues, and we actively avoid it for good
reasons.

                 Linus
