Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B6BC433FE
	for <linux-hardening@archiver.kernel.org>; Tue,  8 Nov 2022 19:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiKHTi1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 8 Nov 2022 14:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKHTi0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 8 Nov 2022 14:38:26 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225C4C52
        for <linux-hardening@vger.kernel.org>; Tue,  8 Nov 2022 11:38:24 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 130so1874774pgc.5
        for <linux-hardening@vger.kernel.org>; Tue, 08 Nov 2022 11:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kAbbHa0MU4YSxghWvSMb9cKPpMmHz+thNxD0lfZcRnE=;
        b=Vo6mB1KdmXqg3bRs5BIpPsiCoMg7kGFMb6EfY4KBG7C+26ABX9fzMad1aFf/qWUeFk
         4wQcvA+8RrCL32Prn9hQJtP95eP+SOkL9xJNPpcce5Ia6uQQ+73mMcDhkJ1JWj1Guh69
         bq/bm6xHlSbkrYjWLKEBymnmUJwNoJkaZXM4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAbbHa0MU4YSxghWvSMb9cKPpMmHz+thNxD0lfZcRnE=;
        b=4umwSaQFob9atTTwqyXVUwrJXEXyPJlYyT/u3DIrLWUV8hV/TTP3YOTmwboJQ5p0gW
         ieVrRmtynLfuxz4nGvooBgOW5RYA/eNrQCLc1QwUTdiqXQwmPgrDHYuD20WdSItCXLmD
         DZDwH977+QYwJgaFfGZjKvw3vslSe1uj1KMH4t0OYzmtniZgIewi2cSNpbteTJpdrpyg
         2EKMamD3pWylpIHDph3z3+JWxcAlqyZ59GGWX494NBQTqigdfd10zqTK/sAP5Z1xXC/6
         9os7/hWlDB/UxBFiBly8QUlY7XgqwFgu4WDAqbCXqwvnvN/+iE4vr/2e7AfLB1cU/+D+
         Fltg==
X-Gm-Message-State: ACrzQf2YxF3R5gnuhpo6gFlt/wQb3RM81q8e+EOE+DZAYiOvosfc6n0M
        6TiL5l5t362yx7qRIW94w15I7ZnwkxdY9A==
X-Google-Smtp-Source: AMsMyM6/U+AxVETsL5YtefxFYQhjs7JeR/fXEmmw1+qiyAQRZZl+u0+IDe3Zk7tBRQQNnk/g8DmWnQ==
X-Received: by 2002:a63:e06:0:b0:46f:6f55:dd44 with SMTP id d6-20020a630e06000000b0046f6f55dd44mr1079752pgl.252.1667936303665;
        Tue, 08 Nov 2022 11:38:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h3-20020aa796c3000000b0056246403534sm6731480pfq.88.2022.11.08.11.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 11:38:23 -0800 (PST)
Date:   Tue, 8 Nov 2022 11:38:22 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Solar Designer <solar@openwall.com>,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Seth Jenkins <sethjenkins@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exit: Put an upper limit on how often we can oops
Message-ID: <202211081100.AA81FBE964@keescook>
References: <20221107201317.324457-1-jannh@google.com>
 <20221107211440.GA4233@openwall.com>
 <CAG48ez2-xUawSs4ji_+0Bnyn_QTiS930UiOypXreU_RhwhVo_w@mail.gmail.com>
 <202211080923.8BAEA9980@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211080923.8BAEA9980@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Nov 08, 2022 at 09:24:40AM -0800, Kees Cook wrote:
> On Mon, Nov 07, 2022 at 10:48:20PM +0100, Jann Horn wrote:
> > On Mon, Nov 7, 2022 at 10:15 PM Solar Designer <solar@openwall.com> wrote:
> > > On Mon, Nov 07, 2022 at 09:13:17PM +0100, Jann Horn wrote:
> > > > +oops_limit
> > > > +==========
> > > > +
> > > > +Number of kernel oopses after which the kernel should panic when
> > > > +``panic_on_oops`` is not set.
> > >
> > > Rather than introduce this separate oops_limit, how about making
> > > panic_on_oops (and maybe all panic_on_*) take the limit value(s) instead
> > > of being Boolean?  I think this would preserve the current behavior at
> > > panic_on_oops = 0 and panic_on_oops = 1, but would introduce your
> > > desired behavior at panic_on_oops = 10000.  We can make 10000 the new
> > > default.  If a distro overrides panic_on_oops, it probably sets it to 1
> > > like RHEL does.
> > >
> > > Are there distros explicitly setting panic_on_oops to 0?  If so, that
> > > could be a reason to introduce the separate oops_limit.
> > >
> > > I'm not advocating one way or the other - I just felt this should be
> > > explicitly mentioned and decided on.
> > 
> > I think at least internally in the kernel, it probably works better to
> > keep those two concepts separate? For example, sparc has a function
> > die_nmi() that uses panic_on_oops to determine whether the system
> > should panic when a watchdog detects a lockup.
> 
> Internally, yes, the kernel should keep "panic_on_oops" to mean "panic
> _NOW_ on oops?" but I would agree with Solar -- this is a counter as far
> as userspace is concerned. "Panic on Oops" after 1 oops, 2, oopses, etc.
> I would like to see this for panic_on_warn too, actually.

Hm, in looking at this more closely, I think it does make sense as you
already have it. The count is for the panic_on_oops=0 case, so even in
userspace, trying to remap that doesn't make a bunch of sense. So, yes,
let's keep this as-is.

-- 
Kees Cook
