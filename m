Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33748C433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 12 Oct 2021 19:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0749360D07
	for <linux-hardening@archiver.kernel.org>; Tue, 12 Oct 2021 19:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbhJLThb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 12 Oct 2021 15:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbhJLTha (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 12 Oct 2021 15:37:30 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BECC061570;
        Tue, 12 Oct 2021 12:35:29 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1A02E2D3;
        Tue, 12 Oct 2021 19:35:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1A02E2D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1634067328; bh=EgAtlDj4fhvTO94uMQSmyS4JNxVrEFT/socN49pCeyo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=aJIXoKCvtmy5aDtnLdDOZgYcUzIz+zvrbROBAOHw0hfm5Ri/kgDwGF9XJQWPKJr1F
         yLIrsG1OkHJbUz+KlvEibaCVt+JxPWdN8K0M9DQeeSFMBubb7cHFpeHX1RW3x0i3iC
         mE6+ChBnALhXPOQMEitTjrqAedyMQij1Mblm9qb1cvjSZphaQtqNZp5ltL6rpHm4QM
         YdK7c0/xz/UmUnzFkhgujtUTKKr++RZnjpe9a+KzZ07UzhW9tbpQsVQ9oqdiI6qZag
         UeeZZisIB/+2eOuDQK/6EwYA5fnNmb+nErnDqpGP7ronDeWrQqGNLO6Wvt7z40kkN3
         5yLjwJTxyXMdw==
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
        linux-hardening@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH v5] docs: Explain the desired position of function
 attributes
In-Reply-To: <20211005152611.4120605-1-keescook@chromium.org>
References: <20211005152611.4120605-1-keescook@chromium.org>
Date:   Tue, 12 Oct 2021 13:35:27 -0600
Message-ID: <87mtneujcw.fsf@meer.lwn.net>
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
> v5:
> - drop extern (joe)
> - fix __malloc position (miguel)
> v4: https://lore.kernel.org/lkml/20210930235754.2635912-1-keescook@chromium.org
> ---
>  Documentation/process/coding-style.rst | 37 +++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)

I've applied this, thanks.

jon
