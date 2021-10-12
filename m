Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0366EC433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 12 Oct 2021 20:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E0260295
	for <linux-hardening@archiver.kernel.org>; Tue, 12 Oct 2021 20:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbhJLUZG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 12 Oct 2021 16:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbhJLUZF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 12 Oct 2021 16:25:05 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB7AC061570;
        Tue, 12 Oct 2021 13:23:03 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 70101867;
        Tue, 12 Oct 2021 20:23:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 70101867
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1634070183; bh=PhDRRDsbPgnqz354Ak81v6Z2JVw2XYiMO3GaAtKamAA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZUC13kaJI2qTg6EA4kJjdIOd5hC1SwCjo2joucD4AVP6VuqOb5/7OfvzX286+onpe
         aJpnILxlFZl2KcfOndpF9C5Ggkyc4Lb502D8FTlk++YIMUrS6hnJYClT0Fw9W6mMcc
         KfP/hTUDBFciTMMDtVYTd+kjm8ppP6rKYAxNYPkvLnM3RS1j/vgo3zDj+83ISHZqv5
         A0pGYS89nCb46qNU/7MObv4pRa8p1L4VQoesQqzYkMWy/+XHeDMLjiBBY9KHUqFOYc
         sN4xGavwjecHL6vYFO/weYCaFvIXWwdQVXPowxvVqq1G1x+bkm4/+Txy/S2qNGhydd
         Kw32xgx78XZXw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Joe Perches <joe@perches.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scripts: kernel-doc: Ignore __alloc_size() attribute
In-Reply-To: <20211011180650.3603988-1-keescook@chromium.org>
References: <20211011180650.3603988-1-keescook@chromium.org>
Date:   Tue, 12 Oct 2021 14:23:02 -0600
Message-ID: <87sfx6t2l5.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> Fixes "Compiler Attributes: add __alloc_size() for better bounds checking"
> so that the __alloc_size() macro is ignored for function prototypes when
> generating kerndoc. Avoids warnings like:
>
> ./include/linux/slab.h:662: warning: Function parameter or member '1' not described in '__alloc_size'
> ./include/linux/slab.h:662: warning: Function parameter or member '2' not described in '__alloc_size'
> ./include/linux/slab.h:662: warning: expecting prototype for kcalloc().  Prototype was for __alloc_size() instead
>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  scripts/kernel-doc | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

jon
