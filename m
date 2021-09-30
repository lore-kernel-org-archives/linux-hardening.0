Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB74AC433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 20:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A18E661452
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 20:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347755AbhI3UNT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 30 Sep 2021 16:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhI3UNT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 30 Sep 2021 16:13:19 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD27DC06176A;
        Thu, 30 Sep 2021 13:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=frnqrRQEmQ2qXthtZ/tUxaZKTEUU2n+onTUbyF2hXT4=; b=Pr4aDxLnQfKJXJw7OheAivO06p
        PlK6/A+tsLbWipUn1Lj4F3ekg6zuRWwZ63grpsFa9sIPNNPSgK2nDXXdW3ohKLZwuN0JCnyuhXAlY
        WuH5MxRtZTPDcebYpJXjgKMyanpzgGx741a7Rz5OY2KpzTTSmaTWRFH5s2hqreE806cLp/zI1T2tR
        E8ZD/qqiMPVy51EFF4qeAYe2Ga15CzMsU38kZAqDoYc0Ln3rPexN21W/QkyG5LHEystzazXUo2Zo1
        SuWsz0i+ZYR8Ewr8AzdbsLjqy6oOFzRo7Gk03cq1hs+WPVEKgwUcuOuDJ5ucHRiJ/8IfdW3kddITL
        MKya+VUg==;
Received: from c-73-157-219-8.hsd1.or.comcast.net ([73.157.219.8] helo=[10.0.0.153])
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mW2P1-00FxDm-EM; Thu, 30 Sep 2021 20:11:35 +0000
Subject: Re: [PATCH v2] docs: Explain the desired position of function
 attributes
To:     Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Joe Perches <joe@perches.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210930192417.1332877-1-keescook@chromium.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c273a5d9-ecd7-64fa-bf2c-af0d22c4a68c@infradead.org>
Date:   Thu, 30 Sep 2021 13:11:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210930192417.1332877-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 9/30/21 12:24 PM, Kees Cook wrote:
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
>   Documentation/process/coding-style.rst | 30 ++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 42969ab37b34..6b4feb1c71e7 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -487,6 +487,36 @@ because it is a simple way to add valuable information for the reader.
>   Do not use the ``extern`` keyword with function prototypes as this makes
>   lines longer and isn't strictly necessary.
>   
> +When writing a function declarations, please keep the `order of elements regular
> +<https://lore.kernel.org/mm-commits/CAHk-=wiOCLRny5aifWNhr621kYrJwhfURsa0vFPeUEm8mF0ufg@mail.gmail.com/>`_.
> +For example::
> +
> + extern __init void * __must_check void action(enum magic value, size_t size,

Drop that second "void" ?  or what does it mean?
Can __must_check and void be used together?

> + 	u8 count, char *fmt, ...) __printf(4, 5) __malloc;
> +
> +The preferred order of elements for a function prototype is:
> +
> +- storage class (here, ``extern``, and things like ``static __always_inline`` even though
> +  ``__always_inline`` is technically an attribute, it is treated like ``inline``)
> +- storage class attributes (here, ``__init`` -- i.e. section declarations, but also things like ``__cold``)
> +- return type (here, ``void *``)
> +- return type attributes (here, ``__must_check``)

I'm not trying to get you to change this, but I would prefer to see

extern __init __must_check void *action(...) <attributes>;

i.e., with the return type adjacent to the function name.

> +- function name (here, ``action``)
> +- function parameters (here, ``(enum magic value, size_t size, u8 count, char *fmt, ...)``, noting that parameter names should always be included)
> +- function parameter attributes (here, ``__printf(4, 5)``)
> +- function behavior attributes (here, ``__malloc``)
> +
> +Note that for a function definition (e.g. ``static inline``), the compiler does
> +not allow function parameter attributes after the function parameters. In these
> +cases, they should go after the storage class attributes (e.g. note the changed
> +position of ``__printf(4, 5)``)::
> +
> + static __always_inline __init __printf(4, 5) void * __must_check void action(
> + 		enum magic value, size_t size, u8 count, char *fmt, ...)
> + 		__malloc
> + {
> + 	...
> + }
>   
>   7) Centralized exiting of functions
>   -----------------------------------
> 

thanks.
-- 
~Randy
