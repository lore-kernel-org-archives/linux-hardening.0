Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4641042042
	for <linux-hardening@vger.kernel.org>; Sat, 18 May 2024 15:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716046929; cv=none; b=CB1+1KGZkRfFpL14RaoQy9vR3H5CzI3wlJ+BYxoXAa//ixn2S3MsT3dVMuJPtEnxMIOpyuKBKO806lOca3gTiTUczMa1tBAsx+Z65h9rHUQCpGtF+tBjBhVBXM7yA5iln1SPZJJ/4y+vXEckoikXANlpj43jg/C5N4zQpiDwhoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716046929; c=relaxed/simple;
	bh=KEiRFn1zMsvA/RzSGsTpNHMl4lP5BT6qwK22Hk4Utow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=kjgt/HKO8Ejzr7zzwYvvl8QaExQJ0/WamU7IpBSMVI3hT72Z5qGhFspJ2e73SCOJp4MGL+UZQOAxRvDUl8L+RYPA9n7NXwUp5fF2gPJRr8zQWzdo5ZFArpb+uARKjvdh6HlR76u0R55cVsGxK6XBeqk1ibuGeaB80uLMOZqXO/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-8-4PZfaOVqP-eUYUtpx8xdag-1; Sat, 18 May 2024 16:40:13 +0100
X-MC-Unique: 4PZfaOVqP-eUYUtpx8xdag-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 18 May
 2024 16:39:41 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 18 May 2024 16:39:41 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Dan Carpenter' <dan.carpenter@linaro.org>, Kees Cook
	<keescook@chromium.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>, Justin Stitt
	<justinstitt@google.com>, Peter Zijlstra <peterz@infradead.org>, Mark Rutland
	<mark.rutland@arm.com>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [RFC] Mitigating unexpected arithmetic overflow
Thread-Topic: [RFC] Mitigating unexpected arithmetic overflow
Thread-Index: AQHapdsGNoLb3Ne/oEmjTsfdfTDWz7GdI4ug
Date: Sat, 18 May 2024 15:39:41 +0000
Message-ID: <d95664b24ec94436b6cf906fefcc0b4f@AcuMS.aculab.com>
References: <202404291502.612E0A10@keescook>
 <039d54d6-8aa2-4e5b-829b-69002cff35d3@moroto.mountain>
 <202405131203.F7B97F5E38@keescook>
 <0480d602-3ad7-4f8e-a480-9860d56eab30@suswa.mountain>
In-Reply-To: <0480d602-3ad7-4f8e-a480-9860d56eab30@suswa.mountain>
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

