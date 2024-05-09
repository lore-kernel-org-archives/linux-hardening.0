Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995798405C
	for <linux-hardening@vger.kernel.org>; Thu,  9 May 2024 21:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715289842; cv=none; b=kiPy/07Cc65kyMBMbwOSE5DrpxEh5zq03/Q94Jhgga4KGVVzbjTgizCoHtguusZ5kYZfCvkaKyVUzCYlD3mmQ6xiEwxbvMBB8Ldd0dcb7TdkyvU4uAuLfxnEEQQjJybvl6Ou5choL9cWpn8QRHUxoTShHdh0kel2GOqumdzcX68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715289842; c=relaxed/simple;
	bh=SEFpFTBcxfnU5YKbgVM3TPjMbGxapd0haMRAIoOJewg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=QjCTnxQEQ150bS+d1uoaiPo991ULIhWRNWS/B/l0SvMrwEQx5oUmKXq1hlZfphnWYUqFvfN3Bl8/5muMBX1EVe/7aARz/rITeWd1j/kZPzLLScXFPQ99Qk8PPUPHOjDndPOmBK983H22Ku0rwol9/S3/x35Z9lRoHyX/5cBfia4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-262-ZHxZcEbrMxKlg_Jm_e8yvA-1; Thu, 09 May 2024 22:23:57 +0100
X-MC-Unique: ZHxZcEbrMxKlg_Jm_e8yvA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 9 May
 2024 22:23:29 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 9 May 2024 22:23:29 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>, Kees Cook
	<keescook@chromium.org>
CC: Justin Stitt <justinstitt@google.com>, Peter Zijlstra
	<peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [RFC] Mitigating unexpected arithmetic overflow
Thread-Topic: [RFC] Mitigating unexpected arithmetic overflow
Thread-Index: AQHaoaITK91jQ1nmYEmzGISNIfAGlrGPZyIw
Date: Thu, 9 May 2024 21:23:29 +0000
Message-ID: <f41cd250b90d4eb883ea5ff245718200@AcuMS.aculab.com>
References: <202404291502.612E0A10@keescook>
 <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook>
 <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook>
 <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
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

Li4uDQo+IEkgdGhpbmsgdGhhdCB3b3VsZCBiZSBhIGNvbXBsZXRlbHkgZGlmZmVyZW50IGFyZWEg
dGhhdCBtaWdodCBiZSB3b3J0aA0KPiBsb29raW5nIGF0OiBpbnN0cnVtZW50aW5nIGltcGxpY2l0
IGNhc3RzIGZvciAiZHJvcHMgYml0cyIuIEknbSBhZnJhaWQNCj4gdGhhdCBpdCdzIGp1c3QgKnNv
KiBjb21tb24gdGhhbiB3ZSBtaWdodCBub3QgYmUgYWJsZSB0byBkbyB0aGF0DQo+IHNhbmVseS4N
Cg0KVGhpbmdzIGxpa2U6DQoJYnVmWzBdID0gdmFsOw0KCWJ1ZlsxXSA9IHZhbCA+Pj0gODsNCgli
dWZbMl0gPSB2YWwgPj49IDg7DQoJYnVmWzNdID0gdmFsID4+PSA4Ow0KZm9yIHdyaXRpbmcgYSB2
YWx1ZSBsaXR0bGUtZW5kaWFuIGFuZCBwb3RlbnRpYWxseSBtaXNhbGlnbmVkLg0KUmVhbGx5IGRv
ZXNuJ3Qgd2FudCBhbnkgYW5ub3RhdGlvbi4NCg0KSSd2ZSBhbHNvIHNlZW4gY29kZSBsaWtlOg0K
CWJ1ZlswXSA9ICh1bnNpZ25lZCBjaGFyKSh2YWwgJiAweGZmKTsNCm5vdCBvbmx5IHVnbHkgYnkg
aXQgZ290IGNvbXBpbGVkIHRvOg0KCXZhbCAmPSAweGZmIC8vIGZvciB0aGUgJg0KCXZhbCAmPSAw
eGZmIC8vIGZvciB0aGUgY2FzdA0KCWJ5dGUgd3JpdGUgdG8gbWVtb3J5Lg0KTW9kZXJuIGdjYyBk
b2Vzbid0IGRvIHRoYXQsIGJ1dC4uLg0KDQpUaGVyZSBhcmUgc29tZSBzcHVyaW91cyBjYXN0cyB0
aGF0IGRyb3AgYml0cy4NCkkgZm91bmQgcGxlbnR5IG9mIGR1YmlvdXMgbWluX3QodTgvdTE2LC4u
LikgZXhhbXBsZXMuDQooV2VsbCB0aGV5IGFyZSBkdWJpb3VzLCBzb21lIGFyZSBqdXN0IGEgbG90
IG1vcmUgZHViaW91cyB0aGFuIG90aGVycy4pDQpUaGUgcHJvYmxlbSBpcyB0aGF0IGV2ZXJ5IG9u
ZSBuZWVkcyBjYXJlZnVsIGluc3BlY3Rpb24ganVzdCBpbiBjYXNlDQp0aGUgc3RyYW5nZSBiZWhh
dmlvdXIgaXMgcmVxdWlyZWQgbGlrZSBtaW5fdCh1OCwgdmFsIC0gMSwgbG9fbGltIC0gMSkNCndo
aWNoIHRyZWF0cyBsb19saW0gb2YgemVybyBhcyAnbm90IGEgbGltaXQnIGFuZCBJIHRoaW5rIHdh
cyBvay4NCg0KQSBzbG93LCBjb25jZXJ0ZWQgZWZmb3J0IHRvIHJlbW92ZSBtaW5fdCgpIGNhbGxz
IHdvdWxkbid0IGJlIGEgYmFkIHRoaW5nLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRy
ZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1L
MSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

