Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AC6C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 12:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C6DA6109E
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 12:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbhJ0M5q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 27 Oct 2021 08:57:46 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:35526 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236131AbhJ0M5q (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 27 Oct 2021 08:57:46 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-253-wPONUwz2OL6lc0R2QWVEYg-1; Wed, 27 Oct 2021 13:55:18 +0100
X-MC-Unique: wPONUwz2OL6lc0R2QWVEYg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.24; Wed, 27 Oct 2021 13:55:17 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.024; Wed, 27 Oct 2021 13:55:17 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mark Rutland' <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Sami Tolvanen <samitolvanen@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "ardb@kernel.org" <ardb@kernel.org>
Subject: RE: [PATCH v5 00/15] x86: Add support for Clang CFI
Thread-Topic: [PATCH v5 00/15] x86: Add support for Clang CFI
Thread-Index: AQHXyyrmFu1L74SRSES6mpaoExEoXavmyV5Q
Date:   Wed, 27 Oct 2021 12:55:17 +0000
Message-ID: <456321a9fc5245408fc0d2798e497fe0@AcuMS.aculab.com>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211026201622.GG174703@worktop.programming.kicks-ass.net>
 <20211027120515.GC54628@C02TD0UTHF1T.local>
In-Reply-To: <20211027120515.GC54628@C02TD0UTHF1T.local>
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

From: Mark Rutland
> Sent: 27 October 2021 13:05
...
> Taking a step back, it'd be nicer if we didn't have the jump-table shim
> at all, and had some SW landing pad (e.g. a NOP with some magic bytes)
> in the callees that the caller could check for. Then function pointers
> would remain callable in call cases, and we could explcitly add landing
> pads to asm to protect those. I *think* that's what the grsecurity folk
> do, but I could be mistaken.

It doesn't need to be a 'landing pad'.
The 'magic value' could be at 'label - 8'.

Provided you can generate the required value it could be added
to asm functions.
(Or you could patch it at startup by stealing the value from
a C function.)

Depending on the threat model, you may even want the called function
to do some sanity checks on the caller.

I suspect that anything you do is easy to subvert by anything that
can actually write asm.
So if the real threat is overwritten function tables then something
relatively simple is adequate.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

