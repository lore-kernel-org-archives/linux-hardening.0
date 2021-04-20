Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7448EC433ED
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Apr 2021 22:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FF106140F
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Apr 2021 22:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbhDTW7V (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Apr 2021 18:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbhDTW7V (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Apr 2021 18:59:21 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CADC06174A
        for <linux-hardening@vger.kernel.org>; Tue, 20 Apr 2021 15:58:49 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id h36so9777117lfv.7
        for <linux-hardening@vger.kernel.org>; Tue, 20 Apr 2021 15:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TOGjcz7X/da2vlQcucDwkjw91MaUbIfF1kNjU6kRW7s=;
        b=XMVQ7EZXR/inCJQxuKY4F8FByHUlpnVPZ7gnRyiLNWQWaSYDyemG1ZI5sJqPhIkMJ/
         UbRYezePvtv65k4Jwg2X9j+UEAfUIsdB6ON8/fg8ZDc4EraaQfU0kxv60z0fmz46pmkA
         rVFcCZSGx6xSEIeqfWz9AacxIxPIcw+cdNXwE+ZXvDRe24V8OV/DgHbFO9XiMQvQVTTq
         NAh9DMs6ZsqXJsbw6ZTp3ywkd7Yrdk8WtXm9E7gDc++fqd1zCgi7uEGBt6mWlrKy6IWB
         DLX6F+uIfUfnTHubx7nKB9LGjGBZkgPw3tsY0lvsjlE0J0j0JobjVViWu50Ja1SASKQs
         C+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TOGjcz7X/da2vlQcucDwkjw91MaUbIfF1kNjU6kRW7s=;
        b=blg39h3H+50tfArW0tRH0uMSuW2px8Lt+d5tRfQ7zoIT9VFfTEQ383A/Kk7/dehxKV
         Fk1YQ25g6qrhw1GBiiSrnJ2nlT5fZx7eTUxykcyHxYqJCOJqA8mDNvw5IbW/0oBCNSn9
         TeWZQstZWkF/Wk9JTCkY44lUFo7eMW9ntAx539BE5p6G+G9l5lmBEWDJbhEMKjUW7ZC9
         RFwntSPYZRs49uE+PCgkIdEgJ7hYoNQsR1dN9mUTtOXfec62LyxknivWpEfi1Ae1tn5y
         cbppqnktpO7Wz2DJgsBZkhKf7FakNn2GcqWLI9zG2c7XR8bBYqqvpd39yf7afleGLpJ8
         F9Ww==
X-Gm-Message-State: AOAM532avMPnvvjA2loJHDtvFrRe9KAOkmN05l5d4bec+9AynutnyHQF
        F6q6ckAIdrI1OFPXA8L2pACH83Hmkwn1N/sxrn4rOg==
X-Google-Smtp-Source: ABdhPJzyIqxuOrpCPCAuRllbeq5EJmrg8df1lczPWk9fUaVvpChL43l8Gx1IVciMLG057dXa3AZB8bkI6kBjR0XbEuk=
X-Received: by 2002:a05:6512:985:: with SMTP id w5mr17201660lft.122.1618959527235;
 Tue, 20 Apr 2021 15:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-2-samitolvanen@google.com> <20210420181412.3g5dsyhggxnvif7k@treble>
 <CABCJKudO9Ovuih3ieQ70w8y744Cg3tPnciVBhCuuBPuhq4i3Xg@mail.gmail.com> <20210420225550.szbmrpwv6awd7tp5@treble>
In-Reply-To: <20210420225550.szbmrpwv6awd7tp5@treble>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 20 Apr 2021 15:58:35 -0700
Message-ID: <CAKwvOdkOu4RSw9fwr_qdh7VLHjGD4nLjMZMZxzvpJUqjsWFBww@mail.gmail.com>
Subject: Re: [PATCH 01/15] objtool: Find a destination for jumps beyond the
 section end
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Apr 20, 2021 at 3:57 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Tue, Apr 20, 2021 at 01:25:43PM -0700, Sami Tolvanen wrote:
> > On Tue, Apr 20, 2021 at 11:14 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > On Fri, Apr 16, 2021 at 01:38:30PM -0700, Sami Tolvanen wrote:
> > > > With -ffunction-sections, Clang can generate a jump beyond the end of
> > > > a section when the section ends in an unreachable instruction.
> > >
> > > Why?  Can you show an example?
> >
> > Here's the warning I'm seeing when building allyesconfig + CFI:
> >
> > vmlinux.o: warning: objtool:
> > rockchip_spi_transfer_one.f088382d97b74759d70e27e891fe8f1c()+0x149:
> > can't find jump dest instruction at
> > .text.rockchip_spi_transfer_one.f088382d97b74759d70e27e891fe8f1c+0x7dc
> >
> > $ objdump -d -r -j
> > .text.rockchip_spi_transfer_one.f088382d97b74759d70e27e891fe8f1c
> > vmlinux.o
> > 0000000000000000 <rockchip_spi_transfer_one.f088382d97b74759d70e27e891fe8f1c>:
> >   ...
> >  149:   0f 85 8d 06 00 00       jne    7dc <.compoundliteral.4>
> >   ...
> >  7d7:   e8 00 00 00 00          callq  7dc <.compoundliteral.4>
> >                         7d8: R_X86_64_PLT32     __stack_chk_fail-0x4
>
> Instead of silencing the warning by faking the jump destination, I'd
> rather improve the warning to something like
>
>   "warning: rockchip_spi_transfer_one() falls through to the next function"
>
> which is what we normally do in this type of situation.
>
> It may be caused by UB, or a compiler bug, but either way we should
> figure out the root cause.

We probably want to creduce or cvise this.  IIRC we still have
outstanding issues with switch statements with user-annotated
unreachable branches not getting eliminated.
-- 
Thanks,
~Nick Desaulniers
