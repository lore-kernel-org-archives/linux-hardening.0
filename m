Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF3A3D69
	for <linux-hardening@vger.kernel.org>; Wed, 27 Mar 2024 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566590; cv=none; b=czMIhu4rtWdKyi/AQ1dTaBKn/Tp33YOj2dH8QQJ6hYZl5p/HbsLQDL1B0fF9GlvYn7TIex76V1c9vuFISqO+gwZdWuv6gptG2rGEX+lhfPdeF87hq/Rjj6HJ2d8uh24Woe45yuJLW9YXf4x6YmLD3T+KxnampYC/XDH9tpJCTHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566590; c=relaxed/simple;
	bh=VuFdCUTeCOnad4gk6omCYrg21NlNNqeSLBu5rRtqVXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPXYKJwGSFp69tQSmByU6Sd91BHRsQ+DvI6FEvrokEYawuYE4jsjEQmM2zVQwH6MR7RqnJeNmtL8T4vynHI2WZ999m3A7noQc6beaWnftupmnRlVBTDRDkAyNSXWLGDw6P9GMXarZG+KPQiCBMpvScEMj52Y2s6SltArB97TfCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=qGdsfb5n; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="qGdsfb5n"
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id pWKlrzz5oQr4SpYehriipO; Wed, 27 Mar 2024 19:09:47 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id pYegrIQcjd4oepYehrMhA9; Wed, 27 Mar 2024 19:09:47 +0000
X-Authority-Analysis: v=2.4 cv=aYKqngot c=1 sm=1 tr=0 ts=66046efb
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=zXgy4KOrraTBHT4+ULisNA==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10
 a=jgUHHrBZrz3db-_ODY8A:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=agm2AiH62BDQPh9qtko/Ix12J6Yxy9RCLO/4NODZzQU=; b=qGdsfb5n3srrLy6Jbt0CD1F9Ay
	CnkPWga/hrZcYJpakf7dMoa5k7jGT+aNsEAUb9q8H8wv2wRB8l+jOC/zR3JZdFkYcX5gf5buskJII
	fwRfy6b9HE5BEiN9J9FneDQ3xFEvzPSByG2S2NTmZ30Fy3w7zX7gp2GdcAeS6tKGEUFdtniyvh9zr
	n2nFX1hsQ5fk+hxRnY03QzzhlcSYShxZsjpLDMw3axJVvdEXbnBzDC8dJMG48ltyuS3pEdVOyTbBw
	fcl38+ziLh8h9ZnAxMBBLsYyc2fNQPjOrr40I1N4cZ3TRv9XzfI7rrJQzDPF5+PF7feKalGZHSFGF
	itV6vdGg==;
Received: from [201.172.173.147] (port=55016 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rpYeg-003lvN-10;
	Wed, 27 Mar 2024 14:09:46 -0500
Message-ID: <62d3dd2c-ef46-4931-a9d6-8455b7b60870@embeddedor.com>
Date: Wed, 27 Mar 2024 13:09:44 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: cfg80211: Use __counted_by() in struct
 wmi_start_scan_cmd and avoid -Wfamnae warning
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZgRqjGShTl3y5FFB@neat> <87edbv7b9z.fsf@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <87edbv7b9z.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.147
X-Source-L: No
X-Exim-ID: 1rpYeg-003lvN-10
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.147]:55016
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCQPcqDsWwwHUtb0XzYf74ueb/1avCYfG9CN5Ntn9Hh8M28ZFzuiPo3OltdHz1b3CZqI8VEQzhrCzB2Wp70+GY6qweAFX+pUANhBGjUab+r/TXAsw0ee
 KYFb/uotQubM6Ay2dbba2fb649trc4a9MbotaEdYuZDWDb+6ByKObDjp3l7kBcV4j/PG785HHjvFTOqSNWTrMWWgTYNBsxQ8ZTM4DHtnon84DzKVg4TyltjX


> The subject should being with "wifi: wil6210:", I can fix that. (Didn't
> review the rest yet.)
> 

It seems I got it right in a subsequent patch. :)

Thanks, Kalle.
--
Gustavo
