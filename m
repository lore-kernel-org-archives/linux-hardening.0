Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49EB433D1
	for <linux-hardening@vger.kernel.org>; Wed, 11 Sep 2024 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726073262; cv=none; b=UTF+RLIfGUi7vK5UtFhIa9nBzw4xI8yz8/tXk1kx7kTNHSJRHYAn0SwDriWlzxTeFhixN+q3sdmBCbcb9pigrzIjExD5MbKrDekT2ZE4sgIs40RbCuPgC7WxYN0zrzdGOX/ZCg6a+3ihN+yKimHs6juU3mpJwsDK6W+TWmE9Qy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726073262; c=relaxed/simple;
	bh=nIjt55cI5HHld4bPEuuMqaBZdpwKRDE1zo4psyvz9io=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=NvCavah5GiI7NmnPJ0cbAogdKsnJEwUHF7eMFhyR9RqpnoNpRA6gYBqcDxtiSJHd5BRyICu7SYi3LNiYTQ+VKe2bCMwMhOPcbKTpxg+jjDn4OozgOjsve3aw1td+hFMwYlpC0PHf0vUp5aXRnXs32wroGohDR5gLv6nNHsdvmy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-252-flUzNfMMM9ibaQjAN64BxA-1; Wed, 11 Sep 2024 17:47:38 +0100
X-MC-Unique: flUzNfMMM9ibaQjAN64BxA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 11 Sep
 2024 17:46:51 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 11 Sep 2024 17:46:51 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Vincent MAILHOL' <mailhol.vincent@wanadoo.fr>
CC: Kees Cook <kees@kernel.org>, "Gustavo A . R . Silva"
	<gustavoars@kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] overflow: optimize struct_size() calculation
Thread-Topic: [PATCH v2] overflow: optimize struct_size() calculation
Thread-Index: AQHbAywJ58VR+K3+gU6+o+9bWfd3j7JSX6zQgAA/doCAAC1EAA==
Date: Wed, 11 Sep 2024 16:46:51 +0000
Message-ID: <43ac488d0a83486ca6d969643c7b531d@AcuMS.aculab.com>
References: <20240910024952.1590207-1-mailhol.vincent@wanadoo.fr>
 <01aa8bd408d04031941073b026f171fb@AcuMS.aculab.com>
 <CAMZ6Rq+6EKoFEHMZhp_2dq2DPEP6zZgzDy0M3tegKK9wOphA6g@mail.gmail.com>
In-Reply-To: <CAMZ6Rq+6EKoFEHMZhp_2dq2DPEP6zZgzDy0M3tegKK9wOphA6g@mail.gmail.com>
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

