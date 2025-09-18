Received: from cdmsr1.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6D12E88A2
	for <linux-hardening@vger.kernel.org>; Thu, 18 Sep 2025 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758186144; cv=none; b=rKny1c9uQIVKqMAX65URqeW5E3gEbqVSbpWYgniLrua8nEbzdR6amdG80vvAIlosmaR7tqJXUKxHgQENUx5m6gXw17YMy4ra+hIjl99NEW6gfQMjTJm6AXiiv7ejUKQQ6B9SsNnkq1WnSkHLLY6xLthM110D9VilgTgQoiIwRKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758186144; c=relaxed/simple;
	bh=Xzu8lp7pRB0ASZDv0Sex6fMh1PIpZSXg49qbUYC5EEs=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=mAQLcODVzW3xKc7WnRYmSBuqfw2IYFl9lyKchYqQ9H+2xuFfeobwj0gpVozryorM76ZgTJeux/H2sSxmSxzB2kncfytK4PTRXgD6gLfAZHEOIu2v2g5nUSDpo3E3aS3RfvD9SQpG9Hs0gm7UKyBF7Hl2GadpTIgDDCUdQYkcpQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=RujpGko5; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="RujpGko5"
Received: from cmsr8.hinet.net ([10.199.216.87])
	by cdmsr1.hinet.net (8.15.2/8.15.2) with ESMTPS id 58I92AjG240846
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-hardening@vger.kernel.org>; Thu, 18 Sep 2025 17:02:15 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1758186135; bh=c8wZf5N8aNgl+b7EV1r5B/GUj08=;
	h=From:To:Subject:Date;
	b=RujpGko5pXGTF4tKt2xc3zCibQnUm0rkzX6Cv0tYEpZ42A376sE0RB4VPh2CrqtkK
	 /DDilMDVrcjXB5s5ND1HV7yTEB9Q6OaO3OKcVhqcvqoEIIc/bVICmMLHm/Ha3R4f0K
	 GW3QvSqPL+uGjkqB6c7staAP+ycuUFNUa1t7Dqj0=
Received: from [127.0.0.1] (220-137-5-7.dynamic-ip.hinet.net [220.137.5.7])
	by cmsr8.hinet.net (8.15.2/8.15.2) with ESMTPS id 58I8t9OZ102184
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-hardening@vger.kernel.org>; Thu, 18 Sep 2025 16:59:42 +0800
From: "Info - Albinayah 143" <Linux-hardening@ms29.hinet.net>
To: linux-hardening@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gMzIyMDcgVGh1cnNkYXksIFNlcHRlbWJlciAxOCwgMjAyNSBhdCAxMDo1OTo0MSBBTQ==?=
Message-ID: <449e4ac9-f218-7ed9-8a40-b65aeaa83679@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Thu, 18 Sep 2025 08:59:41 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=LvQxyWdc c=0 sm=1 tr=0 ts=68cbc9ff
	p=OrFXhexWvejrBOeqCD4A:9 a=PiZ31QbdlfLEIbo3Wqyrdw==:117 a=IkcTkHD0fZMA:10
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
