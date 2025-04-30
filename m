Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7013A14AD2D
	for <linux-hardening@vger.kernel.org>; Wed, 30 Apr 2025 19:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746042444; cv=none; b=kq3tR0eb3MMXP06ZSHWNLP706Qv64O6gEA60w+hs9wDhix+ou7R3Bu/sl8DcK+DHQrUCi5X86jW6CezyCdI2V/ozDHbDaleZTuuHA9iF7M7fEaZgfYr33lPzgdEaeI8EAPKca6A7mF/K96A7rx14ZND5vWjekfoe1w0zF/WzljI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746042444; c=relaxed/simple;
	bh=rZMBHrZhnFOIs/GKEWTOf+qqgNTCxbQ6a+81ctNfUNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gdMZGnYW/Bb6LxAb8fEMaw14tR81IAuXjf6c9khIoVhDG5nQSGnRuHUhvM743HQPQzL1XVVCcCIfeWvd8/Eij4Wg6Y/6y3r7OzyQVcUYdRAaCyXQKofsouIf5hio/C2uLIal2W+pDpikI7uUsX0WMbuVJVCYewDZ4LiTPlJjjo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=dmeWlgMz; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="dmeWlgMz"
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id 9zYCun7vQWuHKADOmuaveG; Wed, 30 Apr 2025 19:47:16 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id ADOlulgEgjrgqADOmuwBP3; Wed, 30 Apr 2025 19:47:16 +0000
X-Authority-Analysis: v=2.4 cv=PK7E+uqC c=1 sm=1 tr=0 ts=68127e44
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=efVMuJ2jJG67FGuSm7J3ww==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=7T7KSl7uo7wA:10
 a=nXsU5qcrRgWmc-VP2AYA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rZMBHrZhnFOIs/GKEWTOf+qqgNTCxbQ6a+81ctNfUNU=; b=dmeWlgMz6G6zXCPBYFiRD+4rtU
	3iR0nNQWlD8tkIqek5wLtiSDtkG5JgSMD0A21zlTW1lHRoFxmypSGpA6ylsvMPI+q6V65BGO27GEn
	MXtf2hc/33osF/0jiEeblKx4gUlF0ipPo0yucnfg887oWtimnR7nwyxuirjU6gA5AQ4o7voNkaC1A
	xSdtaqHMKOQIBwrWteidDWFCRZVi6vOoI+2UrDQnyVV4Xk8BuKmudXJJ644CTYZfUQ/GG7swwfNoE
	iqAQxAOVc5Zd+8vkKOw87Te9fUYVUXvuhMl9H6QyiJ1OdjxenF8CU5rhAce22W0X6HkQ6tiZYNVty
	Ru3GyvvQ==;
Received: from [177.238.17.151] (port=37764 helo=[192.168.0.101])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1uADOk-00000002wuX-3ONN;
	Wed, 30 Apr 2025 14:47:15 -0500
Message-ID: <ff411eb8-0321-488a-8e5e-14f426943697@embeddedor.com>
Date: Wed, 30 Apr 2025 13:47:09 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] bcachefs: Avoid -Wflex-array-member-not-at-end
 warnings
To: Kent Overstreet <kent.overstreet@linux.dev>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aBJ4WVcvHv9sD1K6@kspp>
 <zn74qlanwd3b4wmyecn7ostb6i42ceycaa2myijimfsrs3eglc@tsgoa3zbe6ue>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <zn74qlanwd3b4wmyecn7ostb6i42ceycaa2myijimfsrs3eglc@tsgoa3zbe6ue>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.17.151
X-Source-L: No
X-Exim-ID: 1uADOk-00000002wuX-3ONN
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.101]) [177.238.17.151]:37764
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 13
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHp3rUpda+KXxi8BR1vbUERp+VKqgLj1URGpa4aQnCXa1eajigSCNAMy/9SL8Fmn+5o2keF5GIb+k/MKphmKDC1u/VHur3amuQsi8ZP0gGzmmPCiyEog
 /8nz5jEcdzw9FBAgpjDOWJVUf30dZPaP/IPV2m46Q3MhmvNQBV3LVMWpzl4vr8roVmDtsa59tqF6e6lIEn8aiNrjt5v2o6hKtY9gXw9Q0OUTt9G+jiUPQk01

> Applied. Presumably you only need this in 6.16?

Yes - there's no hurry.

Thanks

-Gustavo

