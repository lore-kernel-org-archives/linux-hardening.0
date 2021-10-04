Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEB8C433EF
	for <linux-hardening@archiver.kernel.org>; Mon,  4 Oct 2021 23:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9C3B6124F
	for <linux-hardening@archiver.kernel.org>; Mon,  4 Oct 2021 23:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbhJDXLL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 4 Oct 2021 19:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbhJDXLK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 4 Oct 2021 19:11:10 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A3AC061745
        for <linux-hardening@vger.kernel.org>; Mon,  4 Oct 2021 16:09:20 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 50BEA378;
        Mon,  4 Oct 2021 23:09:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 50BEA378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1633388959; bh=WY8Y6y6UjjwWM+HK524Y+68HFmY2ttlxdfLfrk+Bsw0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=A2+jS4fkMCbRXQ7lW+HNJ/f+Oa2E0VIIyNscdvsXiBRMFQgsT6UKszO8wU3P1MkXr
         2r2/JPI0UpOWjh88QH6wor5ALfuoz4PPgXVlPtwga33ATkHfnWoQ5vrQvlBcRh3zGF
         ctd9aTU/HINbzg6pYqX7tMzU1o3CzhIbbTwJNENKcWuvUhi3p/Ycatt0pleAAOy3th
         o7ydg5mKxaFos4W/Ct98RM+2YN22uKGuwRyvRwCk2VSiATLMvYMYhKPL/y0MoDf0FK
         YECMXb8m7bIeHZ44/XxLTibf0SzaDR3tbHa/pta2FgZc8c1pAw7R6dp4/Uf3SyFDQi
         +pIMLDV1VYNoA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] docs: Explain the desired position of function
 attributes
In-Reply-To: <20210930235754.2635912-1-keescook@chromium.org>
References: <20210930235754.2635912-1-keescook@chromium.org>
Date:   Mon, 04 Oct 2021 17:09:18 -0600
Message-ID: <87h7dw75gh.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> While discussing how to format the addition of various function
> attributes, some "unwritten rules" of ordering surfaced[1]. Capture as
> close as possible to Linus's preferences for future reference.
>
> (Though I note the dissent voiced by Joe Perches, Alexey Dobriyan, and
> others that would prefer all attributes live on a separate leading line.)
>
> [1] https://lore.kernel.org/mm-commits/CAHk-=wiOCLRny5aifWNhr621kYrJwhfURsa0vFPeUEm8mF0ufg@mail.gmail.com/
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v4:
> - fix another stray "void"! This is why code needs a compiler... (thx randy)
> ---
>  Documentation/process/coding-style.rst | 30 ++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

Did I ever mention that I *hate* coding-style patches? :)

In this case I think we're as close as to consensus as things get.  In
the absence of a strong reason to the contrary, I'll apply this before
too long.

Thanks,

jon
