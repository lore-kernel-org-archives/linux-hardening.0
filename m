Received: from cdmsr2.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9587D2BAF9
	for <linux-hardening@vger.kernel.org>; Sat,  6 Sep 2025 00:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757119011; cv=none; b=c9tgWKelGqihNGeQNlJf86XOttZRI42jj3ymvzH7AvPsq3lgg4RZQwSg1EVUi3G9y6TjuRVQLEchOh5TVQOBEapeSxZSrtVLuC2wVSp1Iqby0SEpVlLrjpOXfdMkduNbpNWK4fY4PcolqSrTf/YElEkoxv/opCOhzO6deo9cgUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757119011; c=relaxed/simple;
	bh=Xzu8lp7pRB0ASZDv0Sex6fMh1PIpZSXg49qbUYC5EEs=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=jAF28Yz4lg0AC1lBakyrPIp5PRJ4gpdn4Tyq3P/B2xB67J55YlvLT6fsUBBV49oZWFZW2RqDy65VZLjpOYppJDV2Pt1yFJ0QLKqVySmGwlttb0GO+AYRG0In7xybCLEDjL8klVn7v11s/eUvpD4LhiynBA3A4lX/MP/nogeMM7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=ufP+o5CV; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="ufP+o5CV"
Received: from cmsr5.hinet.net ([10.199.216.84])
	by cdmsr2.hinet.net (8.15.2/8.15.2) with ESMTPS id 5860ah6L916779
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-hardening@vger.kernel.org>; Sat, 6 Sep 2025 08:36:45 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1757119005; bh=c8wZf5N8aNgl+b7EV1r5B/GUj08=;
	h=From:To:Subject:Date;
	b=ufP+o5CV/y3CeDGyYZ4i5oJDPYw+z+w9rJTXFkD8mmL2heNg+xX3n8GSU7ua5+1Ag
	 WyYumw2mYkcZoOsa7vBD61whdsl1LFZyWhZn2WJ7CB/FOKuYEBacUhegGjKUbG203A
	 PIYSsxaOHP6J0yR/45FdnNW9+sBKGtzGcCmuKuFM=
Received: from [127.0.0.1] (114-25-33-253.dynamic-ip.hinet.net [114.25.33.253])
	by cmsr5.hinet.net (8.15.2/8.15.2) with ESMTPS id 5860SUgn652660
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-hardening@vger.kernel.org>; Sat, 6 Sep 2025 08:33:00 +0800
From: "Info - Albinayah 344" <Linux-hardening@ms29.hinet.net>
To: linux-hardening@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gOTE3NzkgU2F0dXJkYXksIFNlcHRlbWJlciA2LCAyMDI1IGF0IDAyOjMyOjU5IEFN?=
Message-ID: <3f7ebb15-e47f-49ef-e4d8-0931b587e2d0@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Sat, 06 Sep 2025 00:33:00 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=Xbkqz555 c=0 sm=1 tr=0 ts=68bb813d
	p=OrFXhexWvejrBOeqCD4A:9 a=wvrbLfhihkah3F5dJbOSqg==:117 a=IkcTkHD0fZMA:10
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
