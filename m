Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8114C433EF
	for <linux-hardening@archiver.kernel.org>; Fri,  1 Oct 2021 01:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98FC561411
	for <linux-hardening@archiver.kernel.org>; Fri,  1 Oct 2021 01:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351045AbhJABSk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 30 Sep 2021 21:18:40 -0400
Received: from smtprelay0063.hostedemail.com ([216.40.44.63]:49436 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1350757AbhJABSj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 30 Sep 2021 21:18:39 -0400
Received: from omf03.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id B778D1844CABE;
        Fri,  1 Oct 2021 01:16:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id 213F713D94;
        Fri,  1 Oct 2021 01:16:54 +0000 (UTC)
Message-ID: <d6472a0e635941de55b83ba2ec3e673a74a123b6.camel@perches.com>
Subject: Re: [PATCH v2] docs: Explain the desired position of function
 attributes
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org
Date:   Thu, 30 Sep 2021 18:16:53 -0700
In-Reply-To: <20210930192417.1332877-1-keescook@chromium.org>
References: <20210930192417.1332877-1-keescook@chromium.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 213F713D94
X-Stat-Signature: ujgbpioktaqsrtjrxgy5rahpxik4n9gj
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+AIz+C5GLAKLO+2UlaBU/F6jtP3ogEOmw=
X-HE-Tag: 1633051014-100887
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 2021-09-30 at 12:24 -0700, Kees Cook wrote:
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
>  Documentation/process/coding-style.rst | 30 ++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 42969ab37b34..6b4feb1c71e7 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -487,6 +487,36 @@ because it is a simple way to add valuable information for the reader.
>  Do not use the ``extern`` keyword with function prototypes as this makes
>  lines longer and isn't strictly necessary.
>  
> 
> +When writing a function declarations, please keep the `order of elements regular
> +<https://lore.kernel.org/mm-commits/CAHk-=wiOCLRny5aifWNhr621kYrJwhfURsa0vFPeUEm8mF0ufg@mail.gmail.com/>`_.
> +For example::
> +
> + extern __init void * __must_check void action(enum magic value, size_t size,
> + 	u8 count, char *fmt, ...) __printf(4, 5) __malloc;
> +

Read the paragraph above.  extern should not be used in an example.

> +The preferred order of elements for a function prototype is:
> +
> +- storage class (here, ``extern``, and things like ``static __always_inline`` even though
> +  ``__always_inline`` is technically an attribute, it is treated like ``inline``)
> +- storage class attributes (here, ``__init`` -- i.e. section declarations, but also things like ``__cold``)
> +- return type (here, ``void *``)
> +- return type attributes (here, ``__must_check``)
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
> 
>  7) Centralized exiting of functions
>  -----------------------------------


