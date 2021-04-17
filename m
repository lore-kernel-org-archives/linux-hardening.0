Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEE4C433ED
	for <linux-hardening@archiver.kernel.org>; Sat, 17 Apr 2021 14:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E05E66120C
	for <linux-hardening@archiver.kernel.org>; Sat, 17 Apr 2021 14:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbhDQOUq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 17 Apr 2021 10:20:46 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:29608 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233008AbhDQOUq (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 17 Apr 2021 10:20:46 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-238-fScdoKE0NyuCErCmE_g1LQ-1; Sat, 17 Apr 2021 15:20:17 +0100
X-MC-Unique: fScdoKE0NyuCErCmE_g1LQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Sat, 17 Apr 2021 15:20:16 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Sat, 17 Apr 2021 15:20:16 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kees Cook' <keescook@chromium.org>,
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
Thread-Index: AQHXMw/PuSsNstP2FUia6sIzu9nmdKq4wQCQ
Date:   Sat, 17 Apr 2021 14:20:16 +0000
Message-ID: <a8653ebf0a52498888f728524ebaa110@AcuMS.aculab.com>
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-6-samitolvanen@google.com>
 <20210416211855.GD22348@zn.tnic>
 <CABCJKud8TvzhcjHCpsrtCJ4B50ZUfaL48F42EhZ2zWKLteAc0Q@mail.gmail.com>
 <20210416220251.GE22348@zn.tnic>
 <CALCETrVTtKqD6fonUmT_qr0HJ0X9TWzLGq-wpm+A7XKyjn3W5g@mail.gmail.com>
 <202104161519.1D37B6D26@keescook>
In-Reply-To: <202104161519.1D37B6D26@keescook>
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

From: Kees Cook
> Sent: 16 April 2021 23:28
> 
> On Fri, Apr 16, 2021 at 03:06:17PM -0700, Andy Lutomirski wrote:
> > On Fri, Apr 16, 2021 at 3:03 PM Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > On Fri, Apr 16, 2021 at 02:49:23PM -0700, Sami Tolvanen wrote:
> > > > __nocfi only disables CFI checking in a function, the compiler still
> > > > changes function addresses to point to the CFI jump table, which is
> > > > why we need function_nocfi().
> > >
> > > So call it __func_addr() or get_function_addr() or so, so that at least
> > > it is clear what this does.
> > >
> >
> > This seems backwards to me.  If I do:
> >
> > extern void foo(some signature);
> >
> > then I would, perhaps naively, expect foo to be the actual symbol that
> > gets called
> 
> Yes.
> 
> > and for the ABI to be changed to do the CFI checks.
> 
> Uh, no? There's no ABI change -- indirect calls are changed to do the
> checking.
> 
> > The
> > foo symbol would point to whatever magic is needed.
> 
> No, the symbol points to the jump table entry. Direct calls get minimal
> overhead and indirect calls can add the "is this function in the right
> table" checking.


Isn't this a bit like one of the PPC? ABI where function addresses
aren't (always) the entry point.
IIRC is causes all sorts of obscure grief.

I'd also like to know how indirect calls are actually expected to work.
The whole idea is that the potential targets might be in a kernel module
that is loaded at run time.

Scanning a list of possible targets has to be a bad design decision.

If you are trying to check that the called function has the right
prototype, stashing a hash of the prototype (or a known random number)
before the entry point would give most of the benefits without most
of the costs.
The linker could be taught to do the same test (much like name mangling
but without the crap user experience).

That scheme only has the downside of a data cache miss and (hopefully)
statically predicted correct branch (hmm - except you don't want to
speculatively execute the wrong function) and polluting the data cache
with code.

This all seems like a ploy to force people to buy faster cpus.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

