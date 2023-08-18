Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE36CC001DE
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Aug 2023 10:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376439AbjHRKuM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 18 Aug 2023 06:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359676AbjHRKuH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 18 Aug 2023 06:50:07 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BF130C2
        for <linux-hardening@vger.kernel.org>; Fri, 18 Aug 2023 03:50:05 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-155-VhXJfEBVOJyxXJ3mZKyu3Q-1; Fri, 18 Aug 2023 11:50:03 +0100
X-MC-Unique: VhXJfEBVOJyxXJ3mZKyu3Q-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 18 Aug
 2023 11:49:59 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 18 Aug 2023 11:49:59 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Przemek Kitszel' <przemyslaw.kitszel@intel.com>,
        'Kees Cook' <keescook@chromium.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Steven Zou <steven.zou@intel.com>
Subject: RE: [PATCH net-next v3 1/7] overflow: add DEFINE_FLEX() for on-stack
 allocs
Thread-Topic: [PATCH net-next v3 1/7] overflow: add DEFINE_FLEX() for on-stack
 allocs
Thread-Index: AQHZ0EteSw2XTdntxkSn8fWObNOCVK/uiVWQgAAd6ICAAP4u4IAAJp+AgAATRuA=
Date:   Fri, 18 Aug 2023 10:49:59 +0000
Message-ID: <8c5fcd66086a4354b30f15dd488a9fe5@AcuMS.aculab.com>
References: <20230816140623.452869-1-przemyslaw.kitszel@intel.com>
 <20230816140623.452869-2-przemyslaw.kitszel@intel.com>
 <1f9cb37f21294c31a01af62fd920f070@AcuMS.aculab.com>
 <202308170957.F511E69@keescook>
 <e8e109712a1b42288951c958d2f503a5@AcuMS.aculab.com>
 <3f61b3bc-61d4-6568-9bcb-6fd50553157c@intel.com>
In-Reply-To: <3f61b3bc-61d4-6568-9bcb-6fd50553157c@intel.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

RnJvbTogUHJ6ZW1layBLaXRzemVsDQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDE4LCAyMDIzIDEx
OjI4IEFNDQouLi4NCj4gPj4+IEknbSBub3Qgc3VyZSB5b3Ugc2hvdWxkIGJlIGZvcmNpbmcgdGhl
IG1lbXNldCgpIGVpdGhlci4NCj4gPj4NCj4gPj4gVGhpcyBhbHJlYWR5IGdvdCBkaXNjdXNzZWQ6
IGJldHRlciB0byBmYWlsIHNhZmUuDQo+ID4NCj4gPiBQZXJoYXBzIGNhbGwgaXQgREVGSU5FX0ZM
RVhfWigpIHRvIG1ha2UgdGhpcyBjbGVhciBhbmQNCj4gPiBnaXZlIHRoZSBvcHRpb24gZm9yIGEg
bm9uLXplcm9pbmcgdmVyc2lvbiBsYXRlci4NCj4gPiBOb3QgZXZlcnlvbmUgd2FudHMgdGhlIGV4
cGVuc2Ugb2YgemVyb2luZyBldmVyeXRoaW5nLg0KPiANCj4gcGVyIEtlZXMsIHplcm9pbmcgc2hv
dWxkIGJlIHJlbW92ZWQgYnkgY29tcGlsZXIgd2hlbiBub3QgbmVlZGVkOg0KPiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9pbnRlbC13aXJlZC1sYW4vMjAyMzA4MTAxMTI4LkM0RjBGQTIzNUBrZWVz
Y29vay8NCg0KRXhwZWN0IGluIHRoZSBtb3N0IHRyaXZpYWwgY2FzZXMgdGhlIGNvbXBpbGVyIGlz
IHByZXR0eSBtdWNoIG5ldmVyDQpnb2luZyB0byByZW1vdmUgdGhlIHplcm9pbmcgb2YgdGhlIGRh
dGFbXSBwYXJ0Lg0KDQpJJ20gYWxzbyBub3QgYXQgYWxsIHN1cmUgd2hhdCBoYXBwZW5zIGlmIHRo
ZXJlIGlzIGEgZnVuY3Rpb24NCmNhbGwgYmV0d2VlbiB0aGUgaW5pdGlhbGlzYXRpb24gYW5kIGFu
eSBhc3NpZ25tZW50cy4NCg0KV2l0aCBhIGJpdCBvZiBlZmZvcnQgeW91IHNob3VsZCBiZSBhYmxl
IHRvIHBhc3MgdGhlICc9IHt9Jw0KdGhyb3VnaCBpbnRvIGFuIGlubmVyICNkZWZpbmUuDQpQb3Nz
aWJseSB3aXRoIHRoZSBhbHRlcm5hdGl2ZSBvZiBhIGNhbGxlci1wcm92aWRlcg0KICc9IHsgLm9i
aiA9IGNhbGxfc3VwcGxpZWRfaW5pdGlhbGlzZXIgfScNClRoZSAnbm90IF9aJyBmb3JtIHdvdWxk
IHBhc3MgYW4gZW1wdHkgYXJndW1lbnQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJl
c3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsx
IDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

