Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BC614B97D;
	Thu, 16 May 2024 15:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715873307; cv=none; b=r1Hsw9HDj05KzWl1HBoEZlx/ziXkXJE8WbacGNoxHHNFCOZWcZAda8CcOYJC9Re+/tXkA0HjycQxGbOsI5gtfkxBeNKRfT5gLgY9E2ZpdmAv5VeQ6GUzbjzD2VN3PbWrvwVgpmwL24Cd7Fh1kqBRV+mLluHFlMF9LFTLG8LSKOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715873307; c=relaxed/simple;
	bh=5U0KMV2C/c892y1VrfZ5naiyiiT+W1EsNrkhQahBFWU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Gvy4mkR2fA1EGYNvCKDDDppj7ir38jW2rkepoazVJGcvc4EXi+vgCH+jhsuElAvslTL99l0hQIMsacYyWhHBII+uObCHVVYQclbvTy+ac9476BRc+gjbQ2uuP8Y0u/ezbkXmq3/mutpDM++3wLAhkAareFU45XzD1hS1BuHGlF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=iUDlKF7z; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="iUDlKF7z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1715873305; x=1747409305;
  h=from:to:cc:subject:date:message-id:content-id:
   mime-version:content-transfer-encoding;
  bh=5U0KMV2C/c892y1VrfZ5naiyiiT+W1EsNrkhQahBFWU=;
  b=iUDlKF7z/VhC7Yp47Y+ref1W1q6CSn69JaV3Izn393Wm1drdsQ+aG5XY
   zuzswcKNC7+XrIP/vfwuXge7+OK+VDUGemZvp+puKmS+rnE9WlhtSSJMI
   9TMJJbe3s/nPkcLPmLrRLWr91cnUHJ/8OcfwoR5vaUQWnfab4eVDPVVTZ
   o=;
X-IronPort-AV: E=Sophos;i="6.08,164,1712620800"; 
   d="scan'208";a="344862544"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 15:28:18 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:59697]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.39.135:2525] with esmtp (Farcaster)
 id ad0209d0-e9fb-4e92-a94b-04e2f86d58c5; Thu, 16 May 2024 15:28:16 +0000 (UTC)
