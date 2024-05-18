Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA2232C60
	for <linux-hardening@vger.kernel.org>; Sat, 18 May 2024 13:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716037775; cv=none; b=Xj3T/ZTyDyO1+F+0cb64QkSSByR0+eJMCrNcxE09nwIuntIgaevQpYsG5m9WqvjdwB+gC/Fpy/2SldpDjNFGcKv7ISsIYHxQkD4QQJxV2U5DKqjeV1/YFEnGigh1GRWOxz4Cv1q27LXdK2w9jb/dP6bXgDiNE2eo8yfo4BRV2GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716037775; c=relaxed/simple;
	bh=LWTy/AWDIxLug8r/jyGlNA64I7dG0aBjMEbJgOkManU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=q9/hyQ0nvTA8U/52FevRyHm8fZLVio8+nP3uDikTCZkotsckI94xXxYbrqNVtSQo4MI+iTgW0B1N47mclCzj2UjeegScqEA9BK8gKggJK6sh0NpaxvcpqH60MnJ4xZdvVkTWDgjNVEC1coiHIZHwtKpnop1SIvamOTNqSu4Tlhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-319-xOLMYslUNASMd3-nOSLNBA-1; Sat, 18 May 2024 14:09:24 +0100
X-MC-Unique: xOLMYslUNASMd3-nOSLNBA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 18 May
 2024 14:08:53 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 18 May 2024 14:08:53 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Kees Cook' <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
CC: Kees Cook <keescook@chromium.org>, Justin Stitt <justinstitt@google.com>,
	Mark Rutland <mark.rutland@arm.com>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [RFC] Mitigating unexpected arithmetic overflow
Thread-Topic: [RFC] Mitigating unexpected arithmetic overflow
Thread-Index: AQHap5VP7Alm1wU+TkWPeIXHcuXX+bGc9guA
Date: Sat, 18 May 2024 13:08:52 +0000
Message-ID: <df0a315b68d64b33b5879d31b5bf9432@AcuMS.aculab.com>
References: <202404291502.612E0A10@keescook>
 <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook>
 <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook>
 <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
 <20240515073636.GY40213@noisy.programming.kicks-ass.net>
 <25882715-FE44-44C0-BB9B-57F2E7D1F0F9@kernel.org>
In-Reply-To: <25882715-FE44-44C0-BB9B-57F2E7D1F0F9@kernel.org>
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

