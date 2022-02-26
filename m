Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4A5C433FE
	for <linux-hardening@archiver.kernel.org>; Sat, 26 Feb 2022 02:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiBZCW5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 25 Feb 2022 21:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiBZCW5 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 25 Feb 2022 21:22:57 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F8410FEB
        for <linux-hardening@vger.kernel.org>; Fri, 25 Feb 2022 18:22:23 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 132so6219124pga.5
        for <linux-hardening@vger.kernel.org>; Fri, 25 Feb 2022 18:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NU41BZVIshf7xI3L4T/th6wwfkRDpNs6CMZQ6sz+OAM=;
        b=P6Xk413iS6EAWJWQRkLzz7tKoG18NCXD+I/wkPxSiv5SfckJssGuwRaZrxNU66YxYO
         XOWgPxrzCcCADU7qobCC4NNMNYu5DrVJqZKCyml6vFAmQy1+57T7crw9dlU3TmZKxlin
         SeNvXjscHDzJUZOpUXhEQoqNxOS5sxijcUJmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NU41BZVIshf7xI3L4T/th6wwfkRDpNs6CMZQ6sz+OAM=;
        b=ZlGGD98453RW585muVnVpdfLhhd/WvWgj8YL+wKTPRT5AEczvhkjGdxvZcU/MggRZU
         vZ+k9+RI7QT10bHcw8LuiJ3RBgZS7W3Tl4TQMip/0TMUTsx4EGNpH6CQ6M1UKNvWEEZs
         evsk6vL/sWPJsdbJARRb2tu8TefQN6e0pIuMEnqNyyqTSZL6s6IMvadkeSTtUUfufuCX
         3SDLkOpNluLxaMk93h0l7/k5jtRJt7TeXpBgDQONJPCX4F3ilxX+iDJExiTiibgUxc+7
         j0FrwkQygZymdtq2uKndlKJDs/pcK2bV1rATiDDmDlAUwq0d/TZpMBvzHedyQgjF/Mkf
         vRwg==
X-Gm-Message-State: AOAM533Ot+YMJeBvHfHZ0p8qeXxYNk+fycdEonPj54AtCiHBthhPSXNo
        HeaHFW1CAqqZXe9gW46yTW4TsA==
X-Google-Smtp-Source: ABdhPJx+FVw9r8IymeMRCm4kNuD+w2IV8xHis4JNEOsKF3lH1u8GZSFdKMk4mq8Sj3CelVcc0a4w6w==
X-Received: by 2002:a05:6a00:3018:b0:4e1:de9a:a5a3 with SMTP id ay24-20020a056a00301800b004e1de9aa5a3mr10699058pfb.80.1645842143157;
        Fri, 25 Feb 2022 18:22:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id pg14-20020a17090b1e0e00b001bbadc2205dsm3946625pjb.20.2022.02.25.18.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 18:22:22 -0800 (PST)
Date:   Fri, 25 Feb 2022 18:22:22 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, linux-mm@kvack.org,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Laight <David.Laight@aculab.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] usercopy: Check valid lifetime via stack depth
Message-ID: <202202251818.BC91622D@keescook>
References: <20220225173345.3358109-1-keescook@chromium.org>
 <20220225160157.680ecdea21ce81183059bb63@linux-foundation.org>
 <202202251728.1634F405@keescook>
 <20220225174657.9e1af8ec59ce8dbf223f84c5@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225174657.9e1af8ec59ce8dbf223f84c5@linux-foundation.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Feb 25, 2022 at 05:46:57PM -0800, Andrew Morton wrote:
> On Fri, 25 Feb 2022 17:35:49 -0800 Kees Cook <keescook@chromium.org> wrote:
> 
> > On Fri, Feb 25, 2022 at 04:01:57PM -0800, Andrew Morton wrote:
> > > On Fri, 25 Feb 2022 09:33:45 -0800 Kees Cook <keescook@chromium.org> wrote:
> > > 
> > > > Under CONFIG_HARDENED_USERCOPY=y, when exact stack frame boundary checking
> > > > is not available (i.e. everything except x86 with FRAME_POINTER), check
> > > > a stack object as being at least "current depth valid", in the sense
> > > > that any object within the stack region but not between start-of-stack
> > > > and current_stack_pointer should be considered unavailable (i.e. its
> > > > lifetime is from a call no longer present on the stack).
> > > > 
> > > > Introduce ARCH_HAS_CURRENT_STACK_POINTER to track which architectures
> > > > have actually implemented the common global register alias.
> > > > 
> > > > Additionally report usercopy bounds checking failures with an offset
> > > > from current_stack_pointer, which may assist with diagnosing failures.
> > > > 
> > > > The LKDTM USERCOPY_STACK_FRAME_TO and USERCOPY_STACK_FRAME_FROM tests
> > > > (once slightly adjusted in a separate patch) will pass again with
> > > > this fixed.
> > > 
> > > Again, what does this actually do?
> > 
> > [answers]
> >
> 
> OK, thanks.  I think a new changelog is warranted?

Yup, I've cut/pasted most of that into the new changelog:

    usercopy: Check valid lifetime via stack depth

    One of the things that CONFIG_HARDENED_USERCOPY sanity-checks is whether
    an object that is about to be copied to/from userspace is overlapping
    the stack at all. If it is, it performs a number of inexpensive
    bounds checks. One of the finer-grained checks is whether an object
    crosses stack frames within the stack region. Doing this on x86 with
    CONFIG_FRAME_POINTER was cheap/easy. Doing it with ORC was deemed too
    heavy, and was left out (a while ago), leaving the courser whole-stack
    check.

    The LKDTM tests USERCOPY_STACK_FRAME_TO and USERCOPY_STACK_FRAME_FROM
    try to exercise these cross-frame cases to validate the defense is
    working. They have been failing ever since ORC was added (which was
    expected). While Muhammad was investigating various LKDTM failures[1],
    he asked me for additional details on them, and I realized that when
    exact stack frame boundary checking is not available (i.e.  everything
    except x86 with FRAME_POINTER), it could check if a stack object is at
    least "current depth valid", in the sense that any object within the
    stack region but not between start-of-stack and current_stack_pointer
    should be considered unavailable (i.e. its lifetime is from a call no
    longer present on the stack).

    Introduce ARCH_HAS_CURRENT_STACK_POINTER to track which architectures
    have actually implemented the common global register alias.

    Additionally report usercopy bounds checking failures with an offset
    from current_stack_pointer, which may assist with diagnosing failures.

    The LKDTM USERCOPY_STACK_FRAME_TO and USERCOPY_STACK_FRAME_FROM tests
    (once slightly adjusted in a separate patch) pass again with this fixed.

    [1] https://github.com/kernelci/kernelci-project/issues/84

    Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
    Cc: Josh Poimboeuf <jpoimboe@redhat.com>
    Cc: Andrew Morton <akpm@linux-foundation.org>
    Cc: linux-mm@kvack.org
    Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
    Signed-off-by: Kees Cook <keescook@chromium.org>
    ---
    v1: https://lore.kernel.org/lkml/20220216201449.2087956-1-keescook@chromium.org
    v2: https://lore.kernel.org/lkml/20220224060342.1855457-1-keescook@chromium.org
    v3: https://lore.kernel.org/lkml/20220225173345.3358109-1-keescook@chromium.org
    v4: - improve commit log (akpm)


> What's your preferred path for upstreaming this change?

I figured I would take it via my for-next/hardening tree; I have 2
arch changes ready to go (Acked by maintainers) there too (to add
current_stack_pointer).

Thanks for the review!

-- 
Kees Cook
