Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910C3C433B4
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Apr 2021 21:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66AC561363
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Apr 2021 21:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhDSVxX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 19 Apr 2021 17:53:23 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:50536 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229914AbhDSVxW (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 19 Apr 2021 17:53:22 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-122-5PwNCrjSNRSPg_lGIzvSdg-1; Mon, 19 Apr 2021 22:52:49 +0100
X-MC-Unique: 5PwNCrjSNRSPg_lGIzvSdg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 19 Apr 2021 22:52:49 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Mon, 19 Apr 2021 22:52:49 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Rasmus Villemoes' <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
CC:     Borislav Petkov <bp@alien8.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: RE: [PATCH 05/15] x86: Implement function_nocfi
Thread-Topic: [PATCH 05/15] x86: Implement function_nocfi
Thread-Index: AQHXNPeauSsNstP2FUia6sIzu9nmdKq8X6yA
Date:   Mon, 19 Apr 2021 21:52:48 +0000
Message-ID: <a40525ea67144351a1baab99739fef52@AcuMS.aculab.com>
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-6-samitolvanen@google.com>
 <20210416211855.GD22348@zn.tnic>
 <CABCJKud8TvzhcjHCpsrtCJ4B50ZUfaL48F42EhZ2zWKLteAc0Q@mail.gmail.com>
 <20210416220251.GE22348@zn.tnic>
 <CALCETrVTtKqD6fonUmT_qr0HJ0X9TWzLGq-wpm+A7XKyjn3W5g@mail.gmail.com>
 <202104161519.1D37B6D26@keescook>
 <2812c98b-3b5a-7be5-9fd9-2a6260406a45@rasmusvillemoes.dk>
In-Reply-To: <2812c98b-3b5a-7be5-9fd9-2a6260406a45@rasmusvillemoes.dk>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Rasmus Villemoes
> Sent: 19 April 2021 09:40
> 
> On 17/04/2021 00.28, Kees Cook wrote:
> > On Fri, Apr 16, 2021 at 03:06:17PM -0700, Andy Lutomirski wrote:
> 
> >> The
> >> foo symbol would point to whatever magic is needed.
> >
> > No, the symbol points to the jump table entry. Direct calls get minimal
> > overhead and indirect calls can add the "is this function in the right
> > table" checking.
> >
> >
> > But note that this shouldn't turn into a discussion of "maybe Clang could
> > do CFI differently"; this is what Clang has.
> 
> Why not? In particular, I'd really like somebody to answer the question
> "why not just store a cookie before each address-taken or
> external-linkage function?".
> 
> (1) direct calls get _no_ overhead, not just "minimal".
> (2) address comparison, intra- or inter-module, Just Works, no need to
> disable one sanity check to get others.
> (3) The overhead and implementation of the signature check is the same
> for inter- and intra- module calls.
> (4) passing (unsigned long)sym into asm code or stashing it in a table
> Just Works.
> 
> How much code would be needed on the clang side to provide a
> --cfi-mode=inline ?
> 
> The only issue, AFAICT, which is also a problem being handled in the
> current proposal, is indirect calls to asm code from C. They either have
> to be instrumented to not do any checking (which requires callers to
> know that the pointer they have might point to an asm-implementation),
> or the asm code could be taught to emit those cookies as well - which
> would provide even better coverage. Something like
> 
> CFI_COOKIE(foo)
> foo:
>   ...
> 
> with CFI_COOKIE expanding to nothing when !CONFIG_CFI, and otherwise to
> (something like) ".quad cfi_cookie__foo" ; with some appropriate Kbuild
> and compiler magic to generate a table of cfi_cookie__* defines from a
> header file with the prototypes.

I'm wondering what 'threat models' CFI is trying to protect from.
Adding code to code doing 'call indirect' can only protect against
calls to 'inappropriate' functions.
You may also be worried about whether functions are being called
from the right place - someone might manage to 'plant' an indirect
jump somewhere - probably more likely than overwriting an address.
But a truly malicious caller will be able to subvert most checks.
And non-malicious errors can be largely eliminated by strengthening
normal compiler type checking.

A simple run-time check would be adding an extra 'hidden' function
parameter that is a hash of the prototype.
Especially if the hash is based on a build-id - so differs
between kernel builds.

Having the caller scan a list of valid targets seems just broken.
You might as well replace the function pointer with an index
into the array of valid targets.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

