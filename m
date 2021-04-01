Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD6AC433B4
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Apr 2021 17:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CF7F61284
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Apr 2021 17:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbhDARpx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:45:53 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:34696 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234796AbhDARkQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Apr 2021 13:40:16 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-236-55FOPC1yNrCSB69XR94FFw-1; Thu, 01 Apr 2021 12:15:44 +0100
X-MC-Unique: 55FOPC1yNrCSB69XR94FFw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Thu, 1 Apr 2021 12:15:43 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Thu, 1 Apr 2021 12:15:43 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Will Deacon' <will@kernel.org>, Kees Cook <keescook@chromium.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v8 3/6] stack: Optionally randomize kernel stack offset
 each syscall
Thread-Topic: [PATCH v8 3/6] stack: Optionally randomize kernel stack offset
 each syscall
Thread-Index: AQHXJtFkunedSLxfaUq504kizLaNqaqfgZOw
Date:   Thu, 1 Apr 2021 11:15:43 +0000
Message-ID: <61ae9398a03d4fe7868b68c9026d5998@AcuMS.aculab.com>
References: <20210330205750.428816-1-keescook@chromium.org>
 <20210330205750.428816-4-keescook@chromium.org>
 <20210401083034.GA8554@willie-the-truck>
In-Reply-To: <20210401083034.GA8554@willie-the-truck>
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

From: Will Deacon
> Sent: 01 April 2021 09:31
...
> > +/*
> > + * These macros must be used during syscall entry when interrupts and
> > + * preempt are disabled, and after user registers have been stored to
> > + * the stack.
> > + */
> > +#define add_random_kstack_offset() do {					\
> > +	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
> > +				&randomize_kstack_offset)) {		\
> > +		u32 offset = __this_cpu_read(kstack_offset);		\
> > +		u8 *ptr = __builtin_alloca(KSTACK_OFFSET_MAX(offset));	\
> > +		asm volatile("" : "=m"(*ptr) :: "memory");		\
> 
> Using the "m" constraint here is dangerous if you don't actually evaluate it
> inside the asm. For example, if the compiler decides to generate an
> addressing mode relative to the stack but with writeback (autodecrement), then
> the stack pointer will be off by 8 bytes. Can you use "o" instead?

Is it allowed to use such a mode?
It would have to know that the "m" was substituted exactly once.
I think there are quite a few examples with 'strange' uses of memory
asm arguments.

However, in this case, isn't it enough to ensure the address is 'saved'?
So:
	asm volatile("" : "=r"(ptr) );
should be enough.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

