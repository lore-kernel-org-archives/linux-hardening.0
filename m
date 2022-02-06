Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34C3C433F5
	for <linux-hardening@archiver.kernel.org>; Sun,  6 Feb 2022 18:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245173AbiBFStT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 6 Feb 2022 13:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244645AbiBFStS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 6 Feb 2022 13:49:18 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661F4C06173B
        for <linux-hardening@vger.kernel.org>; Sun,  6 Feb 2022 10:49:17 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id d186so9712193pgc.9
        for <linux-hardening@vger.kernel.org>; Sun, 06 Feb 2022 10:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2v4Bkm8br56s9qLPALsh3pbC7ql67TUJ0yFnLPxLRHk=;
        b=bHu48kLEfO0BvtG6X0aiGbTtRNOUTWieaRIPaWNVq0kGREyeoBqdU0yjw4IOPe9Tj0
         nAeJ7SVbj1adJGvHFKz1t/wqHo3Mbb0w2OoGbI2MoGZAFeXUAzWY7vREhLb1/qR4N82D
         TvFOCCgbiwXQhtyaCLILTjc57sTV0acdHDw/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2v4Bkm8br56s9qLPALsh3pbC7ql67TUJ0yFnLPxLRHk=;
        b=sNkC1V3IwmsoK3NJh2xf5tjkcpTac/Y4zqj+PKC93iUEX3Y/g58z+dHZxeQcD84pw2
         wv2SiJqkuufDIAOEk/PVr14HLvaEKYTFGHqeiQpzRtQoZT+BY0Xus+DUkXXwqjXJLU0A
         8IcrygikL5rjZQ61gQ7XlCOWOmazvgo7lEGM7z6+rN9Q9If66hXo/43elnhks9cwzxhe
         u56p97NbyBQNLev6lLBfuoHV4VbV2BXfXVgBk8bCG88Qki9WlwP5YF3PVH+qCgT2PJsk
         Sm9OwHsemxqF289wuE27vdXQOSanHBCOV5mnj2kCNcgyc3BcNQ8MwQyFrY/P0l5ampyh
         WphQ==
X-Gm-Message-State: AOAM532KOz3QMudjbvk/0CnkeOTB7CFWn4FYg7kar2zB5r7toYNgifAq
        PKdlcDsejQnFunJiJuR9HmQxvA==
X-Google-Smtp-Source: ABdhPJyWqmFuqt/fFPdQlg8sO5tyPVSj3BV1IVOc6TI82qubKGsKg0BvZ/UnZK/5jEFTljEBuu8E2Q==
X-Received: by 2002:a63:e04a:: with SMTP id n10mr6839350pgj.487.1644173356941;
        Sun, 06 Feb 2022 10:49:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k9sm1758823pgg.50.2022.02.06.10.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 10:49:16 -0800 (PST)
Date:   Sun, 6 Feb 2022 10:49:15 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/3] gcc-plugins/stackleak: Exactly match strings instead
 of prefixes
Message-ID: <202202061046.040D6A0A0@keescook>
References: <20220206174508.2425076-1-keescook@chromium.org>
 <20220206174508.2425076-3-keescook@chromium.org>
 <CAHk-=wg5oaiJty+pCLd7aS3c-86=JDvF_vuaUvyq+Yo6+cKhyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg5oaiJty+pCLd7aS3c-86=JDvF_vuaUvyq+Yo6+cKhyg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Feb 06, 2022 at 10:34:11AM -0800, Linus Torvalds wrote:
> On Sun, Feb 6, 2022 at 9:45 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > +       return !strncmp(TREE_STRING_POINTER(node), string, length);
> 
> Why is this "strncmp()"? That makes no sense when you've just checked
> the exact lengths of both sides.
> 
> You're not comparing strings any more, you've already checked the end
> of the string - you are comparing memory contents.
> 
> So make it just do a "memcmp()".

Yeah, good point. I'll change this for v2, pending more feedback.

> > +#define STRING_EQUAL(node, str)        string_equal(node, str, strlen(str))
> 
> .. and please change this name too, since it's not comparing two
> strings. The first argument is something else entirely.
> 
> It's checking the node value of a section, give it some name related to that.

Technically, yes. The naming bikeshed here is odd since it's called
"STRING" by gcc internals, and it *might* be a "C string", etc etc. I'll
rename it...

> I do also get the feeling that the nodes should actually be checked to
> be a STRING_CST rather than these blind TREE_VALUE() following things,
> but I don't really know the rules for gcc plugin internals very well -
> or at all, really.

I'll double-check this, but if it's not a STRING_CST something else has
gone very wrong already. But I'm a fan of robustness, so sure. :)

-Kees

-- 
Kees Cook
