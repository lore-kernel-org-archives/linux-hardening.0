Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13609C43217
	for <linux-hardening@archiver.kernel.org>; Tue,  8 Nov 2022 17:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbiKHRYn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 8 Nov 2022 12:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbiKHRYm (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 8 Nov 2022 12:24:42 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074D118E11
        for <linux-hardening@vger.kernel.org>; Tue,  8 Nov 2022 09:24:42 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso18539296pjc.0
        for <linux-hardening@vger.kernel.org>; Tue, 08 Nov 2022 09:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2jXnwrdOctEAg+6kVY9hCNzqeQ8ppwfCq8v7ax8XLyc=;
        b=h6D/IhT6OiuD6Oz+6iB4e635Qux6H+f6qBbBPVTGtHvODhDFB2CnQs8vlNB+Nsbafg
         03RtBAuw9ByoFQs980ux+z2LmzPfeAtYXLRCq6JM5hxHViWryYtF8bTcTb7X1FEzY/K6
         UORYYY6hBNReHXNzkYb6gfgK1E2XkcDT9Na40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jXnwrdOctEAg+6kVY9hCNzqeQ8ppwfCq8v7ax8XLyc=;
        b=wVmJMISjFUns2M+Yach3kQvwAO6Ugmcy1jc3lYP5jZ2q9ffCOp7TgxVUm0DZtFneFL
         ooSfRllApj0zacYHcfZlcfL3PzOCtiYEieweZp6rWBExPyPI1EY183sZqCPHSXZGWVMu
         BNdhWkWAW+YEITNI49hFXH/r7cwtJ3FmbC0vQj8+x01EJ8fuPHzL0s/exlv7j//nu8NH
         Guf+Mkn9mAjEmadXFWh9o9dTxeuI/BAEZuqSQH8g/LKO0J3zD9zCcMhVHQYFzm7NGPez
         zRpRnZUDj4/hSl9EmKf58GsyfFMHXOvJxULoLc8AqzEOLTn5y1L2nipHum8htTsXUPA9
         I2iw==
X-Gm-Message-State: ACrzQf1+ESkTcPQ6tIacn4Q4Ed75SYUhyPz5ZfMCwpyqoukYPxQ3kacf
        hexKGNXrRUcEsPblCmvdnuHtRQ==
X-Google-Smtp-Source: AMsMyM7BM+yOcGq3Phx6Hb1U5oS2KniFsbemmzg1XGdqd6aw4Uxv40mr3JOyoKudrTJspDw0hxUsMA==
X-Received: by 2002:a17:90a:d24d:b0:213:d3e4:677a with SMTP id o13-20020a17090ad24d00b00213d3e4677amr49640405pjw.101.1667928281513;
        Tue, 08 Nov 2022 09:24:41 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g12-20020aa796ac000000b00561b02e3118sm6611648pfk.106.2022.11.08.09.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 09:24:41 -0800 (PST)
Date:   Tue, 8 Nov 2022 09:24:40 -0800
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
Message-ID: <202211080923.8BAEA9980@keescook>
References: <20221107201317.324457-1-jannh@google.com>
 <20221107211440.GA4233@openwall.com>
 <CAG48ez2-xUawSs4ji_+0Bnyn_QTiS930UiOypXreU_RhwhVo_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2-xUawSs4ji_+0Bnyn_QTiS930UiOypXreU_RhwhVo_w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Nov 07, 2022 at 10:48:20PM +0100, Jann Horn wrote:
> On Mon, Nov 7, 2022 at 10:15 PM Solar Designer <solar@openwall.com> wrote:
> > On Mon, Nov 07, 2022 at 09:13:17PM +0100, Jann Horn wrote:
> > > +oops_limit
> > > +==========
> > > +
> > > +Number of kernel oopses after which the kernel should panic when
> > > +``panic_on_oops`` is not set.
> >
> > Rather than introduce this separate oops_limit, how about making
> > panic_on_oops (and maybe all panic_on_*) take the limit value(s) instead
> > of being Boolean?  I think this would preserve the current behavior at
> > panic_on_oops = 0 and panic_on_oops = 1, but would introduce your
> > desired behavior at panic_on_oops = 10000.  We can make 10000 the new
> > default.  If a distro overrides panic_on_oops, it probably sets it to 1
> > like RHEL does.
> >
> > Are there distros explicitly setting panic_on_oops to 0?  If so, that
> > could be a reason to introduce the separate oops_limit.
> >
> > I'm not advocating one way or the other - I just felt this should be
> > explicitly mentioned and decided on.
> 
> I think at least internally in the kernel, it probably works better to
> keep those two concepts separate? For example, sparc has a function
> die_nmi() that uses panic_on_oops to determine whether the system
> should panic when a watchdog detects a lockup.

Internally, yes, the kernel should keep "panic_on_oops" to mean "panic
_NOW_ on oops?" but I would agree with Solar -- this is a counter as far
as userspace is concerned. "Panic on Oops" after 1 oops, 2, oopses, etc.
I would like to see this for panic_on_warn too, actually.

-- 
Kees Cook