RnJvbTogRGFuIENhcnBlbnRlcg0KPiBTZW50OiAxNCBNYXkgMjAyNCAwOTo0NQ0KPiANCj4gU25p
cHBlZCBhbGwgdGhlIGJpdHMgd2hlcmUgeW91IGFyZSBjbGVhcmx5IGNvcnJlY3QuDQo+IA0KPiBP
biBNb24sIE1heSAxMywgMjAyNCBhdCAxMjo0MzozN1BNIC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6
DQo+ID4gPiBkcml2ZXJzL3VzYi9jbGFzcy91c2J0bWMuYzo4NTIgdXNidG1jX2dlbmVyaWNfcmVh
ZCgpIHdhcm46IHBvdGVudGlhbCBpbnRlZ2VyIG92ZXJmbG93IGZyb20gdXNlcg0KPiAnbWF4X3Ry
YW5zZmVyX3NpemUgKyAxJw0KPiA+ID4gICAgODQyICAgICAgICAgICAgICAgICAgICogd01heFBh
Y2tldFNpemUg4oCTIDEpIHRvIGF2b2lkIHNlbmRpbmcgYSB6ZXJvLWxlbmd0aA0KPiA+ID4gICAg
ODQzICAgICAgICAgICAgICAgICAgICogcGFja2V0DQo+ID4gPiAgICA4NDQgICAgICAgICAgICAg
ICAgICAgKi8NCj4gPiA+ICAgIDg0NSAgICAgICAgICAgICAgICAgIHJlbWFpbmluZyA9IHRyYW5z
ZmVyX3NpemU7DQo+ID4gPiAgICA4NDYgICAgICAgICAgICAgICAgICBpZiAoKG1heF90cmFuc2Zl
cl9zaXplICUgZGF0YS0+d01heFBhY2tldFNpemUpID09IDApDQo+ID4gPiAgICA4NDcgICAgICAg
ICAgICAgICAgICAgICAgICAgIG1heF90cmFuc2Zlcl9zaXplICs9IChkYXRhLT53TWF4UGFja2V0
U2l6ZSAtIDEpOw0KPiA+ID4gICAgODQ4ICAgICAgICAgIH0gZWxzZSB7DQo+ID4gPiAgICA4NDkg
ICAgICAgICAgICAgICAgICAvKiByb3VuZCBkb3duIHRvIGJ1ZnNpemUgdG8gYXZvaWQgdHJ1bmNh
dGVkIGRhdGEgbGVmdCAqLw0KPiA+ID4gICAgODUwICAgICAgICAgICAgICAgICAgaWYgKG1heF90
cmFuc2Zlcl9zaXplID4gYnVmc2l6ZSkgew0KPiA+ID4gICAgODUxICAgICAgICAgICAgICAgICAg
ICAgICAgICBtYXhfdHJhbnNmZXJfc2l6ZSA9DQo+ID4gPiAgICA4NTIgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcm91bmR1cChtYXhfdHJhbnNmZXJfc2l6ZSArIDEgLSBidWZzaXpl
LA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Xl5eXl5eXl5eXl5eXl5eXl5eXl5eDQo+ID4gPiBUaGlzIGNhbiBvdmVyZmxvdy4gIFdlIHNob3Vs
ZCBtYWtlIGl0IGEgcnVsZSB0aGF0IGFsbCBzaXplIHZhcmlhYmxlcw0KPiA+ID4gaGF2ZSB0byBi
ZSB1bnNpZ25lZCBsb25nLiAgVGhhdCB3b3VsZCBoYXZlIG1hZGUgdGhpcyBzYWZlIG9uIDY0IGJp
dA0KPiA+ID4gc3lzdGVtcy4NCj4gPiA+DQo+ID4gPiAgICA4NTMgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBidWZzaXplKTsNCj4gPiA+ICAgIDg1NCAgICAgICAgICAg
ICAgICAgIH0NCj4gPiA+ICAgIDg1NSAgICAgICAgICAgICAgICAgIHJlbWFpbmluZyA9IG1heF90
cmFuc2Zlcl9zaXplOw0KPiA+DQo+ID4gQWdhaW4sIGRvIHdlIF93YW50XyB0aGlzIHRvIG92ZXJm
bG93PyBJdCBsb29rcyBsaWtlIG5vdC4gSSdtIG5vdCBzdXJlDQo+ID4gd2hhdCB0aGlzIGNvZGUg
aXMgdHJ5aW5nIHRvIGRvLCB0aG91Z2guIFRoZSBjb21tZW50IGRvZXNuJ3Qgc2VlbSB0bw0KPiA+
IG1hdGNoIHRoZSBjb2RlLiBXaHkgaXNuJ3QgdGhpcyBqdXN0IHJvdW5kdXAobWF4X3RyYW5zZmVy
X3NpemUsIGJ1ZnNpemUpID8NCj4gPg0KDQpJc24ndCBpdCBqdXN0IG1heF90cmFuc2Zlcl9zaXpl
IC8gYnVmc2l6ZSAqIGJ1ZnNpemU/DQoNCj4gcm91bmR1cCgpIGhhcyBhbiBpbnRlZ2VyIG92ZXJm
bG93IGluIGl0Lg0KDQpXaGljaCBpcyBhIGdlbmVyaWMgcHJvYmxlbSB3aXRoIHRoZXNlICdoZWxw
ZXJzJy4NCklmIHRoZSBmdW5jdGlvbiBpcyBvcGVuIGNvZGVkIGFueSBvdmVyZmxvdyBpcyBvYnZp
b3VzLg0KQnV0IGhpZGUgaXQgaW4gYSB3cmFwcGVyIGFuZCBpdCBpcyBqdXN0ICdhc3N1bWVkIHRv
IHdvcmsnLg0KRElWX1JPVU5EVVAoeCwgeSkgY2FuIGJlIGVpdGhlciAoeCArIHkgLSAxKS95IG9y
ICh4IC0gMSkveSArIDEuDQpUaGUgZmlyc3QgaXMgdmFsaWQgZm9yIDAgYnV0IGNhbiBvdmVyZmxv
dywgdGhlIHNlY29uZCBpcyB2YWxpZCBmb3IgeCAhPSAwLg0KKFdobyBrbm93cyB3aGF0IGlzIGV4
cGVjdGVkIGZvciBuZWdhdGl2ZSB2YWx1ZXMhKQ0KSW4gbW9zdCBwbGFjZXMgb25lIG9mIHRoZSBw
YWlyIHdpbGwgYWx3YXlzIGJlIGNvcnJlY3QuDQoNCk9iZnVzY2F0aW5nIHRoZSBjb2RlIHRlbmQg
dG8gc3RvcCByZWFkZXJzIChhbmQgdGhlIGtlcm5lbCBjb2RlIGRvZXMgZ2V0IHNvbWUpDQpzcG90
dGluZyB0aGluZ3MgaW4gcGFzc2luZy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVz
cyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEg
MVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

