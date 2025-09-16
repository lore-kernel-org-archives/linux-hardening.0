Received: from cdmsr2.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069031F0995
	for <linux-hardening@vger.kernel.org>; Tue, 16 Sep 2025 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758016527; cv=none; b=KpX4a0zWjxxv2W9xeq4wn/vtq7zEP87N1A1OrrfBrZmkyRXSslqebmBNI4lFMxTpAdNiMF4KuJjKCYFGuIAZbIq0lBXa4zfT6fh+GPbM9fZaV3mGSlIZtOhaNtuUKxXHon3rSQ3zQngwGkqVrKBfSj2mE0IxOxK0YjIB8E6sGAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758016527; c=relaxed/simple;
	bh=Xzu8lp7pRB0ASZDv0Sex6fMh1PIpZSXg49qbUYC5EEs=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=AiItw+F3Z8HHdonn5pzMnyhQdDoB3cByAdbN2NSs35i1l+4xNWKha1uB/KB+kiRSF5HmgbAtyVwfDT++vL/4yp51M7DDYYMFy3DEuZQcxFtyqa6trUaoL4GskNP6L4NqFEDNIAeVVZvS2t9Fj/TWPdpzUJkQhBjWDXGENBhUGGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=XjJ8sHQ2; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="XjJ8sHQ2"
Received: from cmsr4.hinet.net ([10.199.216.83])
	by cdmsr2.hinet.net (8.15.2/8.15.2) with ESMTPS id 58G9tJup037639
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-hardening@vger.kernel.org>; Tue, 16 Sep 2025 17:55:23 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1758016524; bh=c8wZf5N8aNgl+b7EV1r5B/GUj08=;
	h=From:To:Subject:Date;
	b=XjJ8sHQ2dEFXQdEQRcdcDd3IzPH99U6KhzdWTP9UCYS58MgC+lBM6PNs1vtZ0y1PU
	 4Z8aI9V0mmcZAwtkidsUDe5MpWgyNvajZUyxyfV7bQCMvPNENUsdWfXdSi/+VYDWtJ
	 gW048GquGZni+9sdezEKR/aFhyczfEAde9PkLCtQ=
Received: from [127.0.0.1] (36-227-253-69.dynamic-ip.hinet.net [36.227.253.69])
	by cmsr4.hinet.net (8.15.2/8.15.2) with ESMTPS id 58G9m6aB773709
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-hardening@vger.kernel.org>; Tue, 16 Sep 2025 17:53:03 +0800
From: "Info - Albinayah 800" <Linux-hardening@ms29.hinet.net>
To: linux-hardening@vger.kernel.org
Reply-To: "Info - Albinayah." <sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gNDI4NjUgVHVlc2RheSwgU2VwdGVtYmVyIDE2LCAyMDI1IGF0IDExOjUzOjAyIEFN?=
Message-ID: <183415c0-2842-bb11-84ec-e6f4bad15be2@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Tue, 16 Sep 2025 09:53:02 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=V93e0vni c=0 sm=1 tr=0 ts=68c93380
	p=OrFXhexWvejrBOeqCD4A:9 a=1RDRvy0+3nsRku5Mf+R5Ew==:117 a=IkcTkHD0fZMA:10
	a=5KLPUuaC_9wA:10

Hi Linux-hardening,

Please provide a quote for your products:

Include:
1.Pricing (per unit)
2.Delivery cost & timeline
3.Quote expiry date

Deadline: September

Thanks!

Kamal Prasad

Albinayah Trading
