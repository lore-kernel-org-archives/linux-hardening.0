Received: from cdmsr1.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7CF277CA8
	for <linux-hardening@vger.kernel.org>; Wed,  1 Oct 2025 10:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759314417; cv=none; b=p4NxICYUfftXUyGB+58WATTy7XTri1JnVcliK0kGlZ7rRoVmeCPLs/f5smyY5kQYUbzzCf+MT56X492KPG9Y86N4AT/DcYE1KZdXyBkJKbKYtVFAgutzXlfnUhgAgUEbpmCWzGBhUHIzyYn5O80dFIUxz4R9vMt4gLtWIjZr3jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759314417; c=relaxed/simple;
	bh=Xzu8lp7pRB0ASZDv0Sex6fMh1PIpZSXg49qbUYC5EEs=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=LpOKOvOWXbep/3PlVOGHXzC4ZX2E5Yt1CAcuauVm9TkA4zcYFepRMBla+qVOeeWYQfiEfYmkeE4PLuqBG3la4e7kzSQ7HfZmN2C5Okz2daH+gpRq0rmWYMnfJaLHlcVf3d/pSPwKSQFk73X+Mm1kLb/LX7ZzAAdsD9K+m+Ayzv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=TTN7v8l5; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="TTN7v8l5"
Received: from cmsr10.hinet.net ([10.199.216.89])
	by cdmsr1.hinet.net (8.15.2/8.15.2) with ESMTPS id 591AQpvi188354
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-hardening@vger.kernel.org>; Wed, 1 Oct 2025 18:26:54 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1759314414; bh=c8wZf5N8aNgl+b7EV1r5B/GUj08=;
	h=From:To:Subject:Date;
	b=TTN7v8l56T5EZqk1D20E2b8+nFhv7cT1R6QcUNVW9hErtyFo6nQGv+cuATfF0NjG1
	 nxVzkA7km1LuK7Wx3VNQqp0YF7a5dDVMvxoxJfaX9eZ//q+o/ap3VAhwLYNg7UX0yT
	 FzGzQHHs+iYa5Eg+lPnp5PTzNZL+7XZ8eBHStG+A=
Received: from [127.0.0.1] (36-229-7-214.dynamic-ip.hinet.net [36.229.7.214])
	by cmsr10.hinet.net (8.15.2/8.15.2) with ESMTPS id 591AKhCS054940
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-hardening@vger.kernel.org>; Wed, 1 Oct 2025 18:23:57 +0800
From: "Info - Albinayah 169" <Linux-hardening@ms29.hinet.net>
To: linux-hardening@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gMTk5NTUgV2VkbmVzZGF5LCBPY3RvYmVyIDEsIDIwMjUgYXQgMTI6MjM6NTYgUE0=?=
Message-ID: <a3a318f1-5246-9f92-bba5-0c541b67c36f@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Wed, 01 Oct 2025 10:23:56 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=D8LkKeRj c=0 sm=1 tr=0 ts=68dd013e
	p=OrFXhexWvejrBOeqCD4A:9 a=sjFXbHcYSmOHd23kdvQ5Jw==:117 a=IkcTkHD0fZMA:10
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
