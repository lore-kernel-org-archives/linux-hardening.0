Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15445C433FE
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Oct 2021 15:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA7ED61090
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Oct 2021 15:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbhJOP5b (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Oct 2021 11:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbhJOP5b (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Oct 2021 11:57:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7698AC061570;
        Fri, 15 Oct 2021 08:55:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634313323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sFrKPQRzDTKs0QNA4mzAX7Wpe5TO8YTE5o8WYqOKeDs=;
        b=gijAJFHIcbUh9LlKhz+b8pZZHFCP4uYbKvBkMt2yaZSzUj9mnNfFbgXutfB5sgZvwlpbFK
        brLdXbTaboyu9xuuT6rXSOowyLUBdH3/JOq/EP8OQMri9RQyaG6hHAytKesFsrF6P8XKrM
        OG5Q5C5nI7NcuN3IwRGPlgfpk7CY4KNYieXHj8bRZzJV6gsZjNZDV3289/Jo6WXveOxU99
        H5XU9Y/3D2x5+e1o6ByUKtt4azsRaIxCFeEUK44x/F7jfwBL9A/NuR9dEH3ZnK5aWzPzIB
        BJnbXbme5143vkUD5DNTB8qCnS7xgrc31C5Mc59/40UvA+yLqy0VPpI5SXCfqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634313323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sFrKPQRzDTKs0QNA4mzAX7Wpe5TO8YTE5o8WYqOKeDs=;
        b=pSsHnrcLqmy+2ohuajOXale7osrdx/UQbalyx0Q6La/AG+Xq5YkKptrunxW9PcgrVUhBVG
        1GZj3RWM2dyqjpCQ==
To:     Andy Lutomirski <luto@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        the arch/x86 maintainers <x86@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 03/15] linkage: Add DECLARE_NOT_CALLED_FROM_C
In-Reply-To: <7377e6b9-7130-4c20-a0c8-16de4620c995@www.fastmail.com>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-4-samitolvanen@google.com>
 <7377e6b9-7130-4c20-a0c8-16de4620c995@www.fastmail.com>
Date:   Fri, 15 Oct 2021 17:55:22 +0200
Message-ID: <8735p25llh.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 14 2021 at 19:51, Andy Lutomirski wrote:
> On Wed, Oct 13, 2021, at 11:16 AM, Sami Tolvanen wrote:
>>=20
>> +/*
>> + * Declares a function not callable from C using an opaque type. Define=
d as
>> + * an array to allow the address of the symbol to be taken without '&'.
>> + */
> I=E2=80=99m not convinced that taking the address without using & is a
> laudable goal.  The magical arrays-are-pointers-too behavior of C is a
> mistake, not a delightful simplification.

>> +#ifndef DECLARE_NOT_CALLED_FROM_C
>> +#define DECLARE_NOT_CALLED_FROM_C(sym) \
>> +	extern const u8 sym[]
>> +#endif
>

> The relevant property of these symbols isn=E2=80=99t that they=E2=80=99re=
 not called
> from C.  The relevant thing is that they are just and not objects of a
> type that the programmer cares to tell the compiler about. (Or that
> the compiler understands, for that matter. On a system with XO memory
> or if they=E2=80=99re in a funny section, dereferencing them may fail.)

I agree.

> So I think we should use incomplete structs, which can=E2=80=99t be
> dereferenced and will therefore be less error prone.

While being late to that bike shed painting party, I really have to ask
the question _why_ can't the compiler provide an annotation for these
kind of things which:

    1) Make the build fail when invoked directly

    2) Tell CFI that this is _NOT_ something it can understand

-void clear_page_erms(void *page);
+void __bikeshedme clear_page_erms(void *page);

That still tells me:

    1) This is a function
=20=20=20=20
    2) It has a regular argument which is expected to be in RDI

which even allows to do analyis of e.g. the alternative call which
invokes that function.

DECLARE_NOT_CALLED_FROM_C(clear_page_erms);

loses these properties and IMO it's a tasteless hack.

Thanks,

        tglx

