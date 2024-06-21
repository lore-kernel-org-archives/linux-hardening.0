Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AFC171E41
	for <linux-hardening@vger.kernel.org>; Fri, 21 Jun 2024 11:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969928; cv=none; b=Mi16o1nM7/Ki33Hz8QCS4HDhq5m3UbLNsoKukZMOyH5cYLOJ+bdqpFho3vD0jbmvAXvyQLWaTlO3NK08H7hNcI62KCO74/bxh4NuRkbQARojEnQsEiKzPsBk+/QE5/cMJJyO0DQOf2EQFPtivCerhBS2QuySKcY8fDQEGvj2Xww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969928; c=relaxed/simple;
	bh=qNele2Oqe7XHnJ1CRHAoX0YzlVUc7SVZQpM/MCDav7E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W+viZlgOa/UDJtoDPRP8vzjjyiehhYL8D0DuBCBPpa8T0tLEskjexU7cNJg+nFAMmylVnOtn+qF8uZm2YFHW8wAKwYhVuvKIGzg2ysq+vaJf6+cazGG2zeQ42mF6Dcc/eotu8JUkAScV4jwCFchZ9GdnMiBastBIe7or1JwAO1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=U4TZlGj1; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="U4TZlGj1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1718969923;
	bh=qNele2Oqe7XHnJ1CRHAoX0YzlVUc7SVZQpM/MCDav7E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=U4TZlGj1Jc9QFDIrMqe9M9fZu8bBXe+ZxW+kt7zsQ7QWJLMEH0RRKJ+GFTIw/3Awd
	 kEXyHWoKT2B0Pdn90yx3QUlxIplQQwtckG5ftIm5MCySSSF+l21T2xvIBGRj/H3RKR
	 V0qpGdDUKmlbTqYaIUUJAcPbvcmsAbJdB5kZpwiZijKlPmlYkRBqO0BkEFuMuI3vc8
	 +P3UmOMnw2VMqK+RRHSYUDIs2Aowe2tCwO2NDG/EbIWeA4owMu7Q7wUMs04B0RHfLg
	 pfx9e8TjLnJK589Sp9vYV5l0z1dqjlPnLwcPZHFHsMS5u0MbXqW8xC6k/hTmmryd/G
	 EKJSNRpHB+F0Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4W5Fjt6GVcz4wbr;
	Fri, 21 Jun 2024 21:38:42 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anjali K <anjalik@linux.ibm.com>, Kees Cook <kees@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com, naveen@kernel.org,
 christophe.leroy@csgroup.eu, gustavoars@kernel.org,
 linux-hardening@vger.kernel.org, vishalc@linux.ibm.com
Subject: Re: [PATCH] powerpc/pseries: Whitelist dtl slub object for copying
 to userspace
In-Reply-To: <45c38d92-8d7c-466c-833d-0c2aa389eeda@linux.ibm.com>
References: <20240614173844.746818-1-anjalik@linux.ibm.com>
 <202406171053.F72BF013@keescook> <87cyoe67zg.fsf@mail.lhotse>
 <45c38d92-8d7c-466c-833d-0c2aa389eeda@linux.ibm.com>
Date: Fri, 21 Jun 2024 21:38:41 +1000
Message-ID: <87zfrecypq.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

QW5qYWxpIEsgPGFuamFsaWtAbGludXguaWJtLmNvbT4gd3JpdGVzOg0KPiBIaSBNaWNoYWVsDQo+
DQo+IE9uIDE4LzA2LzI0IDEyOjQxLCBNaWNoYWVsIEVsbGVybWFuIHdyb3RlOg0KPj4gSSBndWVz
cyB0aGVyZSBpc24ndCBhIGttZW1fY2FjaGVfY3JlYXRlX3VzZXJfcmVhZG9ubHkoKSA/DQoNCj4g
VGhhbmsgeW91IGZvciB5b3VyIHJldmlldy7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIMKgDQo+IA0KPiBNeSB1bmRlcnN0YW5kaW5nIG9mIHRoZSBxdWVzdGlvbiBp
cyB3aGV0aGVyIHRoZXJlJ3MgYSB3YXkgdG8gd2hpdGVsaXN0IGHCoCDCoA0KPiByZWdpb24gc3Vj
aCB0aGF0IGl0IGNhbiBiZSBjb3BpZWQgdG8gdXNlcnNwYWNlLCBidXQgbm90IHdyaXR0ZW4gdG8g
dXNpbmfCoCDCoA0KPiBjb3B5X2Zyb21fdXNlcigpLsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgwqANCiANClllcyB0aGF0J3Mgd2hh
dCBJIG1lYW50LCBhbmQgSSBwcmV0dHkgbXVjaCB3b3JrZWQgdGhhdCBvdXQgZnJvbSBsb29raW5n
DQphdCB0aGUgaW1wbGVtZW50YXRpb24sIGJ1dCB3YXMgaG9waW5nIEtlZXMgd291bGQgdGVsbCBt
ZSBpdCB3YXMgdGhlcmUNCnNvbWV3aGVyZSwgb3IgaW1wbGVtZW50IGl0IDopICBBcG9sb2dpZXMg
Zm9yIGJlaW5nIGNyeXB0aWMuDQoNCj4gTm8sIHdlIGRvbid0IGhhdmUgYSBmdW5jdGlvbiB0byB3
aGl0ZWxpc3Qgb25seSBmb3IgY29weV90b191c2VyKCkgYW5kIG5vdCDCoA0KPiBjb3B5X2Zyb21f
dXNlcigpLg0KDQpZZXAuIEknbGwgdGFrZSB0aGlzIHBhdGNoIGFzLWlzLCBJIHRoaW5rIHdlJ3Zl
IGVzdGFibGlzaGVkIHRoYXQgaXQncw0KcHJldHR5IGxvdyByaXNrIHRvIHdoaXRlbGlzdCB0aGUg
d2hvbGUgY2FjaGUuDQoNCmNoZWVycw0K
