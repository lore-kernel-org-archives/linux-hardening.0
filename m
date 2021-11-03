Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076E6C433EF
	for <linux-hardening@archiver.kernel.org>; Wed,  3 Nov 2021 10:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E22E860F70
	for <linux-hardening@archiver.kernel.org>; Wed,  3 Nov 2021 10:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhKCKEV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 3 Nov 2021 06:04:21 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:60027 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231755AbhKCKEU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 3 Nov 2021 06:04:20 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-46-D8J9dP9POlyetI0EQ9wyKQ-1; Wed, 03 Nov 2021 10:01:41 +0000
X-MC-Unique: D8J9dP9POlyetI0EQ9wyKQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.24; Wed, 3 Nov 2021 10:01:40 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.024; Wed, 3 Nov 2021 10:01:40 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
CC:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Sami Tolvanen" <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [PATCH] static_call,x86: Robustify trampoline patching
Thread-Topic: [PATCH] static_call,x86: Robustify trampoline patching
Thread-Index: AQHX0I3T+Rz8ZcLBT06sRWcPs/oqcKvxiwhw
Date:   Wed, 3 Nov 2021 10:01:40 +0000
Message-ID: <af7756b2244e47b7b7fae534236dac30@AcuMS.aculab.com>
References: <CAMj1kXG+MuGaG3BHk8pnE1MKVmRf5E+nRNoFMHxOA1y84eGikg@mail.gmail.com>
 <YX8AQJqyB+H3PF1d@hirez.programming.kicks-ass.net>
 <CAMj1kXF3n-oQ1WP8=asb60K6UjSYOtz5RVhrcoCoNq3v7mZdQg@mail.gmail.com>
 <20211101090155.GW174703@worktop.programming.kicks-ass.net>
 <CAMj1kXGhRmdM3om289Q2-s1Pzfob3D2iSDMorzggfhSk1oj53A@mail.gmail.com>
 <YYE1yPClPMHvyvIt@hirez.programming.kicks-ass.net>
 <202111021040.6570189A5@keescook>
 <90a14299-ce56-41d5-9df9-f625aae1ac70@www.fastmail.com>
 <202111021603.EDE5780FE@keescook>
 <bbde172b-2dae-fdc0-fbb5-edec6752c740@kernel.org>
 <20211103083559.GB174703@worktop.programming.kicks-ass.net>
In-Reply-To: <20211103083559.GB174703@worktop.programming.kicks-ass.net>
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

From: Peter Zijlstra
> Sent: 03 November 2021 08:36
> 
> On Tue, Nov 02, 2021 at 05:20:05PM -0700, Andy Lutomirski wrote:
> > I think that's a big mistake -- any sane ENDBR-using scheme would
> > really prefer that ENDBR to be right next to the actual function body,
> > and really any scheme would benefit due to better cache locality.
> 
> Agreed, IBT/BTI want the landing pad in front of the actual function.
> 
> > But, more importantly, IMO any sane ENDBR-using scheme wants to
> > generate the indirect stub as part of code gen for the actual
> > function.
> 
> Sorta, I really want to be able to not have a landing pad for functions
> whose address is never taken. At that point it doesn't matter if it gets
> generated along with the function and then stripped/poisoned later, or
> generated later.
> 
> As such, the landing pad should not be part of the function proper,
> direct calls should never observe it.
> 
> Less landing pads is more better.

One problem is when a direct call is 'too far' for a call instruction.
IIRC this can happen in arm64 with modules (all 64bit except x86?).
So an indirect call has to be used instead - which needs the landing pad.
Although it may actually be better to put a trampoline (landing pad
+ near jump) elsewhere and have the module loader do the correct fixup.
(Is the loader already generating a trampoline in the module code?)
The function body can then be cache-line aligned - with its benefits.

Can't anything that can write instructions always use a retpoline
to implement a jump indirect to an arbitrary address?
(Not to mention just generating the required code rather than a call.)

AFAICT CFI is all about detecting invalid values in function pointer tables.
It doesn't really protect in any way from JIT code doing incorrect things.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