Li4uDQo+ID4gWzFdIEJvdGggdGhlICcrJyBhbmQgJyonIGhhdmUgZXh0cmEgY29kZSB0byBkZXRl
Y3Qgb3ZlcmZsb3cgYW5kIHJldHVybg0KPiA+ICAgYSAnYmlnJyB2YWx1ZSB0aGF0IHdpbGwgY2F1
c2Uga21hbGxvYygpIHRvIHJldHVybiBOVUxMLg0KPiA+IEkndmUgbm90IGxvb2tlZCBhdCB0aGUg
Z2VuZXJhdGVkIGNvZGUgYnV0IGl0IGlzIGxpa2VseSB0byBiZSBob3JyaWQNCj4gPiAgIChlc3Bl
Y2lhbGx5IHRoZSBjaGVjayBmb3IgbXVsdGlwbHkgb3ZlcmZsb3dpbmcpLg0KPiA+IEluIHRoaXMg
Y2FzZSB0aGVyZSBhcmUgZW5vdWdoIGNvbnN0YW50cyB0aGF0IHRoZSBhbHRlcm5hdGl2ZSBjaGVj
azoNCj4gPiAgICAgICAgIGlmIChjb3VudCA+IChNQVhfU0laRSAtIHNpemVvZiAoKnMpKSAvIHNp
emVvZiAocy0+bWVtYmVyKSkNCj4gPiAgICAgICAgICAgICAgICAgc2l6ZSA9IE1BWF9TSVpFOw0K
PiA+ICAgICAgICAgZWxzZQ0KPiA+ICAgICAgICAgICAgICAgICBzaXplID0gc2l6ZW9mICgqcykg
KyBjb3VudCAqIHNpemVvZiAocy0+bWVtYmVyKTsNCj4gPiBpcyBmaW5lIGFuZCBvbmx5IGhhcyBv
bmUgY29uZGl0aW9uYWwgaW4gaXQuDQo+ID4gSW4gc29tZSBjYXNlcyB0aGUgY29tcGlsZXIgbWF5
IGFscmVhZHkga25vdyB0aGF0IHRoZSBjb3VudCBpcyBzbWFsbCBlbm91Z2guDQo+IA0KPiBJbmRl
ZWQuIElmIGNvdW50IGlzIHNtYWxsIGVub3VnaCwgdGhlIGNvZGUgaXNuJ3QgdGhhdCBob3JyaWQu
IElmIEkNCj4gdGFrZSB0aGlzIGV4YW1wbGU6DQo+IA0KPiAgIHNpemVfdCBmb28odTMyIGNvdW50
KQ0KPiAgIHsNCj4gICAgICAgICAgIHJldHVybiBzdHJ1Y3Rfc2l6ZV90KHN0cnVjdCBzLCBmYW0s
IGNvdW50KTsNCj4gICB9DQo+IA0KPiBJIGdvdCB0aGlzIGNvZGU6DQoNCldoYXQgaGFwcGVucyBp
ZiB0aGUgZmxleC1hcnJheSBpcyBsYXJnZXIgdGhhbiAxIGJ5dGUgLSBzbyBhIG11bHRpcGx5IGlz
IG5lZWRlZC4NClByb2JhYmx5IHdvcnRoIHRlc3Rpbmcgc29tZXRoaW5nIHRoYXQgaXNuJ3QgYSBw
b3dlciBvZiAyLg0KQWxzbyBjaGVjayAzMmJpdCBhcmNocyAtZ29kYm9sdCBjYW4gaGVscC4NCg0K
CURhdmlkDQoNCj4gDQo+ICAgMDAwMDAwMDAwMDAwMDAxMCA8Zm9vPjoNCj4gICAgIDEwOiAgIGYz
IDBmIDFlIGZhICAgICAgICAgICAgIGVuZGJyNjQNCj4gICAgIDE0OiAgIDg5IGY4ICAgICAgICAg
ICAgICAgICAgIG1vdiAgICAlZWRpLCVlYXgNCj4gICAgIDE2OiAgIDQ4IDgzIGMwIDEwICAgICAg
ICAgICAgIGFkZCAgICAkMHgxMCwlcmF4DQo+ICAgICAxYTogICBlOSAwMCAwMCAwMCAwMCAgICAg
ICAgICBqbXAgICAgMWYgPGZvbysweGY+DQoNCkFkZCAtZCB0byBvYmpkdW1wIHRvIGdldCB0aGUg
cmVsb2NhdGlvbiBwcmludGVkLg0KKEkgdGhpbmsgdGhpcyBpcyBhIGJ1aWxkIHdoZXJlICdyZXQn
IGlzbid0IGFsbG93ZWQgOi0pDQoNCglEYXZpZA0KDQo+IA0KPiBIZXJlLCBubyBTSVpFX01BWCBi
ZWNhdXNlIHRoZSBtdWx0aXBsaWNhdGlvbiBjYW4gbm90IHdyYXBhcm91bmQNCj4gcmVnYXJkbGVz
cyBvZiB0aGUgdmFsdWUgb2YgY291bnQuIEl0IGlzIG9ubHkgYWZ0ZXIgY2hhbmdpbmcgdGhlIHR5
cGUNCj4gb2YgY291bnQgdG8gdTY0IHRoYXQgdGhlIGNvbXBpbGVyIHdpbGwgZW1pdCBhIGNvbXBh
cmlzb246DQo+IA0KPiAwMDAwMDAwMDAwMDAwMDEwIDxmb28+Og0KPiAgIDEwOiAgIGYzIDBmIDFl
IGZhICAgICAgICAgICAgIGVuZGJyNjQNCj4gICAxNDogICA0OCA4ZCA0NyAxMCAgICAgICAgICAg
ICBsZWEgICAgMHgxMCglcmRpKSwlcmF4DQo+ICAgMTg6ICAgNDggODMgZmYgZjAgICAgICAgICAg
ICAgY21wICAgICQweGZmZmZmZmZmZmZmZmZmZjAsJXJkaQ0KPiAgIDFjOiAgIDQ4IGM3IGMyIGZm
IGZmIGZmIGZmICAgIG1vdiAgICAkMHhmZmZmZmZmZmZmZmZmZmZmLCVyZHgNCj4gICAyMzogICA0
OCAwZiA0MyBjMiAgICAgICAgICAgICBjbW92YWUgJXJkeCwlcmF4DQo+ICAgMjc6ICAgZTkgMDAg
MDAgMDAgMDAgICAgICAgICAgam1wICAgIDJjIDxmb28rMHgxYz4NCj4gDQo+IEZvciByZWZlcmVu
Y2UsIHRoaXMgaXMgdGhlIGNvZGUgYWZ0ZXIgYXBwbHlpbmcgbXkgcGF0Y2gsIHdpdGggY291bnQg
YXMgYSB1MzI6DQo+IA0KPiAgIDAwMDAwMDAwMDAwMDAwMTAgPGZvbz46DQo+ICAgICAxMDogICBm
MyAwZiAxZSBmYSAgICAgICAgICAgICBlbmRicjY0DQo+ICAgICAxNDogICA4OSBmOCAgICAgICAg
ICAgICAgICAgICBtb3YgICAgJWVkaSwlZWF4DQo+ICAgICAxNjogICBiYSAxMCAwMCAwMCAwMCAg
ICAgICAgICBtb3YgICAgJDB4MTAsJWVkeA0KPiAgICAgMWI6ICAgNDggODMgYzAgMGMgICAgICAg
ICAgICAgYWRkICAgICQweGMsJXJheA0KPiAgICAgMWY6ICAgNDggMzkgZDAgICAgICAgICAgICAg
ICAgY21wICAgICVyZHgsJXJheA0KPiAgICAgMjI6ICAgNDggMGYgNDIgYzIgICAgICAgICAgICAg
Y21vdmIgICVyZHgsJXJheA0KPiAgICAgMjY6ICAgZTkgMDAgMDAgMDAgMDAgICAgICAgICAgam1w
ICAgIDJiIDxmb28rMHgxYj4NCj4gDQo+IGFuZCB3aXRoIGNvdW50IGFzIGEgdTY0Og0KPiANCj4g
ICAwMDAwMDAwMDAwMDAwMDEwIDxmb28+Og0KPiAgICAgMTA6ICAgZjMgMGYgMWUgZmEgICAgICAg
ICAgICAgZW5kYnI2NA0KPiAgICAgMTQ6ICAgNDggODMgYzcgMGMgICAgICAgICAgICAgYWRkICAg
ICQweGMsJXJkaQ0KPiAgICAgMTg6ICAgNzIgMTEgICAgICAgICAgICAgICAgICAgamIgICAgIDJi
IDxmb28rMHgxYj4NCj4gICAgIDFhOiAgIGI4IDEwIDAwIDAwIDAwICAgICAgICAgIG1vdiAgICAk
MHgxMCwlZWF4DQo+ICAgICAxZjogICA0OCAzOSBjNyAgICAgICAgICAgICAgICBjbXAgICAgJXJh
eCwlcmRpDQo+ICAgICAyMjogICA0OCAwZiA0MyBjNyAgICAgICAgICAgICBjbW92YWUgJXJkaSwl
cmF4DQo+ICAgICAyNjogICBlOSAwMCAwMCAwMCAwMCAgICAgICAgICBqbXAgICAgMmIgPGZvbysw
eDFiPg0KPiAgICAgMmI6ICAgNDggODMgYzggZmYgICAgICAgICAgICAgb3IgICAgICQweGZmZmZm
ZmZmZmZmZmZmZmYsJXJheA0KPiAgICAgMmY6ICAgZTkgMDAgMDAgMDAgMDAgICAgICAgICAgam1w
ICAgIDM0IDxmb28rMHgyND4NCj4gDQo+IFRoYW5rIHlvdSBmb3IgeW91ciBjb21tZW50cyENCj4g
DQo+IA0KPiBZb3VycyBzaW5jZXJlbHksDQo+IFZpbmNlbnQgTWFpbGhvbA0KDQotDQpSZWdpc3Rl
cmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtl
eW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

