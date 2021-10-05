Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB27BC433FE
	for <linux-hardening@archiver.kernel.org>; Tue,  5 Oct 2021 15:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B265D61131
	for <linux-hardening@archiver.kernel.org>; Tue,  5 Oct 2021 15:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbhJEPlK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 5 Oct 2021 11:41:10 -0400
Received: from smtprelay0237.hostedemail.com ([216.40.44.237]:52002 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235510AbhJEPlK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 5 Oct 2021 11:41:10 -0400
Received: from omf14.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 3D34218023431;
        Tue,  5 Oct 2021 15:39:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id 40ABF268E40;
        Tue,  5 Oct 2021 15:39:16 +0000 (UTC)
Message-ID: <7f6e53d04849daabd3e85c23f9974b2eb4a20c13.camel@perches.com>
Subject: Re: [PATCH v5] docs: Explain the desired position of function
 attributes
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 05 Oct 2021 08:39:14 -0700
In-Reply-To: <20211005152611.4120605-1-keescook@chromium.org>
References: <20211005152611.4120605-1-keescook@chromium.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: d93h65981twpu9xb5t5gm9xwms5aac86
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 40ABF268E40
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+gLwb8Zq/2h+GassA6/3wo/iCEkKB2LdA=
X-HE-Tag: 1633448356-978975
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, 2021-10-05 at 08:26 -0700, Kees Cook wrote:
> While discussing how to format the addition of various function
> attributes, some "unwritten rules" of ordering surfaced[1]. Capture as
> close as possible to Linus's preferences for future reference.
> +For example, using this function declaration example::
> +
> + __init void * __must_check action(enum magic value, size_t size, u8 count,
> +				   char *fmt, ...) __printf(4, 5) __malloc;

trivia: almost all fmt declarations should be const char *

> +Note that for a function **definition** (i.e. the actual function body),
> +the compiler does not allow function parameter attributes after the
> +function parameters. In these cases, they should go after the storage
> +class attributes (e.g. note the changed position of ``__printf(4, 5)``
> +below, compared to the **declaration** example above)::
> +
> + static __always_inline __init __printf(4, 5) void * __must_check action(enum magic value,
> +		size_t size, u8 count, char *fmt, ...) __malloc

here too, and 80 columns?

> + {
> +	...
> + }

Or just put all the attributes before the storage class... <grumble/chuckle>

cheers, Joe

