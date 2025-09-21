Received: from cdmsr2.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F961B85FD
	for <linux-hardening@vger.kernel.org>; Sun, 21 Sep 2025 04:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758429112; cv=none; b=bZyS0X8qh5yCWvEInLYtCUcun1XmotJ7k8AhX/3rVkI3j6c7hQG+wyl1WBmjhVLjy/AbNvJ2Xsge2ZouY+xEQHwx0bRClWHUuXbe1UO/O4gcMkCoV/bkbjs8jY50nL2XlYkY9pjDd1f7mVsAcLZbxvG3PQwjf2NzDsXJe6ftA9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758429112; c=relaxed/simple;
	bh=Xzu8lp7pRB0ASZDv0Sex6fMh1PIpZSXg49qbUYC5EEs=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=ix2jVIXeAHMvjucQs+MjJu3Q+fKZ6D7Vi9TZuG9t+0WgiEmfjEw7xCSV690bxQfunGsc7SYjlWLcBuXBHO77y4RdeQCwUcBRC8hICpiPMRRwZbk7BuzWlfpG9Ym0eSOMC80iqs8oVt8UOM+bBmTTvfCRz63GifvZJmQSPMlkfZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=MBbgLhbH; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="MBbgLhbH"
Received: from cmsr5.hinet.net ([10.199.216.84])
	by cdmsr2.hinet.net (8.15.2/8.15.2) with ESMTPS id 58L4VkGC196540
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-hardening@vger.kernel.org>; Sun, 21 Sep 2025 12:31:48 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1758429108; bh=c8wZf5N8aNgl+b7EV1r5B/GUj08=;
	h=From:To:Subject:Date;
	b=MBbgLhbHmGKWC+In7xfDir+JtyPaNaJ5KggOimdyOhm2PZwaXRqF68lIYbj51ZWlh
	 zo0OxsT/MVp5p5CK3dEVcYmv3Stnwb4xB1ylKjjlZBt/GE02NOrGDgFdaG0p4IOqsZ
	 V7g8q/zxPWyPHE2UBBv1sdHQPBffs/G4iI+VJkg8=
Received: from [127.0.0.1] (36-239-124-102.dynamic-ip.hinet.net [36.239.124.102])
	by cmsr5.hinet.net (8.15.2/8.15.2) with ESMTPS id 58L4Nd29703088
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-hardening@vger.kernel.org>; Sun, 21 Sep 2025 12:25:32 +0800
From: "Info - Albinayah 554" <Linux-hardening@ms29.hinet.net>
To: linux-hardening@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gNzc3NzMgU3VuZGF5LCBTZXB0ZW1iZXIgMjEsIDIwMjUgYXQgMDY6MjU6MzEgQU0=?=
Message-ID: <79ca7595-35e7-3e7e-674b-7853f97ddbf3@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Sun, 21 Sep 2025 04:25:31 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=X8PxK3Te c=0 sm=1 tr=0 ts=68cf7e3d
	p=OrFXhexWvejrBOeqCD4A:9 a=uOCXUd7ZQqfqfYBohqtHNA==:117 a=IkcTkHD0fZMA:10
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
