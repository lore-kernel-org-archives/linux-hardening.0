Received: from cmsr-t-7.hinet.net (cmsr-t-7.hinet.net [203.69.209.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD2817C21E
	for <linux-hardening@vger.kernel.org>; Thu, 16 Oct 2025 03:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.69.209.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760587031; cv=none; b=FaU9Eg7UizmltngnH6LbmbNiUer+qfNicNedgIF/YivuvyNZwD+dZqMo//VBs/MvqrbGIB+AtgXyFqeQgTHVobiDHe19nnWdhMKsA6VTGkmV8/sJl2ntCqXpVtCbr37LEg6wiCa4hAIXvw1RtwmIQZr8TXuoDNkVy9pFbJq1RrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760587031; c=relaxed/simple;
	bh=YWGstjDb9pX9GKSFo917eRziK+/M1C939Wvf2DwbZfk=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=QDkhr1Qc37FhTNxBT6GhC559JZKUd732C6c1G6SHTuXFtcryVa+Oj4DE2E7SYswj0aRwQZWci0QTS5PtB5D8GSJiL3sJ73tP6dP5+z0b/7ZAJgwT/R/gZYLvrZ0moEBxVq9khkx78nDj4f6khHFzaoZCY2+Sg3nR4r2Y0D5TesE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (2048-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=rPGSadgq; arc=none smtp.client-ip=203.69.209.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="rPGSadgq"
Received: from cmsr9.hinet.net ([10.199.216.88])
	by cmsr-t-7.hinet.net (8.15.2/8.15.2) with ESMTPS id 59G3PDtL875318
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-hardening@vger.kernel.org>; Thu, 16 Oct 2025 11:25:14 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ms29.hinet.net;
	s=s2; t=1760585114; bh=YWGstjDb9pX9GKSFo917eRziK+/M1C939Wvf2DwbZfk=;
	h=From:To:Subject:Date;
	b=rPGSadgqz+pFzzhf6nCIXTf65Mp4kNQbZlcgDVi/Reof/qGXJTLmhTQv5T/xmey84
	 697XdXa7ze96p8UH8W41WKtnuwicJGPUgFhwvGprEkUDn4YallAQgDB3yTYqFC5S75
	 aFYBVv76JR9hAOZynZxJA5IrEvk9dTtcA4/KA33bod84aivpTvtR/5baYzAcwgog57
	 XWdKykGRTlii+9EAUhSdvNp2RLBXBdlxxLeej8Mn2R44KcKDAPXiNnHyrPgvk6uVd1
	 glzSvw3Pl4fEGZwRrZUZfzK/KzAssG8FCjZ7aZ+ifxShVFu5VJxDa80X3+uBOj/bzF
	 zsYab+3hJl7NQ==
Received: from [127.0.0.1] (118-171-139-84.dynamic-ip.hinet.net [118.171.139.84])
	by cmsr9.hinet.net (8.15.2/8.15.2) with ESMTPS id 59G3MbUa193244
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-hardening@vger.kernel.org>; Thu, 16 Oct 2025 11:25:12 +0800
From: "Purchase - PathnSitu 304" <Linux-hardening@ms29.hinet.net>
To: linux-hardening@vger.kernel.org
Reply-To: "Purchase - PathnSitu." <purchase@pathnsithu.com>
Subject: =?UTF-8?B?TmV3IE9jdG9iZXIgT3JkZXIuIDAwODkxIFRodXJzZGF5LCBPY3RvYmVyIDE2LCAyMDI1IGF0IDA1OjI1OjExIEFN?=
Message-ID: <bc1e917a-eef4-26f9-d9b9-80386c687124@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Thu, 16 Oct 2025 03:25:12 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=fop/Z04f c=1 sm=1 tr=0 ts=68f06599
	a=BuUpIdtoTYq2ASSGTr9POA==:117 a=IkcTkHD0fZMA:10 a=5KLPUuaC_9wA:10
	a=sTUcEMTjFW7efRGAshQA:9 a=QEXdDO2ut3YA:10

Hi Linux-hardening,

Please provide a quote for your products:

Include:
1.Pricing (per unit)
2.Delivery cost & timeline
3.Quote expiry date

Deadline: October

Thanks!

Danny Peddinti

PathnSitu Trading
