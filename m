Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4BC13FE7;
	Fri, 17 May 2024 06:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715926813; cv=none; b=n3sCvSJZUx7bKRNLk9yxy/mjIDBS2lSAMLu5xcNAqdqw6heT3a1C6u/D0Fh1nXTk3aKt/z1GUw6/oDJSK9Z/rsJElkh3NpMAxPELFWytIdM3GQA7D0jFbkTtpYMcmwRS7RaZeS4ocDrOOFEBkCRN+SB738QG+Nu7siKMVrtGI3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715926813; c=relaxed/simple;
	bh=jv6dPELYByxQV+0Xdw6012jdmqIKWS3qeRtbi4LR4Io=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CPCz0X4RiL12jjXmPwTcY0nxf3s03p1n76aaM9xMR30IkEEbDxCZVZoSvtHij7Hf4a0zWVFFcvJqjcjW+x2TbE3Vu/ZXNvRC+iJoQoV8B+5HkSwtqD0mKzisU+g25UTFESQb4ChvwY+0XTEB/j7nGpOmX4vvYNZ81jLFOtkrwRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=atEhoSDp; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="atEhoSDp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1715926812; x=1747462812;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:mime-version:content-transfer-encoding:subject;
  bh=jv6dPELYByxQV+0Xdw6012jdmqIKWS3qeRtbi4LR4Io=;
  b=atEhoSDp9Kyc6PFolObVaI3HlwUKFZg4+jp9wGlXjsTV3EYx/NcnoUsA
   X5uoEY9ZE1AIdZteRN0S8DWHOM8y/H1SNLy9t4/yRtMBv3qUcHT7jWtwL
   i/kHChjOJL0Np5Je71AZdNu90jRbxHRkz3kxZed1A/svb+8E50gKox07T
   E=;
X-IronPort-AV: E=Sophos;i="6.08,166,1712620800"; 
   d="scan'208";a="633432168"
Subject: Re: Extending Linux' Coverity model and also cover aarch64
Thread-Topic: Extending Linux' Coverity model and also cover aarch64
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 06:20:09 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.10.100:14935]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.39.135:2525] with esmtp (Farcaster)
 id 0bfbf25c-29ea-45a3-9531-7ffb12e00470; Fri, 17 May 2024 06:19:51 +0000 (UTC)
