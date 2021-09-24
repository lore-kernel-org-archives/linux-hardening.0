Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F42C433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Sep 2021 20:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C635560FDC
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Sep 2021 20:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344741AbhIXU26 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 24 Sep 2021 16:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344335AbhIXU25 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 24 Sep 2021 16:28:57 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C84C061571;
        Fri, 24 Sep 2021 13:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=skD/cZCNH8R8F4DM7qf42ZhB6cHTkIJXOzzw79kAsi0=; b=A/gY15IL7NXln2jUBwDOMDRjCB
        9ZUi+IA1PiY01O2ZsoVDzjFrdxYcu+1gB2NLC5Qjnmof4COu3glftgq6qoqBzYRWnCWvhV4w7QrPC
        f1mQgXDULuUhimPxIy6tV1VOsKm7rpecIJEYBuYYdsMLd+zTg9V9puR0XIRwZes3HFWwhm/ZHhGdI
        Dt+dEpvNVKWLZbYzhu/wj3fpjnFskx51WKRgg54kWDOzWs8wCawi6AddtWQzuA/xS0akkkNSggeNe
        cZwpYqgI/oIlmYb3T/a7kwtKrK8qwuP+m+ui4mW51OtCxWBKaq7DFvKuk1QBovavtZwxxAWIBGgRV
        fpq1v1Cg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTrn0-00FTAn-Dv; Fri, 24 Sep 2021 20:27:22 +0000
Subject: Re: [PATCH] docs: Explain the desired position of function attributes
To:     Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210924202302.2335542-1-keescook@chromium.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <053717cf-e1b3-15a4-97e6-e72848f6d7bd@infradead.org>
Date:   Fri, 24 Sep 2021 13:27:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210924202302.2335542-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 9/24/21 1:23 PM, Kees Cook wrote:
> While discussing how to format the addition of various function
> attributes, some "unwritten rules" of ordering surfaced[1]. Capture a
> synthesized version of Linus's, Joe's, and Rasmus's recommendations on
> this subject for future reference.
> 
> [1] https://lore.kernel.org/mm-commits/CAHk-=wiOCLRny5aifWNhr621kYrJwhfURsa0vFPeUEm8mF0ufg@mail.gmail.com
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   Documentation/process/coding-style.rst | 27 ++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 42969ab37b34..3559c34a9281 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -487,6 +487,33 @@ because it is a simple way to add valuable information for the reader.
>   Do not use the ``extern`` keyword with function prototypes as this makes
>   lines longer and isn't strictly necessary.
>   
> +When writing a function prototype, please keep the `order of elements regular
> +<https://lore.kernel.org/mm-commits/CAHk-=wiOCLRny5aifWNhr621kYrJwhfURsa0vFPeUEm8mF0ufg@mail.gmail.com>`_. For example::
> +
> +	__must_check __printf(4, 5) __malloc __init
> +	static __always_inline void *action(enum magic value, size_t size,
> +					    u8 count, char *fmt, ...)
> +	{
> +		...
> +	}
> +
> +The preferred order of elements for a function prototype is:
> +
> +- attributes on the preceding lines
> +

I thought that idea was already nacked: (it's more of a BSD thing AFAIK)
(and I would NAK it if I could :)

"""
> Attributes should be on their own line, they can be quite lengthy.

No, no no. They really shouldn't.
""

from: https://lore.kernel.org/mm-commits/CAHk-=wjS-Jg7sGMwUPpDsjv392nDOOs0CtUtVkp=S6Q7JzFJRw@mail.gmail.com/

> +  - return type attributes (here, ``__must_check``)
> +  - function parameter attributes (here, ``__printf(4,5)``)
> +  - function behavior attributes (here, ``__malloc``)
> +  - storage class attributes (here, ``__init``)
> +
> +- main function prototype on the next lines
> +
> +  - storage class (here, ``static __always_inline`` -- even though
> +    ``__always_inline`` is technically an attribute, it is treated like
> +    ``inline``)
> +  - return type (here, ``void *``)
> +  - function name (here, ``action``)
> +  - function parameters (as described earlier: each with type and name)
>   
>   7) Centralized exiting of functions
>   -----------------------------------
> 


-- 
~Randy
