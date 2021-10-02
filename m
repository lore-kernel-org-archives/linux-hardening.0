Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43688C433FE
	for <linux-hardening@archiver.kernel.org>; Sat,  2 Oct 2021 16:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2783261B04
	for <linux-hardening@archiver.kernel.org>; Sat,  2 Oct 2021 16:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbhJBQbx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 2 Oct 2021 12:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbhJBQbt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 2 Oct 2021 12:31:49 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA29EC0613EC;
        Sat,  2 Oct 2021 09:30:03 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id y17so5572010ilb.9;
        Sat, 02 Oct 2021 09:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H8go0BCd7H65wVa/X24gvQ3JnQkogTpqfFuo2bWI+s8=;
        b=BVYHvEcKd6Zj+Kj9iKtqxd8Sl+ykv/Yz/sQpws1aH8ImBG2FwI8xBahAh0GDgmMqGE
         47s7yBDOugz56rN1mVEmJwD8NT8tBc8CxAxHRlK2/C45rW5oAdQwMU2gMFLeMXBb6RvL
         IXeYmV9+2ltqmtZ7p/Gnt+rL7HekZCPFpHkPX8GnTg9qh3Xp0mfejWFI62sGuFrBIVh+
         bok3b9g3iG6UMgTvY1O26jq9PCT8ZRjcoyCeZk0eYRXDGKqh2/Y4ZuGEuncAtiuN+o1T
         +b1QHq/8bczcmz4MQakPcefVaAztei2Y3p9aaRnQDjcC58sQJumch0ITszCHUXzmyICo
         U4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H8go0BCd7H65wVa/X24gvQ3JnQkogTpqfFuo2bWI+s8=;
        b=JuzxrwT73wbHwBDoZYl14+o1y6v9avTI4L2jlMitsfLFufyXmGTT4+92nw5CQI+58X
         PurhMG7++5Eqpr1IvQL8aU94L6nU1W4LGoqY6wbib/Yj0gvyxz0FSQQlOfRHR5wu0Wyl
         ZH1SxdrFLn4tWZUXrdLpie1bE0s90/QSMpPudpAkqNVmY0wlC3woRS0Oxee+EtK41P2x
         DHebUtAtHzsIdjDiupEaL6Jm0pdull9/1jhU7DQqRSjhzDuVIBtBO4PI3frU0NfCehcC
         l2+OiKYXzGfXwz1WiXvfO+bMDshLBEod7wDXmkzkPeAu76pSly0/XajMRWP4FU++ieLd
         oGCQ==
X-Gm-Message-State: AOAM530NcJWR2ZKFGyIkE+JGqlxlkTVkGoIcXRdJzVaYb2uJF6bczflB
        HvbxtAMngD+dJHmsR5fI+QBmbTQuWt4YJhI88g4RGYM4jphMyTz8
X-Google-Smtp-Source: ABdhPJy2rWJkZ+eaChFGDRMPhyqbXZoL5TRYoFNoATP3ti5LWy9fFbt+eXabUtPysAcGUqbXxbjySeFQRjyO7F8xR10=
X-Received: by 2002:a05:6e02:19c6:: with SMTP id r6mr3111286ill.321.1633192203205;
 Sat, 02 Oct 2021 09:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210930235754.2635912-1-keescook@chromium.org>
 <CAKwvOdm37zpJZkLvbHvVkXax=XGQ-Ym3iPfx7LtTUnZhADnYCA@mail.gmail.com>
 <YVf80rXg8Yd19Hmw@kroah.com> <CANiq72=T9b_RgZGHuKDjj=E46c0nB2CHH3+Wsdws2Wt9YWcHVw@mail.gmail.com>
 <0cbd2549be1245b445796f6c57a27b910fa4dc9d.camel@perches.com>
In-Reply-To: <0cbd2549be1245b445796f6c57a27b910fa4dc9d.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 2 Oct 2021 18:29:52 +0200
Message-ID: <CANiq72=fOYUjoqjW6+kvf7krqb_AqxmYbkcCwn-Oaw-ApFq9LQ@mail.gmail.com>
Subject: Re: [PATCH v4] docs: Explain the desired position of function attributes
To:     Joe Perches <joe@perches.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Oct 2, 2021 at 5:22 PM Joe Perches <joe@perches.com> wrote:
>
> It's not so much a sort order so much as it's a positional one.

Sure, there are two parts, the order w.r.t. the signature parts (e.g.
"before return type") and the order between the attributes themselves.
Both are included in what I meant.

By the way, clang-format-13 already has a way to pass it a list of the
"attribute macros" (such as `__unused`), so adding more information on
top seems reasonable.

Cheers,
Miguel