X-Farcaster-Flow-ID: 0bfbf25c-29ea-45a3-9531-7ffb12e00470
Received: from EX19D043EUC003.ant.amazon.com (10.252.61.176) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 17 May 2024 06:19:50 +0000
Received: from EX19D002EUC004.ant.amazon.com (10.252.51.230) by
 EX19D043EUC003.ant.amazon.com (10.252.61.176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 17 May 2024 06:19:50 +0000
Received: from EX19D002EUC004.ant.amazon.com ([fe80::fa57:3c1:c670:f520]) by
 EX19D002EUC004.ant.amazon.com ([fe80::fa57:3c1:c670:f520%3]) with mapi id
 15.02.1258.028; Fri, 17 May 2024 06:19:50 +0000
From: "Manthey, Norbert" <nmanthey@amazon.de>
To: "keescook@chromium.org" <keescook@chromium.org>
CC: "Woodhouse, David" <dwmw@amazon.co.uk>, "Stieger, Andreas"
	<astieger@amazon.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, "Hemdan, Hagar Gamal Halim"
	<hagarhem@amazon.de>
Thread-Index: AQHap6Wsmrdu7IK9QEOStpjMecz3DrGaPOKAgAC4NgA=
Date: Fri, 17 May 2024 06:19:50 +0000
Message-ID: <d9dfab9a24297ce0bb9cbafb3968814d7ebe368d.camel@amazon.de>
References: <77f6e6fc46232db82a3c63e93877c9534334e407.camel@amazon.de>
	 <202405161217.4984DE258@keescook>
In-Reply-To: <202405161217.4984DE258@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <0653343B2711DE498FCF19419B42374D@amazon.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64

T24gVGh1LCAyMDI0LTA1LTE2IGF0IDEyOjIwIC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IENB
VVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXph
dGlvbi4gRG8NCj4gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSBjYW4gY29uZmlybSB0aGUgc2VuZGVyDQo+IGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUu
DQo+IA0KPiANCj4gDQo+IE9uIFRodSwgTWF5IDE2LCAyMDI0IGF0IDAzOjI4OjE2UE0gKzAwMDAs
IE1hbnRoZXksIE5vcmJlcnQgd3JvdGU6DQo+ID4gd2UgcHVibGlzaGVkIGFuIGV4dGVuc2lvbiBm
b3IgdGhlIENvdmVyaXR5IG1vZGVsIHRoYXQgaXMgdXNlZCBieQ0KPiA+IHRoZQ0KPiA+IENvdmVy
aXR5U2NhbiBzZXR1cCBmb3IgdGhlIExpbnV4IGtlcm5lbCBbMV0uIFdlIGhhdmUgYmVlbiB1c2lu
Zw0KPiA+IHRoaXMNCj4gPiBleHRlbnNpb24gdG8gYW5hbHl6ZSB0aGUgNi4xIGtlcm5lbCBicmFu
Y2gsIGFuZCByZXBvcnRlZCBzb21lIGZpeGVzDQo+ID4gdG8NCj4gPiB0aGUgdXBzdHJlYW0gY29k
ZSBiYXNlIHRoYXQgYXJlIGJhc2VkIG9uIHRoaXMgbW9kZWwgWzJdLiBGZWVsIGZyZWUNCj4gPiB0
bw0KPiA+IG1lcmdlIHRoZSBwdWxsIHJlcXVlc3QsIGFuZCB1cGRhdGUgdGhlIG1vZGVsIGluIHRo
ZSBDb3Zlcml0eVNjYW4NCj4gPiBzZXR1cC4NCj4gPiBXZSBkbyBub3QgaGF2ZSBhY2Nlc3MgdG8g
dGhhdCBwcm9qZWN0IHRvIHBlcmZvcm0gdGhlc2UgdXBkYXRlcw0KPiA+IG91cnNlbHZlcy4NCj4g
DQo+IFRoYW5rcyBmb3IgdGhpcyEgSSdsbCBnZXQgaXQgbG9hZGVkIGludG8gdGhlIExpbnV4LU5l
eHQgc2Nhbm5lci4NCg0KTmljZSwgdGhhbmtzIQ0KDQo+IA0KPiA+IFRvIGluY3JlYXNlIHRoZSBh
bmFseXNpcyBjb3ZlcmFnZSB0byBhYXJjaDY0LCB3ZSBhbmFseXplZCBhIHg4NiBhbmQNCj4gPiBh
DQo+ID4gYWFyY2g2NCBjb25maWd1cmF0aW9uLiBUaGUgaW5jcmVhc2VkIGNvdmVyYWdlIGlzIGFj
aGlldmVkIGJ5IHVzaW5nDQo+ID4gcmUtDQo+ID4gY29uZmlndXJhdGlvbiBhbmQgY3Jvc3MtY29t
cGlsYXRpb24gZHVyaW5nIHRoZSBhbmFseXNpcyBidWlsZC4gSWYNCj4gPiB5b3UNCj4gPiBhcmUg
aW50ZXJlc3RlZCBpbiB0aGlzIHNldHVwIHdlIGNhbiBzaGFyZSB0aGUgRG9ja2VyZmlsZSBhbmQg
c2NyaXB0DQo+ID4gd2UNCj4gPiB1c2VkIGZvciB0aGlzIHByb2Nlc3MuDQo+IA0KPiBXZSd2ZSBv
bmx5IGdvdCBhY2Nlc3MgdG8gdGhlIGZyZWUgQ292ZXJpdHkgc2Nhbm5lciwgYnV0IGl0IHdvdWxk
IGJlDQo+IG5pY2UNCj4gdG8gc2VlIGlmIHRoZXJlIHdhcyBhbnl0aGluZyBzcGVjaWZpYyB0byBh
cm02NC4NCg0KWWVzLCBJIHVuZGVyc3RhbmQuIENhbiB5b3Ugc2hvdyBob3cgdGhhdCBmcmVlIHNj
YW5uZXIgaXMgdXNlZD8gV2UNCnR3ZWFrZWQgdGhlIGNvbW1hbmQgd2UgZmVkIGludG8gdGhlICJj
b3YtYnVpbGQiIHRvb2wuIFRoaXMgdG9vbCBzaG91bGQNCmJlIHBhcnQgb2YgdGhlIHNjYW5uZXIg
KGlmIEkgcmVtZW1iZXIgdGhhdCBjb3JyZWN0bHkpLg0KDQo+IA0KPiA+IFRvIHByZXZlbnQgcmVn
cmVzc2lvbnMgaW4gYmFja3BvcnRzIHRvIExUUyBrZXJuZWxzLCB3ZSB3b25kZXJlZA0KPiA+IHdo
ZXRoZXINCj4gPiB0aGUgY29tbXVuaXR5IGlzIGludGVyZXN0ZWQgaW4gc2V0dGluZyB1cCBDb3Zl
cml0eVNjYW4gcHJvamVjdHMgZm9yDQo+ID4gb2xkZXIga2VybmVsIHJlbGVhc2VzLiBXb3VsZCBz
dWNoIGFuIGV4dGVuc2lvbiBiZSB1c2VmdWwgdG8gc2hvdw0KPiA+IG5ldw0KPiA+IGRlZmVjdHMg
aW4gYWRkaXRpb24gdG8gdGhlIGN1cnJlbnQgcmVsZWFzZSB0ZXN0aW5nPw0KPiANCj4gVGhlIG9u
bHkgb25lIHdlIChsaWdodGx5KSBtYW5hZ2UgcmlnaHQgbm93IGlzIHRoZSBsaW51eC1uZXh0IHNj
YW5uZXIuDQo+IElmDQo+IG90aGVyIGZvbGtzIHdhbnQgdG8gaG9zdCBzY2FubmVycyBmb3IgLXN0
YWJsZSBrZXJuZWxzLCB0aGF0IHdvdWxkIGJlDQo+IGludGVyZXN0aW5nLCB5ZXMuDQoNCkNhbiB5
b3Ugc2hhcmUgZXhwbGFpbiBvciBzaGFyZSBwb2ludGVycyB0byBob3cgdGhlIGN1cnJlbnQgc2V0
dXAgd29ya3M/DQpJZiBJIHVuZGVyc3RhbmQgdGhhdCBiZXR0ZXIsIHdlIGNhbiB0aGluayBhYm91
dCBob3cgdG8gcHJvY2VzcyB0aGUNCm90aGVyIGtlcm5lbHMuDQoNCkJlc3QsDQpOb3JiZXJ0DQoN
Cj4gDQo+IC1LZWVzDQo+IA0KPiAtLQ0KPiBLZWVzIENvb2sNCg0KCgoKQW1hem9uIFdlYiBTZXJ2
aWNlcyBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJICktyYXVzZW5zdHIuIDM4CjEwMTE3
IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hsYWVnZXIsIEpvbmF0aGFu
IFdlaXNzCkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhS
QiAyNTc3NjQgQgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAzNjUgNTM4IDU5Nwo=

