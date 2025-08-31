Received: from cmsr-t-4.hinet.net (cmsr-t-4.hinet.net [203.69.209.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF8B213E9F
	for <linux-hardening@vger.kernel.org>; Sun, 31 Aug 2025 19:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.69.209.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756667451; cv=none; b=sbpog+uZvFjTUPJZoYrl7O/f0X9EP65q70zUy79iE/BYw/jDUkdA6f5bcL2DE/CnpmctefJMbUmHqOBrxFUtugfk2kIvUqUQ8Dj5aAGFP/LfCqSH+aE+1LFZCxL0VIYYrpYN/VJNtH/q9hDchw3TjkV5jLDFjcafNKd10dWyer0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756667451; c=relaxed/simple;
	bh=Xzu8lp7pRB0ASZDv0Sex6fMh1PIpZSXg49qbUYC5EEs=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=g3h6uUVNXAPvkwmw9nPOCK5jt5RZELemHRWjHz6q6KG5vwZmni/df7u75NEbXQGZkU2KsQpcvYcJGd6Q9z4VF1C4/OCAr6V/1BVJlhJD4DPvT+4QUCTvA+3jHSCQXRIXDLy7o6d0DKRcnFN5JGjVoeDHaJEdY5RelJ9jbVBVlRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (2048-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=sG5hIHDU; arc=none smtp.client-ip=203.69.209.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="sG5hIHDU"
Received: from cmsr4.hinet.net ([10.199.216.83])
	by cmsr-t-4.hinet.net (8.15.2/8.15.2) with ESMTPS id 57VJAkma949781
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-hardening@vger.kernel.org>; Mon, 1 Sep 2025 03:10:46 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ms29.hinet.net;
	s=s2; t=1756667446; bh=Xzu8lp7pRB0ASZDv0Sex6fMh1PIpZSXg49qbUYC5EEs=;
	h=From:To:Subject:Date;
	b=sG5hIHDUlYviHAO1kTvPFG2WUdnhreNX5P0V+qnYJS5AdhtLVggbJ6wAxBYnxlInF
	 RPIOm65G0VC7E3kwr/XUAbmFHP+IKXC1fVF9QNF+y/R9xmLgI58sFmqC4eDaJDf8Sc
	 FdHtwhswyMXB+r9j9kL/J0Nhn33qUeYtm3dzp5Qza7uFLONUJTfV6aRRl7Kqi+SIUV
	 ceBk7yqTxR9zN7B8QNLrPgvVBd9X/xl2QufAqMbivKO0mgFg2wGLAg8zHkeaPvUvez
	 r+G7x24SiQ3/I58Vw46jxtZvRQB1YfhMuqwJ2FzuBeDGIeDqp5kJ/PzyNhVkGFFnaj
	 A/mpbElVzVq2A==
Received: from [127.0.0.1] (59-127-225-117.hinet-ip.hinet.net [59.127.225.117])
	by cmsr4.hinet.net (8.15.2/8.15.2) with ESMTPS id 57VJ9Sxa098839
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-hardening@vger.kernel.org>; Mon, 1 Sep 2025 03:10:45 +0800
From: "Info - Albinayah 912" <Linux-hardening@ms29.hinet.net>
To: linux-hardening@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gNjI5MzkgU3VuZGF5LCBBdWd1c3QgMzEsIDIwMjUgYXQgMDk6MTA6NDQgUE0=?=
Message-ID: <edb08b86-49c9-64bf-bf8a-4bcd04642f50@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Sun, 31 Aug 2025 19:10:45 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=S5B6w5sP c=1 sm=1 tr=0 ts=68b49e36
	a=/fJzjUvRWwSR4C+B5igd9A==:117 a=IkcTkHD0fZMA:10 a=5KLPUuaC_9wA:10
	a=OrFXhexWvejrBOeqCD4A:9 a=QEXdDO2ut3YA:10

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
