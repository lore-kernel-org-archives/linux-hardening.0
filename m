Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F8BC32771
	for <linux-hardening@archiver.kernel.org>; Tue, 27 Sep 2022 03:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiI0DYz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 26 Sep 2022 23:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiI0DYD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 26 Sep 2022 23:24:03 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38C38C02E
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 20:23:59 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id lx7so1622871pjb.0
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 20:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=6qnuVXzVK4CfrmKG46F4wOs5bWFBYOAqV06iNpVAm8Q=;
        b=j18dmHaA/jdXoSKrM6wf3lTURBrXi6pP37nOyBWWmRoVQYR2icnLVrpvyM2AWwLein
         ioq6z80/lNYQTLifhwMz3ZA0IqB77Vro2L2rVHec3mTeF6xEFTopr/+i8+OW9nR5csgu
         o9dfU1FxwgQkjMxTmP5cgi2MONn2MkdI87ewA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=6qnuVXzVK4CfrmKG46F4wOs5bWFBYOAqV06iNpVAm8Q=;
        b=iouculgz4qsDXnev9kNvQ3c+6/9CO3m0fb9wuaCCTT3wxeCUv3fwEnyNvFuCzcVfAF
         tD/JXyh5LtO0JLVul7co8DvONvnjqP+vCWG7rnq9mKMRl+9shGwiyE3aBjLvxT3IVrR0
         x5qHFB4Cf0Gule1Egd0eII3jR5PKZSgGWYBA1NebODjowRBA0kN+ddIMOoqXUj1iwwW1
         5j8u06Y6Yc5wCgXROhjRFOkK7ngD6mESyikmkiCP6NCt6/whSmm5n0R6mvJzYg+5Ll4w
         lSXsfYGy4rMjzDnw6XRe/9VKd455tGAs3B2S4XWc17qc1oTWwRwgWaNaIzaSs6CnRP9S
         smSg==
X-Gm-Message-State: ACrzQf0BVcilQ4UWi2tLlQxjHEnrBEwWZ5pTEJwMr1bHKweWDSiyyzQs
        uS+n5wpkkqD2aHqSVaec0dEw9Q==
X-Google-Smtp-Source: AMsMyM6jADNKBfzb6PVX/gjDuojxQtNxZ95zNpojuwR1E1012rYK21sQaLtCU3gP8HjP0Ga8PhJKog==
X-Received: by 2002:a17:903:18d:b0:178:28d1:4a13 with SMTP id z13-20020a170903018d00b0017828d14a13mr25170592plg.160.1664249039360;
        Mon, 26 Sep 2022 20:23:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lt21-20020a17090b355500b002002f9eb8c4sm238643pjb.12.2022.09.26.20.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 20:23:58 -0700 (PDT)
Date:   Mon, 26 Sep 2022 20:23:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] random: split initialization into early arch step and
 later non-arch step
Message-ID: <202209262017.D751DDC38F@keescook>
References: <20220926160332.1473462-1-Jason@zx2c4.com>
 <202209261105.9C6AEEEE1@keescook>
 <CAHmME9pFDzyKJd5ixyB9E05jkZvHShFimbiQsGTcdQO1E5R0QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9pFDzyKJd5ixyB9E05jkZvHShFimbiQsGTcdQO1E5R0QQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 26, 2022 at 08:52:39PM +0200, Jason A. Donenfeld wrote:
> On Mon, Sep 26, 2022 at 8:22 PM Kees Cook <keescook@chromium.org> wrote:
> > Can find a way to get efi_get_random_bytes() in here too? (As a separate
> > patch.) I don't see where that actually happens anywhere currently,
> > and we should have it available at this point in the boot, yes?
> 
> No, absolutely not. That is not how EFI works. EFI gets its seed to
> random.c much earlier by way of add_bootloader_randomness().

Ah! Okay, so, yes, it _does_ get entropy in there, just via a path I
didn't see?

> 
> > > -             entropy[0] = random_get_entropy();
> > > -             _mix_pool_bytes(entropy, sizeof(*entropy));
> > >               arch_bits -= sizeof(*entropy) * 8;
> > >               ++i;
> > >       }
> > > -     _mix_pool_bytes(&now, sizeof(now));
> > > -     _mix_pool_bytes(utsname(), sizeof(*(utsname())));
> >
> > Hm, can't we keep utsname in the early half by using init_utsname() ?
> 
> Yes, we could maybe *change* to using init_utsname if we wanted. That
> seems kind of different though. So I'd prefer that to be a different
> patch, which would require looking at the interaction with early
> hostname setting and such. If you want to do that work, I'd certainly
> welcome the patch.

Er, isn't that _WAY_ later? Like, hostname isn't set until sysctls up
and running, etc. I haven't actually verified 100% but it looks like
current->utsname is exactly init_utsname currently.

But if not, I guess it could just get added in both places. I'd be nice
to keep kernel version as part of the pre-time-keeping entropy stuffing.

> > Was there a reason kfence_init() was happening before time_init()?
> 
> Historically there was, I think, because random_init() used to make
> weird allocations. But that's been gone for a while. At this point
> it's a mistake, and removing it allows me to do this:
> 
> https://groups.google.com/g/kasan-dev/c/jhExcSv_Pj4

Cool. Is that true for all the -stable releases this is aimed at?

Anyway, just to repeat before: yay! I really like seeing this split up.
:)

-- 
Kees Cook