RnJvbTogS2VlcyBDb29rDQo+IFNlbnQ6IDE2IE1heSAyMDI0IDE0OjMxDQo+IA0KPiBPbiBNYXkg
MTUsIDIwMjQgMTI6MzY6MzYgQU0gUERULCBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVh
ZC5vcmc+IHdyb3RlOg0KPiA+T24gV2VkLCBNYXkgMDgsIDIwMjQgYXQgMDQ6NDc6MjVQTSAtMDcw
MCwgTGludXMgVG9ydmFsZHMgd3JvdGU6DQo+ID4+IEZvciBleGFtcGxlLCB0aGUgbW9zdCBjb21t
b24gY2FzZSBvZiBvdmVyZmxvdyB3ZSd2ZSBldmVyIGhhZCBoYXMgdmVyeQ0KPiA+PiBtdWNoIGJl
ZW4gYXJyYXkgaW5kZXhpbmcuIE5vdywgc29tZXRpbWVzIHRoYXQgaGFzIGFjdHVhbGx5IGJlZW4g
YWN0dWFsDQo+ID4+IHVuZGVmaW5lZCBiZWhhdmlvciwgYmVjYXVzZSBpdCdzIGJlZW4gb3ZlcmZs
b3cgaW4gc2lnbmVkIHZhcmlhYmxlcywNCj4gPj4gYW5kIHRob3NlIGFyZSAiZWFzeSIgdG8gZmlu
ZCBpbiB0aGUgc2Vuc2UgdGhhdCB5b3UganVzdCBzYXkgIm5vLCBjYW4ndA0KPiA+PiBkbyB0aGF0
Ii4gVUJTQU4gZmluZHMgdGhlbSwgYW5kIHRoYXQncyBnb29kLg0KPiA+DQo+ID5XZSBidWlsZCB3
aXRoIC1mbm8tc3RyaWN0LW92ZXJmbG93LCB3aGljaCBpbXBsaWVzIC1md3JhcHYsIHdoaWNoIHJl
bW92ZXMNCj4gPnRoZSBVQiBmcm9tIHNpZ25lZCBvdmVyZmxvdyBieSBtYW5kYXRpbmcgMnMgY29t
cGxlbWVudC4NCj4gDQo+IEkgYW0gYSBicm9rZW4gcmVjb3JkLiA6KSBUaGlzIGlzIF9ub3RfIGFi
b3V0IHVuZGVmaW5lZCBiZWhhdmlvci4NCj4gDQo+IFRoaXMgaXMgYWJvdXQgZmluZGluZyBhIHdh
eSB0byBtYWtlIHRoZSBpbnRlbnQgb2YgQyBhdXRob3JzIHVuYW1iaWd1b3VzLg0KPiBUaGF0IG92
ZXJmbG93IHdyYXBzIGlzIHdlbGwgZGVmaW5lZC4gSXQgaXMgbm90IGFsd2F5cyBfZGVzaXJlZF8u
DQo+IEMgaGFzIG5vIHdheSB0byBkaXN0aW5ndWlzaCBiZXR3ZWVuIHRoZSB0d28gY2FzZXMuDQoN
CkknbSBwcmV0dHkgc3VyZSB0aGF0IHRoZSAndW5kZWZpbmVkJyBiZWhhdmlvdXIgb2Ygc2lnbmVk
IG92ZXJmbG93DQppdCBzbyB0aGF0IGNwdSBjYW4gZG8gc2F0dXJhdGluZyBhcml0aG1ldGljICh1
c2VmdWwgb24gYW5hbG9ndWUgZGF0YSkNCm9yIGNhbiBmYXVsdCAoYW5kIG1heWJlIGdlbmVyYXRl
IGEgc2lnbmFsKSBhbmQgc3RpbGwgYmUgY29tcGxpYW50Lg0KDQpUaGUgTGludXgga2VybmVsIChh
bmQgcHJldHR5IG11Y2ggYWxsIHVzZXJzcGFjZSkgZG9lc24ndCB3YW50IGVpdGhlcg0KYmVoYXZp
b3VyLg0KKFVuZXhwZWN0ZWQgc2F0dXJhdGlvbiBsZWFkcyB0byB2ZXJ5IGNvbmZ1c2luZyBidWdz
IHRoYXQgYXJlIGFzIGJhZA0KYXMgd3JhcHBpbmcgYnV0IG11Y2ggbGVzcyBvYnZpb3VzLikNCg0K
SSBkbyB3b25kZXIgd2hldGhlciB0cnlpbmcgdG8gcmVtb3ZlIGFsbCBhcml0aG1ldGljIG9uIGNo
YXIvc2hvcnQNCnZhcmlhYmxlcyBzaG91bGQgYmUgYW4gYWltLg0KVGhlIG9ubHkgcmVhc29uIHRv
IGhhdmUgY2hhci9zaG9ydCBpcyB0byByZWR1Y2UgdGhlIHNpemUgb2YgYSBzdHJ1Y3R1cmUuDQpB
IGZpcnN0IHN0YWdlIHdvdWxkIHJlbW92aW5nIGFsbCBzaG9ydCBsb2NhbHMsIGZ1bmN0aW9uIHBh
cmFtZXRlcnMNCmFuZCBmdW5jdGlvbiByZXR1cm5zLg0KVGhlcmUgd2lsbCBiZSBzb21lIChzZW5z
aWJsZSkgZmFsc2UgcG9zaXRpdmVzIGZvciBjaGFyLg0KDQpJZiB5b3UgYnJlYXRoIG9uIGEgY2hh
ci9zaG9ydCBpdCBiZWNvbWVzICdzaWduZWQgaW50JywNCmV2ZW4gKHggPyAnYScgOiAnYicpIGlz
ICdzaWduZWQgaW50Jy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lk
ZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0K
UmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

