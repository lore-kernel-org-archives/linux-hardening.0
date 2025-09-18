Received: from cdmsr2.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9411C5227
	for <linux-hardening@vger.kernel.org>; Thu, 18 Sep 2025 02:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758163221; cv=none; b=lHwNIUcw/rcYhNEIGqTrRzOE/0f7h5ONhnQN0fckpCpacsHay+WK35DojJgYf+SUSq4lc+9Qp4YJmYfNdrciIZX+WYDcmbw657aX7qddhxKT17DhunK12Oa53AIXj6Qyw0AOKXnPONFkN4NQRYY1SpWzXCO9HtdM71boPTlaVUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758163221; c=relaxed/simple;
	bh=Xzu8lp7pRB0ASZDv0Sex6fMh1PIpZSXg49qbUYC5EEs=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=TAP6dgNLaYldZTX9jzGDhjK/0pDzbOAHtSewiB3ouQUDAC6Ubwv/LF/Yx8y6TExlOtedNIyoJlSTg7VQ7ETDiotvpaxsC44PrQZRMZBf4O8J+lLXXltpjUrPdja3z4q2I7iUrM/40fqdQ7hvYgWCY+RJFZLcc4YCQRQwDnuw588=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=sIKcqsRl; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="sIKcqsRl"
Received: from cmsr3.hinet.net ([10.199.216.82])
	by cdmsr2.hinet.net (8.15.2/8.15.2) with ESMTPS id 58I2eEpu453978
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-hardening@vger.kernel.org>; Thu, 18 Sep 2025 10:40:17 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1758163217; bh=c8wZf5N8aNgl+b7EV1r5B/GUj08=;
	h=From:To:Subject:Date;
	b=sIKcqsRlgZJE/bLVxWf7xwKBebl/VPKloxahA90FiR7KiSiG1MHjFOykpwpo7q0T4
	 LKssScawAMofxSx1HUNUatfkEI9dChSXTj2jU00gHpHZ/N0TxFj01hIth41yYUBuGN
	 +XfNLMCXCCBazls7664Pj+5mnw+Sk157BNndP7Z0=
Received: from [127.0.0.1] (218-173-148-207.dynamic-ip.hinet.net [218.173.148.207])
	by cmsr3.hinet.net (8.15.2/8.15.2) with ESMTPS id 58I2a0e8908253
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-hardening@vger.kernel.org>; Thu, 18 Sep 2025 10:37:43 +0800
From: "Info - Albinayah 182" <Linux-hardening@ms29.hinet.net>
To: linux-hardening@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gOTEyODkgVGh1cnNkYXksIFNlcHRlbWJlciAxOCwgMjAyNSBhdCAwNDozNzo0MiBBTQ==?=
Message-ID: <ca236100-c7bc-81d5-48dd-52c4824c97d8@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Thu, 18 Sep 2025 02:37:42 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=LvQxyWdc c=0 sm=1 tr=0 ts=68cb7078
	p=OrFXhexWvejrBOeqCD4A:9 a=LVU1Z0yGL6lFQ+lv2md78w==:117 a=IkcTkHD0fZMA:10
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
