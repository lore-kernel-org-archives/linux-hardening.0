Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30471C433ED
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Apr 2021 15:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05B5161246
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Apr 2021 15:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbhDSP1L (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 19 Apr 2021 11:27:11 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:39203 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238601AbhDSP1K (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 19 Apr 2021 11:27:10 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-83-1fpuH_pNMbiwBnHi01lYDQ-1; Mon, 19 Apr 2021 16:26:37 +0100
X-MC-Unique: 1fpuH_pNMbiwBnHi01lYDQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 19 Apr 2021 16:26:36 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Mon, 19 Apr 2021 16:26:36 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Lutomirski' <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@alien8.de>,
        "Sami Tolvanen" <samitolvanen@google.com>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: RE: [PATCH 05/15] x86: Implement function_nocfi
Thread-Topic: [PATCH 05/15] x86: Implement function_nocfi
Thread-Index: AQHXM+diuSsNstP2FUia6sIzu9nmdKq7+HvQ
Date:   Mon, 19 Apr 2021 15:26:36 +0000
Message-ID: <c0af9b5811cf4066b7297196bc46456f@AcuMS.aculab.com>
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-6-samitolvanen@google.com>
 <20210416211855.GD22348@zn.tnic>
 <CABCJKud8TvzhcjHCpsrtCJ4B50ZUfaL48F42EhZ2zWKLteAc0Q@mail.gmail.com>
 <20210416220251.GE22348@zn.tnic>
 <CALCETrVTtKqD6fonUmT_qr0HJ0X9TWzLGq-wpm+A7XKyjn3W5g@mail.gmail.com>
 <202104161519.1D37B6D26@keescook>
 <CALCETrV6WYx7dt56aCuUYsrrFya==zYR+p-YZnaATptnaO7w2A@mail.gmail.com>
 <202104161601.CFB2CCF84F@keescook>
 <CALCETrWUS52tzLNiWL5sAVVB5-ko1EW73-TEiO=eZ5jF_QyGPQ@mail.gmail.com>
 <877dl0sc2m.ffs@nanos.tec.linutronix.de>
 <CALCETrVEhL9N_DEM8=rbAzp8Nb2pDitRCZGRAVcE288MBrJ4ug@mail.gmail.com>
In-Reply-To: <CALCETrVEhL9N_DEM8=rbAzp8Nb2pDitRCZGRAVcE288MBrJ4ug@mail.gmail.com>
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
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

RnJvbTogQW5keSBMdXRvbWlyc2tpDQo+IFNlbnQ6IDE4IEFwcmlsIDIwMjEgMDE6MTINCi4uDQo+
IFNsaWdodGx5IG1vcmUgY29tcGxpY2F0ZWQ6DQo+IA0KPiBzdHJ1Y3Qgb3BhcXVlX3N5bWJvbDsN
Cj4gZXh0ZXJuIHN0cnVjdCBvcGFxdWVfc3ltYm9sIGVudHJ5X1NZU0NBTExfNjQ7DQo+IA0KPiBU
aGUgb3BhcXVlX3N5bWJvbCB2YXJpYW50IGF2b2lkcyBhbnkgcG9zc2libGUgY29uZnVzaW9uIG92
ZXIgdGhlIHdlaXJkDQo+IHN0YXR1cyBvZiBhcnJheXMgaW4gQywgYW5kIGl0J3MgaGFyZCB0byBt
aXN1c2UsIHNpbmNlIHN0cnVjdA0KPiBvcGFxdWVfc3ltYm9sIGlzIGFuIGluY29tcGxldGUgdHlw
ZS4NCg0KTWF5YmU6DQoNCnMvb3BhcXVlX3N5bWJvbC9lbnRyeV9TWVNDQUxMXzY0Lw0KDQoJRGF2
aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50
IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTcz
ODYgKFdhbGVzKQ0K

