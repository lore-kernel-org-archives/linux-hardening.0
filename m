Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EC582876
	for <linux-hardening@vger.kernel.org>; Thu,  9 May 2024 21:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715288853; cv=none; b=OAJFnK/BwBKrgemnpdMmcT4lUGoewCXVNFNl06qy5sidm+lGyLAnAgEMChome6ortYvlDnlNqKZw1d6HdtZGchJRwZy8H+3GM0ZRQZTavQkKIR3Bx0Gv2VRD3T/GhUzmiGEe6AmmSUv4EFgwCOQYxkAhG8aHYJT8329ux7HhIwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715288853; c=relaxed/simple;
	bh=goPKHQtoFbBJPMAI4x6He30hxH7vdSTb8jLbZxEZRIs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=MGB2WcmPN7+qZy6Bg2FqBYPkE83VtqHIkomUjiW2Ogd+m19Xr2U84Z20EdGzVlnoDVcKrXiKN4xDqZf/U554Gl/zCuBPrAes6vYfXzikGCLeSc7YNgP/+OWMM2pgNC5SHapleMh2aZsWQ6Bs9BeZVyconeyhKpxy8GIK/UT/itI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-174-MlsT2Si9P0yTWZ8FtgmvYw-1; Thu, 09 May 2024 22:07:23 +0100
X-MC-Unique: MlsT2Si9P0yTWZ8FtgmvYw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 9 May
 2024 22:06:54 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 9 May 2024 22:06:54 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>, Theodore Ts'o
	<tytso@mit.edu>
CC: Kees Cook <keescook@chromium.org>, Justin Stitt <justinstitt@google.com>,
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [RFC] Mitigating unexpected arithmetic overflow
Thread-Topic: [RFC] Mitigating unexpected arithmetic overflow
Thread-Index: AQHaoibwK91jQ1nmYEmzGISNIfAGlrGPY2nw
Date: Thu, 9 May 2024 21:06:54 +0000
Message-ID: <5b37e8b1da534ebb8abc9b7b0f7022d2@AcuMS.aculab.com>
References: <202404291502.612E0A10@keescook>
 <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook>
 <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook>
 <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
 <202405081949.0565810E46@keescook> <20240509140854.GF3620298@mit.edu>
 <CAHk-=wgKyP2ffZPa6aKYtytzzFibiNVN5MS=D2cn7_UGCECKdw@mail.gmail.com>
In-Reply-To: <CAHk-=wgKyP2ffZPa6aKYtytzzFibiNVN5MS=D2cn7_UGCECKdw@mail.gmail.com>
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

Li4uDQo+IEdvaW5nIHRoZSBvdGhlciB3YXkgaXMgc2ltaWxhcjoNCj4gDQo+ICAgICAgICAgYWxs
X2JpdHMgPSBsb3dfYml0cyArICgodTY0KSBoaWdoX2JpdHMgPDwgMTYpIDw8IDE2KTsNCj4gDQo+
IGFuZCBhZ2FpbiwgdGhlIGNvbXBpbGVyIHdpbGwgcmVjb2duaXplIHRoaXMgaWRpb20gYW5kIGRv
IHRoZSByaWdodA0KPiB0aGluZyAoYW5kIGlmICdhbGxfYml0cycgaXMgb25seSAzMi1iaXQsIHRo
ZSBjb21waWxlciB3aWxsIG9wdGltaXplDQo+IHRoZSBoaWdoIGJpdCBub2lzZSBhd2F5KS4NCg0K
T24gYSAzMmJpdCBzeXN0ZW0gdGhlIGNvbXBpbGVyIG1pZ2h0IG5vdCBkbyB0aGUgZXhwZWN0ZWQg
dGhpbmcuDQoNCkkgaGFkIHRlcnJpYmxlIHRyb3VibGUgd2l0aCB0aGUgMzJiaXQgZGl2X3U2NF91
MzIoKSBjb2RlIEkgd2FzDQpwbGF5aW5nIHdpdGggZ2V0dGluZyB0aGUgY29tcGlsZXIgdG8gZG8g
J3NvbWV0aGluZyBzZW5zaWJsZScgZm9yDQp0aGF0Lg0KSSBqdXN0IGNvdWxkbid0IGdldCBpdCB0
byBzdG9wIGdlbmVyYXRpbmcgdHdvIDY0Yml0IHZhbHVlcw0KKGluIHR3byByZWdpc3RlciBwYWly
cykgYW5kIHRoZW4gb3JpbmcgdGhlbSB0b2dldGhlci4NCkkgZGlkbid0IHRyeSB1c2luZyBhIHVu
aW9uIC0gdGhhdCBtaWdodCB3b3JrLg0KT24geDY0IHRoZSBhc20gIkEiIChlZHg6ZWF4KSBhbmQg
ImEiIGFuZCAiZCIgY29uc3RyYWludHMgd2lsbCBEVFJUDQpidXQgZm9yY2UgdGhlIHZhbHVlcyBp
bnRvIGVkeDplYXggd2hpY2ggaXMgb2sgaWYgeW91IGFyZSBkb2luZyBkaXZpZGVzLg0KDQoJRGF2
aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50
IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTcz
ODYgKFdhbGVzKQ0K

