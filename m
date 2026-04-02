Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCFD1850A4
	for <linux-hardening@vger.kernel.org>; Thu,  2 Apr 2026 03:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775099605; cv=none; b=GhPwGAd5JXko7PoIxsYVCG0QKqCylueqWygDXUzTeVT+o7Mk/VavqxA8AKgKJGY1ldAEFbkcieKuApNfD2ThPIjM6jsDSgPa/g2Y6SHgg3Hh2K1gpWE0N1O8KSFcNuAmF0lcmrGWbnT3oaM3epynGNYbMp4EVRZ7vkNmSVaO5aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775099605; c=relaxed/simple;
	bh=qRqErW3371HFJSW9X/ggRuPG1UXb0WJ9Li8I6Mn4B+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nan+LAmT5gcZ7APJy9T/yeghu4RZkpYpu5RCiR+nLxN0Lxfas72DEhVWPNlfr1p8JOBvvD2kMpSCISQMndWfvgpbWIu/zXtQ/rQH15shh3Ui+uKrG8YGWiSA380pOaY/DEXKVo6HDDphrTDeuzLoYibyC+GtbWsAdGQFNo7tqqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=n2Z3F2YO; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="n2Z3F2YO"
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id 856Jwhb5qc9KC88Ugw9L93; Thu, 02 Apr 2026 03:13:18 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 88UfwsKTHOPYd88UgwjRcj; Thu, 02 Apr 2026 03:13:18 +0000
X-Authority-Analysis: v=2.4 cv=QbNmvtbv c=1 sm=1 tr=0 ts=69cddece
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=k5Y5iPg+dmTXVWgYE/XtfQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=7T7KSl7uo7wA:10
 a=1UXpIvhHyTCAxuUnJfYA:9 a=QEXdDO2ut3YA:10 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RbxD/uaBTE/UxOFohHNJ+4K/78k2KwubLxJhAG9BMh0=; b=n2Z3F2YOklIG9l1rwGNsUWn7K2
	MSeX/ux0P2G/4T+1kamEq7dsAX9qZaGSOTQbUzphSOdpciTaP8N3uk0AmEEW0/3nzMIlNUV7DTnqa
	ZGZQCrHVT2Rx1EmkOprzadhVPqcADr3+hCXsHNy3mwP6PZfKWZibYpwznvoIVr6q4306nElpo94+l
	/iRWPkgyb6w9K/uOAL4u6ovAJJoUn85HC0L9EQAdBiuJVEK16Wr4sYCHgaPB41/DuTofZZIdShNEZ
	RIrtTpAfJcK6rsLfvtfPwXkgSMJfc9t0I6U18x3xY9aSMICa8FgQKSaGm/bLQwKynxzf0hhK5Du7T
	G4BJKhZQ==;
Received: from [177.238.16.13] (port=51198 helo=[192.168.0.104])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1w88UZ-000000003t7-2IzI;
	Wed, 01 Apr 2026 22:13:12 -0500
Message-ID: <f6945a16-d726-4666-9bc8-1067a7422a81@embeddedor.com>
Date: Wed, 1 Apr 2026 21:11:52 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] clk: samsung: use kzalloc_flex
To: Rosen Penev <rosenp@gmail.com>, linux-clk@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "open list:SAMSUNG SOC CLOCK DRIVERS" <linux-samsung-soc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260402030432.101066-1-rosenp@gmail.com>
 <20260402030432.101066-2-rosenp@gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260402030432.101066-2-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.16.13
X-Source-L: No
X-Exim-ID: 1w88UZ-000000003t7-2IzI
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.104]) [177.238.16.13]:51198
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfF/KXI6njA97ODeN//fWunpNPuWcSyJXZ7HQlnOKGVr+k4LYxD+eYA+R5FpYW9lphClIiBE+BJfpHvTdVoEQiVAvBBbARfMOm+2rwKwmxDJtCC4GXGLu
 /xsLaA29b9j4jolKT0tEdpjV9Trp5nshUMgzSmTSB3y2kXFn80ys7FH2Gl/J6WC4K+ekXUcBFsF5wR/mrPzbjCMG8dxjuNQ8fGsQa6PXXuia5/Fh8FHQH/d5



On 4/1/26 21:04, Rosen Penev wrote:
> Simplify allocation by using kzalloc_flex with a flexible array member
> to combine allocations.
> 
> Add __counted_by for extra runtime analysis. Move the counting variable

> assignment right after allocation as required ny __counted_by.

As commented in another thread, this is not true.

(The same applies to changelog text in patch 3/3)

-Gustavo