X-Farcaster-Flow-ID: ad0209d0-e9fb-4e92-a94b-04e2f86d58c5
Received: from EX19D043EUB003.ant.amazon.com (10.252.61.69) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 16 May 2024 15:28:16 +0000
Received: from EX19D002EUC004.ant.amazon.com (10.252.51.230) by
 EX19D043EUB003.ant.amazon.com (10.252.61.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 16 May 2024 15:28:16 +0000
Received: from EX19D002EUC004.ant.amazon.com ([fe80::fa57:3c1:c670:f520]) by
 EX19D002EUC004.ant.amazon.com ([fe80::fa57:3c1:c670:f520%3]) with mapi id
 15.02.1258.028; Thu, 16 May 2024 15:28:16 +0000
From: "Manthey, Norbert" <nmanthey@amazon.de>
To: "keescook@chromium.org" <keescook@chromium.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Woodhouse, David" <dwmw@amazon.co.uk>, "Stieger, Andreas"
	<astieger@amazon.de>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, "Hemdan, Hagar Gamal Halim"
	<hagarhem@amazon.de>
Subject: Extending Linux' Coverity model and also cover aarch64
Thread-Topic: Extending Linux' Coverity model and also cover aarch64
Thread-Index: AQHap6Wsmrdu7IK9QEOStpjMecz3Dg==
Date: Thu, 16 May 2024 15:28:16 +0000
Message-ID: <77f6e6fc46232db82a3c63e93877c9534334e407.camel@amazon.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B7489B3CBD9B741AD1B080B393DE304@amazon.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64

RGVhciBLZWVzLCBhbGwsDQoNCndlIHB1Ymxpc2hlZCBhbiBleHRlbnNpb24gZm9yIHRoZSBDb3Zl
cml0eSBtb2RlbCB0aGF0IGlzIHVzZWQgYnkgdGhlDQpDb3Zlcml0eVNjYW4gc2V0dXAgZm9yIHRo
ZSBMaW51eCBrZXJuZWwgWzFdLiBXZSBoYXZlIGJlZW4gdXNpbmcgdGhpcw0KZXh0ZW5zaW9uIHRv
IGFuYWx5emUgdGhlIDYuMSBrZXJuZWwgYnJhbmNoLCBhbmQgcmVwb3J0ZWQgc29tZSBmaXhlcyB0
bw0KdGhlIHVwc3RyZWFtIGNvZGUgYmFzZSB0aGF0IGFyZSBiYXNlZCBvbiB0aGlzIG1vZGVsIFsy
XS4gRmVlbCBmcmVlIHRvDQptZXJnZSB0aGUgcHVsbCByZXF1ZXN0LCBhbmQgdXBkYXRlIHRoZSBt
b2RlbCBpbiB0aGUgQ292ZXJpdHlTY2FuIHNldHVwLg0KV2UgZG8gbm90IGhhdmUgYWNjZXNzIHRv
IHRoYXQgcHJvamVjdCB0byBwZXJmb3JtIHRoZXNlIHVwZGF0ZXMNCm91cnNlbHZlcy4NCg0KVG8g
aW5jcmVhc2UgdGhlIGFuYWx5c2lzIGNvdmVyYWdlIHRvIGFhcmNoNjQsIHdlIGFuYWx5emVkIGEg
eDg2IGFuZCBhDQphYXJjaDY0IGNvbmZpZ3VyYXRpb24uIFRoZSBpbmNyZWFzZWQgY292ZXJhZ2Ug
aXMgYWNoaWV2ZWQgYnkgdXNpbmcgcmUtDQpjb25maWd1cmF0aW9uIGFuZCBjcm9zcy1jb21waWxh
dGlvbiBkdXJpbmcgdGhlIGFuYWx5c2lzIGJ1aWxkLiBJZiB5b3UNCmFyZSBpbnRlcmVzdGVkIGlu
IHRoaXMgc2V0dXAgd2UgY2FuIHNoYXJlIHRoZSBEb2NrZXJmaWxlIGFuZCBzY3JpcHQgd2UNCnVz
ZWQgZm9yIHRoaXMgcHJvY2Vzcy4NCg0KVG8gcHJldmVudCByZWdyZXNzaW9ucyBpbiBiYWNrcG9y
dHMgdG8gTFRTIGtlcm5lbHMsIHdlIHdvbmRlcmVkIHdoZXRoZXINCnRoZSBjb21tdW5pdHkgaXMg
aW50ZXJlc3RlZCBpbiBzZXR0aW5nIHVwIENvdmVyaXR5U2NhbiBwcm9qZWN0cyBmb3INCm9sZGVy
IGtlcm5lbCByZWxlYXNlcy4gV291bGQgc3VjaCBhbiBleHRlbnNpb24gYmUgdXNlZnVsIHRvIHNo
b3cgbmV3DQpkZWZlY3RzIGluIGFkZGl0aW9uIHRvIHRoZSBjdXJyZW50IHJlbGVhc2UgdGVzdGlu
Zz8NCg0KQmVzdCwNCk5vcmJlcnQNCg0KWzFdIGdpdGh1YiBDb3Zlcml0eSBtb2RlbCBwdWxsIHJl
cXVlc3QgbGluazoNCmh0dHBzOi8vZ2l0aHViLmNvbS9rZWVzL2NvdmVyaXR5LWxpbnV4L3B1bGwv
MQ0KWzJdIEVtYWlscyBmb3IgbW9zdCBmaXhlcyBieSBIYWdhcjoNCmh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC8/cT1mJTNBaGFnYXJoZW0NCg0KCgoKQW1hem9uIFdlYiBTZXJ2aWNlcyBEZXZl
bG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJICktyYXVzZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpH
ZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hsYWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVp
bmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAyNTc3NjQg
QgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAzNjUgNTM4IDU5Nwo=

