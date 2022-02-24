Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FE6C433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 24 Feb 2022 09:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbiBXJyh (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbiBXJyh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 24 Feb 2022 04:54:37 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9AF7728571B
        for <linux-hardening@vger.kernel.org>; Thu, 24 Feb 2022 01:54:07 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-97-kWCom7ZBN6GbmZxlHh1VyQ-1; Thu, 24 Feb 2022 09:54:05 +0000
X-MC-Unique: kWCom7ZBN6GbmZxlHh1VyQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Thu, 24 Feb 2022 09:54:04 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Thu, 24 Feb 2022 09:54:04 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Geert Uytterhoeven' <geert@linux-m68k.org>
CC:     Kees Cook <keescook@chromium.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] m68k: Implement "current_stack_pointer"
Thread-Topic: [PATCH] m68k: Implement "current_stack_pointer"
Thread-Index: AQHYKVzdWGzmeUZEQEqpz/PmAjDYBqyiaMrQgAAC+ICAAAoScA==
Date:   Thu, 24 Feb 2022 09:54:04 +0000
Message-ID: <95b9c3e8227a4892b26cc0384d1782c2@AcuMS.aculab.com>
References: <20220224060448.1856091-1-keescook@chromium.org>
 <CAMuHMdVioQLy_T2LimgWdfWM=j=fomfpayuS1mbXnBLZj4gGQA@mail.gmail.com>
 <d75f1259c3e64387a161ebcb0448d594@AcuMS.aculab.com>
 <CAMuHMdWtQ+B-01ZOwZNvgQ7pndNsP3V90_jHdR=RS4K7O3Vk9g@mail.gmail.com>
In-Reply-To: <CAMuHMdWtQ+B-01ZOwZNvgQ7pndNsP3V90_jHdR=RS4K7O3Vk9g@mail.gmail.com>
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

RnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gU2VudDog
MjQgRmVicnVhcnkgMjAyMiAwOToxNw0KPiANCj4gT24gVGh1LCBGZWIgMjQsIDIwMjIgYXQgMTA6
MTIgQU0gRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4g
RnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuDQo+ID4gPiBTZW50OiAyNCBGZWJydWFyeSAyMDIyIDA4
OjU5DQo+ID4gLi4uDQo+ID4gPiA+ICtyZWdpc3RlciB1bnNpZ25lZCBsb25nIGN1cnJlbnRfc3Rh
Y2tfcG9pbnRlciBfX2FzbV9fKCJzcCIpOw0KPiA+ID4NCj4gPiA+IEkgZG9uJ3Qga25vdyB3aGF0
IEhBUkRFTkVEX1VTRVJDT1BZIGRvZXMsIHNvIEkgZG9uJ3Qga25vdyBpZiB5b3UgbmVlZA0KPiA+
ID4gInVzcCIgKHNlZSByZHVzcCgpKSBvciAic3AiPw0KPiA+DQo+ID4gSEFSREVORURfVVNFUkNP
UFkgc2lnbmlmaWNhbnRseSBzbG93cyBkb3duIHNvbWUgc3lzdGVtcyBjYWxscw0KPiA+IChlc3Bl
Y2lhbGx5IHRoaW5ncyBsaWtlIHNlbmRtc2coKSkgYnkgdHJ5aW5nIHRvIHJ1bi10aW1lIHZlcmlm
eQ0KPiA+IHRoYXQgdGhlIGtlcm5lbCBidWZmZXIgZG9lc24ndCBvdmVycnVuIGEgc3RhY2sgZnJh
bWUgb3Iga21hbGxvYygpZWQNCj4gDQo+IEtlcm5lbCBzdGFjayBmcmFtZSBvZiB1c2VyIHN0YWNr
IGZyYW1lPw0KDQpLZXJuZWwsIHRoZSBrZXJuZWwgZG9lc24ndCBjYXJlIGlmIHRoZSB1c2VyIHN0
YWNrIGdldHMgdHJhc2hlZC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtl
c2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBV
Sw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

