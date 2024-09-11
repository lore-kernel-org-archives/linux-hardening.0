Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F211802DD
	for <linux-hardening@vger.kernel.org>; Wed, 11 Sep 2024 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050219; cv=none; b=Qx4UtHlFiZzT2UiW1KO+v2o2oARS2fK87ylY0vGre1F5pHgM1xXQOOEJnEk+RMH2yiwW7H/mtnMo1CnCvhYqOjI9OtwXs0NeCb78yNbG7HMDmx408odcYiuj2dSHftaSOMg8RPv/BjpbKI6GVIu+NN9bVMuXQu89Znj3zmrNcB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050219; c=relaxed/simple;
	bh=RjkFVTihyDMf4i/BX/SS17HHOjg0Vnw9Qb6XkSUBQmE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=ilYXtBi8z/5zfhUkPIlhkHPWOW4hszUaFTmIixxpP4T1WQsYwCpWG+81ScsSFtFcB4bolJSp1t6yL0J6ETW07Wnx0aB8uMB9vkriymY1mTkVLOnM1APr0KIugMJZExSzt/JSZwk6Kx/y8jW4/lCvYfhcB65BfmqyyHG3Nh/Oqzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-320-hEjlClOWPyiYxr_y0pLaIQ-1; Wed, 11 Sep 2024 11:23:29 +0100
X-MC-Unique: hEjlClOWPyiYxr_y0pLaIQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 11 Sep
 2024 11:22:44 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 11 Sep 2024 11:22:44 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Vincent Mailhol' <mailhol.vincent@wanadoo.fr>, Kees Cook
	<kees@kernel.org>
CC: "Gustavo A . R . Silva" <gustavoars@kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] overflow: optimize struct_size() calculation
Thread-Topic: [PATCH v2] overflow: optimize struct_size() calculation
Thread-Index: AQHbAywJ58VR+K3+gU6+o+9bWfd3j7JSX6zQ
Date: Wed, 11 Sep 2024 10:22:44 +0000
Message-ID: <01aa8bd408d04031941073b026f171fb@AcuMS.aculab.com>
References: <20240910024952.1590207-1-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20240910024952.1590207-1-mailhol.vincent@wanadoo.fr>
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

