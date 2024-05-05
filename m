Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDB81CF8F
	for <linux-hardening@vger.kernel.org>; Sun,  5 May 2024 13:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714916367; cv=none; b=nytIR/tDgJHTE4hMKiUo/KDBd/xUpYo+8Rj1aqFY/duBxZoxJEvkWkHa9ZzympjWoGjNAXF7UeKEw3sDhnXYYQx7E4JjQJXVeVekk2BUWBTwp6KvCN6GVtLKNy84uECNSgUXAkRCB9W/g6qLO8O0+YCTKHH5Q7UPgXGyNP/hnqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714916367; c=relaxed/simple;
	bh=MGNVhHHDkYMXHSgTk7UxWt8BeGW9WOX4CbqGNRY3E0k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=oM/1bVdcJjmWokMACzanwusYvOxzQTiS5ZiYoREj/zDWf1oOhAOu35UejRPN5kynFnLCR1PJ5KceWmxBEHv37eQq9oZ10z4WP0iSXqw52t/TgWPkiIN5plePoHdFxPzWQVJ2YLuuG90IEl3IP4SpEJfBdI3MgV6jmshvuu+BY10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-124-vwaktAuzPpq_9ysQnuYoWQ-1; Sun, 05 May 2024 14:39:22 +0100
X-MC-Unique: vwaktAuzPpq_9ysQnuYoWQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 5 May
 2024 14:38:48 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 5 May 2024 14:38:48 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Kees Cook' <keescook@chromium.org>, Andy Shevchenko
	<andy.shevchenko@gmail.com>
CC: Hsin-Yu.Chen <harry021633@gmail.com>, "andy@kernel.org" <andy@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] string: improve strlen performance
Thread-Topic: [PATCH 2/2] string: improve strlen performance
Thread-Index: AQHanKLZPFuACoaESk2KpN/2ErXiirGIqNYw
Date: Sun, 5 May 2024 13:38:48 +0000
Message-ID: <7c1565516531425c8f7cf5ffd5582741@AcuMS.aculab.com>
References: <20240502141359.89567-1-harry021633@gmail.com>
 <CAHp75Vd9PibrQA=tgZLHuv-kDXana9rGcu5s_aPqyxW6tDBYGw@mail.gmail.com>
 <CAHp75Ve4BV7+C+XsNmmjCSupcL6PXe_9ZNMGAQXg9nqdMBFrqg@mail.gmail.com>
 <202405020809.C8973634BF@keescook>
In-Reply-To: <202405020809.C8973634BF@keescook>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogS2VlcyBDb29rDQo+IFNlbnQ6IDAyIE1heSAyMDI0IDE2OjExDQo+IA0KPiBPbiBUaHUs
IE1heSAwMiwgMjAyNCBhdCAwNjowMzowNFBNICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+ID4gT24gVGh1LCBNYXkgMiwgMjAyNCBhdCA1OjU54oCvUE0gQW5keSBTaGV2Y2hlbmtvDQo+
ID4gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+IHdyb3RlOg0KPiA+ID4gT24gVGh1LCBNYXkg
MiwgMjAyNCBhdCA1OjE04oCvUE0gSHNpbi1ZdS5DaGVuIDxoYXJyeTAyMTYzM0BnbWFpbC5jb20+
IHdyb3RlOg0KPiA+DQo+ID4gQW5kIG9uIHRvcCBvZiB0aGF0LCBjaGVjayB3aGF0IHRoaXMgY29k
ZSB3aWxsIGRvIG9uIHRoZSBhcmNoaXRlY3R1cmVzDQo+ID4gdGhhdCBkbyBub3Qgc3VwcG9ydCB1
bmFsaWduZWQgYWNjZXNzLiBJZiBldmVyeXRoaW5nIGlzIGZpbmUsIG1lbnRpb24NCj4gPiB0aGlz
IGluIHRoZSBjb21taXQgbWVzc2FnZS4gQnR3LCB5b3VyIGNvbW1pdCBtZXNzYWdlIG5lZWRzDQo+
ID4gZWxhYm9yYXRpb24sIGUuZy4sIHBvaW50aW5nIHRvIHRoZSB0ZXN0IGNhc2UgKHdoaWNoIGlz
IGFic2VudCBpbiB0aGlzDQo+ID4gcGF0Y2gsIEkgYXNzdW1lIGl0J3MgYWxyZWFkeSBpbiB0aGUg
a2VybmVsPykgYW5kIHN0ZXAtYnktc3RlcA0KPiA+IGluc3RydWN0aW9ucyBvbiBob3cgeW91IGdv
dCB0aGUgbWVudGlvbmVkIHJlc3VsdHMgd2l0aCBkZXRhaWxzIG9mIHRoZQ0KPiA+IGhhcmR3YXJl
IHlvdSB1c2VkIGZvciB0aGF0Lg0KPiANCj4gSSBtaWdodCBiZSB3b3J0aCBsb29raW5nIGF0IHRo
ZSBpbXBsZW1lbnRhdGlvbiBvZiBzdHJzY3B5KCksIHdoaWNoIGlzDQo+IGRvaW5nIHNpbWlsYXIg
bXVsdGktYnl0ZSBzdGVwcyBhbmQgaGFuZGxlcyB1bmFsaWduZWQgYWNjZXNzLg0KDQpBbmQgeDg2
IHJlYWxseSBkb2Vzbid0IGNhcmUgYWJvdXQgdW5hbGlnbmVkIGFjY2Vzc2VzIChmb3Igbm9ybWFs
IHJlZ2lzdGVycykuDQpCdXQgaXQgaXMgaW1wb3J0YW50IHRvIG5vdCBhY2NpZGVudGFsbHkgcnVu
IG9mZiB0aGUgZW5kIG9mIGEgcGFnZS4NCg0KVGhlcmUgaXMgYWxzbyB0aGUgd2hvbGUgcXVlc3Rp
b24gb2YgdGhlIHR5cGljYWwgc3RyaW5nIGxlbmd0aC4NCkZvciBzaG9ydCBzdHJpbmdzIHlvdSd2
ZSBhbHJlYWR5IGxvc3QgYnkgdGhlIHRpbWUgeW91J3ZlIGFsaWduZWQNCnRoZSBhZGRyZXNzLg0K
DQpPbiAzMmJpdCB0aGUgd2hvbGUgYml0LXR3aWRkbGluZyBtYXkgbm90IGJlIHdvcnRoIGl0IGF0
IGFsbC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxl
eSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0
aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

