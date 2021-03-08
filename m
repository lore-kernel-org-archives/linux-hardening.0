Return-Path: <SRS0=gv6h=IG=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B63C433E0
	for <linux-hardening@archiver.kernel.org>; Mon,  8 Mar 2021 09:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 450E865134
	for <linux-hardening@archiver.kernel.org>; Mon,  8 Mar 2021 09:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhCHJkJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 8 Mar 2021 04:40:09 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:38508 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230142AbhCHJjr (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 8 Mar 2021 04:39:47 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-93-tgbNLEpMPIWi_Wa1TbBvHA-1; Mon, 08 Mar 2021 09:39:44 +0000
X-MC-Unique: tgbNLEpMPIWi_Wa1TbBvHA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 8 Mar 2021 09:39:42 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 8 Mar 2021 09:39:42 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Josh Poimboeuf' <jpoimboe@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "Linux Kbuild mailing list" <linux-kbuild@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Justin Forbes <jforbes@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Frank Eigler <fche@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: RE: [PATCH RFC] gcc-plugins: Handle GCC version mismatch for OOT
 modules
Thread-Topic: [PATCH RFC] gcc-plugins: Handle GCC version mismatch for OOT
 modules
Thread-Index: AQHXEfRW9GGtVBDzukCnmow65VTEg6p51fTA
Date:   Mon, 8 Mar 2021 09:39:42 +0000
Message-ID: <bb60fe817f5144929a527d1f5768dd1a@AcuMS.aculab.com>
References: <CAHk-=whA6zru0BaNm4uu5KyZe+aQpRScOnmc9hdOpO3W+xN9Xw@mail.gmail.com>
 <20210303202406.bxgdx5a25j6wc43b@treble>
 <CAHk-=wi9J3mM8y+aH9e=HRo95giK4BRyyasayAimB0gdvbvDsQ@mail.gmail.com>
 <20210303214534.guyoxcwrgxgcqzy4@treble>
 <CAK7LNAQaAgg+mVSw_U3_FuuqcqJNnonyhVD1M-ezv71Y+dyAww@mail.gmail.com>
 <20210304150812.rzya7ewmerwhe4m4@treble>
 <CAK7LNAR0kNJ=DLuvRzRG+-rgMfcrSOZu8Mn6JBJ5do7TzJWLcA@mail.gmail.com>
 <CAHk-=wiT3FGuKuqLniBN2T_PZwD0GH4kf3XNCzq2tfChqn0+SQ@mail.gmail.com>
 <20210305024140.fv4i4ujreem2w7sw@treble>
 <CAK7LNAR3FW8wQe6Zsbj86LQpY4=ASC7Zec-HN4D70FNZcQk0_Q@mail.gmail.com>
 <20210305191835.4e54dei3dmslbo3a@treble>
In-Reply-To: <20210305191835.4e54dei3dmslbo3a@treble>
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

PiAtICJFeHRlcm5hbCBtb2R1bGVzIG11c3QgYmUgYnVpbHQgd2l0aCB0aGUgc2FtZSBHQ0MgdmVy
c2lvbiINCj4gDQo+ICAgQXMgaGFzIGJlZW4gc3RhdGVkIHJlcGVhdGVkbHksIGJ5IExpbnVzIGFu
ZCBvdGhlcnMsIHRoZXJlJ3Mgbm8NCj4gICB0ZWNobmljYWwgcmVhc29uIGJlaGluZCB0aGlzIGNs
YWltLiAgSXQgaWdub3JlcyB0aGUgcmVhbGl0aWVzIG9mIGhvdw0KPiAgIGRpc3Ryb3MgcmVsZWFz
ZSB0aGUga2VybmVsIGFuZCBjb21waWxlciBpbmRlcGVuZGVudGx5LCB3aXRoIHNlcGFyYXRlDQo+
ICAgY2FkZW5jZXMuICBNaW5vciB2YXJpYW5jZXMgaW4gY29tcGlsZXIgdmVyc2lvbiBhcmUgQUJJ
IGNvbXBhdGlibGUuDQoNCkFyZW4ndCBtYWpvciB2ZXJzaW9ucyBBQkkgY29tcGF0aWJsZT8NCk90
aGVyd2lzZSBpdCBpcyBhIGRpZmZlcmVudCBhcmNoaXRlY3R1cmUuDQoNCj4gICBBbHNvLCBmb3Ig
ZmVhdHVyZXMgd2hpY2ggYXJlIGRlcGVuZGVudCBvbiBjb21waWxlciB2ZXJzaW9uLCBtYW55IG9m
DQo+ICAgdGhvc2UgYXJlIG5vdyBlbmFibGVkIGJ5IGtidWlsZC4gIEFzIEkgc3VnZ2VzdGVkIHRv
IHlvdSBwcmV2aW91c2x5LA0KPiAgIGtidWlsZCBzaG91bGQgd2FybiB3aGVuIHN1Y2ggZmVhdHVy
ZXMgZ2V0IGRpc2FibGVkICh3aGljaCBjYW4gaGFwcGVuDQo+ICAgZHVlIHRvIGEgY29tcGlsZXIv
dG9vbGNoYWluIGNoYW5nZSBvciBkdWUgdG8gYSAuY29uZmlnIGNvcGllZCBmcm9tDQo+ICAgYW5v
dGhlciBzeXN0ZW0pLg0KDQpBbnl0aGluZyB0aGF0IGlzIGp1c3QgYW4gb3B0aW1pc2F0aW9uIChv
ciBwZXNzaW1pc2F0aW9uKSByZWFsbHkNCmRvZXNuJ3QgbWF0dGVyLg0KQUZBSUNUIG1vc3Qgb2Yg
dGhlc2Ugb3B0aW9ucyBhcmUgaW4gdGhlIGxhdHRlciBjYXRlZ29yeS4NCg0KT25lIHRoaW5rIHBl
b3BsZSBtaWdodCBkbyBpcyBkb3dubG9hZCBhIGtlcm5lbCBmcm9tIGtlcm5lbC5vcmcNCmFuZCB0
aGVuIGJ1aWxkIGFuIGV4dHJhIG1vZHVsZSBmb3IgaXQuDQpUaGUgY29tcGlsZXIgdGhleSBoYXZl
IHdpbGwgYmUgY29tcGxldGVseSBkaWZmZXJlbnQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVk
IEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5l
cywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