RnJvbTogVmluY2VudCBNYWlsaG9sDQo+IFNlbnQ6IDEwIFNlcHRlbWJlciAyMDI0IDAzOjUwDQo+
IA0KPiBJZiB0aGUgb2Zmc2V0b2YoKSBvZiBhIGdpdmVuIGZsZXhpYmxlIGFycmF5IG1lbWJlciAo
ZmFtKSBpcyBzbWFsbGVyDQo+IHRoYW4gdGhlIHNpemVvZigpIG9mIHRoZSBjb250YWluaW5nIHN0
cnVjdCwgdGhlbiB0aGUgc3RydWN0X3NpemUoKQ0KPiBtYWNybyByZXBvcnRzIGEgc2l6ZSB3aGlj
aCBpcyB0b28gYmlnLg0KPiANCj4gVGhpcyBvY2N1cnMgd2hlbiB0aGUgdHdvIGNvbmRpdGlvbnMg
YmVsb3cgYXJlIG1ldDoNCj4gDQo+ICAgLSB0aGVyZSBhcmUgcGFkZGluZyBieXRlcyBhZnRlciB0
aGUgcGVudWx0aW1hdGUgbWVtYmVyICh0aGUgbWVtYmVyDQo+ICAgICBwcmVjZWRpbmcgdGhlIGZh
bSkNCj4gICAtIHRoZSBhbGlnbm1lbnQgb2YgdGhlIGZhbSBpcyBsZXNzIHRoYW4gb3IgZXF1YWwg
dG8gdGhlIHBlbnVsdGltYXRlDQo+ICAgICBtZW1iZXIncyBhbGlnbm1lbnQNCj4gDQo+IEluIHRo
YXQgY2FzZSwgdGhlIGZhbSBvdmVybGFwcyB3aXRoIHRoZSBwYWRkaW5nIGJ5dGVzIG9mIHRoZQ0K
PiBwZW51bHRpbWF0ZSBtZW1iZXIuIFRoaXMgYmVoYXZpb3VyIGlzIG5vdCBjYXB0dXJlZCBpbiB0
aGUgY3VycmVudA0KPiBzdHJ1Y3Rfc2l6ZSgpIG1hY3JvLCBwb3RlbnRpYWxseSByZXN1bHRpbmcg
aW4gYW4gb3ZlcmVzdGltYXRlZCBzaXplLg0KLi4uDQo+IENoYW5nZSBzdHJ1Y3Rfc2l6ZSgpIGZy
b20gdGhpcyBwc2V1ZG8gY29kZSBsb2dpYzoNCj4gDQo+ICAgc2l6ZW9mKHN0cnVjdCBzKSArIHNp
emVvZigqcy5mYW0pICogcy5jb3VudA0KPiANCj4gdG8gdGhhdCBwc2V1ZG8gY29kZSBsb2dpYzoN
Cj4gDQo+ICAgbWF4KHNpemVvZihzdHJ1Y3QgcyksIG9mZnNldG9mKHN0cnVjdCBzLCBmYW0pICsg
c2l6ZW9mKCpzLmZhbSkgKiBzLmNvdW50KQ0KDQpZb3UgYXJlIGFkZGluZyBhIHRoaXJkIGNvbXBh
cmlzb24gWzFdIHRvIGV2ZXJ5IGNhbGwgLSBldmVuIHRob3VnaCBtb3N0IGRvbid0DQpuZWVkIGl0
IGFuZCB0aGUgbWVtb3J5IHNhdmluZyBpcyBtYXJnaW5hbCBhdCBiZXN0Lg0KVGhlIHRvdGFsIGNv
ZGUgc2l6ZSBpbmNyZWFzZSBjb3VsZCBlYXNpbHkgZXhjZWVkIGFueSBzYXZpbmdzLg0KDQpXaXRo
IGNhcmUgeW91IG9ubHkgZG8gdGhlIG1heCgpIHdoZW4gc2l6ZW9mKHN0cnVjdCkgIT0gb2Zmc2V0
b2YoKSBidXQgSSBkb3VidA0KdGhlIGNvbXBsZXhpdHkgaXMgd29ydGggaXQuDQoNClsxXSBCb3Ro
IHRoZSAnKycgYW5kICcqJyBoYXZlIGV4dHJhIGNvZGUgdG8gZGV0ZWN0IG92ZXJmbG93IGFuZCBy
ZXR1cm4NCiAgYSAnYmlnJyB2YWx1ZSB0aGF0IHdpbGwgY2F1c2Uga21hbGxvYygpIHRvIHJldHVy
biBOVUxMLg0KSSd2ZSBub3QgbG9va2VkIGF0IHRoZSBnZW5lcmF0ZWQgY29kZSBidXQgaXQgaXMg
bGlrZWx5IHRvIGJlIGhvcnJpZA0KICAoZXNwZWNpYWxseSB0aGUgY2hlY2sgZm9yIG11bHRpcGx5
IG92ZXJmbG93aW5nKS4NCkluIHRoaXMgY2FzZSB0aGVyZSBhcmUgZW5vdWdoIGNvbnN0YW50cyB0
aGF0IHRoZSBhbHRlcm5hdGl2ZSBjaGVjazoNCglpZiAoY291bnQgPiAoTUFYX1NJWkUgLSBzaXpl
b2YgKCpzKSkgLyBzaXplb2YgKHMtPm1lbWJlcikpDQoJCXNpemUgPSBNQVhfU0laRTsNCgllbHNl
DQoJCXNpemUgPSBzaXplb2YgKCpzKSArIGNvdW50ICogc2l6ZW9mIChzLT5tZW1iZXIpOw0KaXMg
ZmluZSBhbmQgb25seSBoYXMgb25lIGNvbmRpdGlvbmFsIGluIGl0Lg0KSW4gc29tZSBjYXNlcyB0
aGUgY29tcGlsZXIgbWF5IGFscmVhZHkga25vdyB0aGF0IHRoZSBjb3VudCBpcyBzbWFsbCBlbm91
Z2guDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkg
Um9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlv
biBObzogMTM5NzM4NiAoV2FsZXMpDQo=

