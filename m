Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D283CC433FE
	for <linux-hardening@archiver.kernel.org>; Mon,  7 Nov 2022 21:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiKGVtA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 7 Nov 2022 16:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiKGVs6 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 7 Nov 2022 16:48:58 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C372B286D4
        for <linux-hardening@vger.kernel.org>; Mon,  7 Nov 2022 13:48:57 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id bp12so5251442ilb.9
        for <linux-hardening@vger.kernel.org>; Mon, 07 Nov 2022 13:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XWC+o9EuiWgnDwII3oLYBWgfLGQAEbU3zeoA94HsocY=;
        b=BJp5dFnatAyCODoMXXuloRfYrFOSXO9y53GQCHhPEAyyWK4awpuAKXyYQtuZH4wLE0
         oQ+UGdX7ix+LvFsDtaeeCQcdLre9oTVi03REpMs21+Ip5SuA1MXF28D24kQMqdnNh0fh
         bSggQGFp81AzURDMJUWmOEGM28OgaeTI+99GcB+7KuEFuRWYVeDQAhq9LxLUoKgC6V1y
         JOvNwxJQbSuk9fAMbi9EAwu2LU3sG9weEnBP0ZVYaRGlCwFrkdZhRxbWKg7LS7rn17Mr
         eBP3CrvS8GdhgvIbnFQFpxFnp1McYdvMgNQXkh/gDYYvlT5W8p3Lxx9gMb9viQKONZPo
         MuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XWC+o9EuiWgnDwII3oLYBWgfLGQAEbU3zeoA94HsocY=;
        b=JaDPCuPqrt5kHfpTxqmwhk2wq82DeNXKH9kx4l+KtN8y/em+OIf6QwdT1JOOfoF8c8
         wALEJ37EBTDszuuOFzku1MefW646V9Y8uUqwpIf+BC7VKYLXrdCPdnG9E2Gyw7py5YgS
         xF65OO8W7MYLI7gv7x58g9MKt3nv5wJNftQDPpe3qbA8ghQ35/H2zXo22dHkr9qBq6Ci
         LRd25T4+UOoWisK7ASlcldbU53xwedLHLRTm2xiN8E5+JYJvJdAQh6TQVB7wZboWrA4y
         0CW9gb8Lv4OkEUYoBd6rY4/z2JJ8DL+VyANiUeR6vXOvysWtWbLRhys3iXCB2IrOAkIY
         GVOA==
X-Gm-Message-State: ACrzQf3lQ17u84Fc/zb6XPVrWkSOmxzGFiQDVPNIEHZnF9I+nsvlf1xY
        wL2X8a1w+lmxaZ3ayBJFQRaUvzLlfNj9GKFxSgbLWw==
X-Google-Smtp-Source: AMsMyM4TI4ySYBH9jynGLl8NgrYZgE0ppylJZxMeEt8hv2KKd0888+AjYQB2ezIy/kiY4p1d7MJoUV+v4xbnxItbeuo=
X-Received: by 2002:a92:d64d:0:b0:2ff:f959:bc47 with SMTP id
 x13-20020a92d64d000000b002fff959bc47mr22185752ilp.187.1667857736979; Mon, 07
 Nov 2022 13:48:56 -0800 (PST)
MIME-Version: 1.0
References: <20221107201317.324457-1-jannh@google.com> <20221107211440.GA4233@openwall.com>
In-Reply-To: <20221107211440.GA4233@openwall.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 7 Nov 2022 22:48:20 +0100
Message-ID: <CAG48ez2-xUawSs4ji_+0Bnyn_QTiS930UiOypXreU_RhwhVo_w@mail.gmail.com>
Subject: Re: [PATCH] exit: Put an upper limit on how often we can oops
To:     Solar Designer <solar@openwall.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Seth Jenkins <sethjenkins@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Nov 7, 2022 at 10:15 PM Solar Designer <solar@openwall.com> wrote:
> On Mon, Nov 07, 2022 at 09:13:17PM +0100, Jann Horn wrote:
> > +oops_limit
> > +==========
> > +
> > +Number of kernel oopses after which the kernel should panic when
> > +``panic_on_oops`` is not set.
>
> Rather than introduce this separate oops_limit, how about making
> panic_on_oops (and maybe all panic_on_*) take the limit value(s) instead
> of being Boolean?  I think this would preserve the current behavior at
> panic_on_oops = 0 and panic_on_oops = 1, but would introduce your
> desired behavior at panic_on_oops = 10000.  We can make 10000 the new
> default.  If a distro overrides panic_on_oops, it probably sets it to 1
> like RHEL does.
>
> Are there distros explicitly setting panic_on_oops to 0?  If so, that
> could be a reason to introduce the separate oops_limit.
>
> I'm not advocating one way or the other - I just felt this should be
> explicitly mentioned and decided on.

I think at least internally in the kernel, it probably works better to
keep those two concepts separate? For example, sparc has a function
die_nmi() that uses panic_on_oops to determine whether the system
should panic when a watchdog detects a lockup.
