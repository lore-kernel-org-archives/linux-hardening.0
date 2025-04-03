Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB8919ABD4
	for <linux-hardening@vger.kernel.org>; Thu,  3 Apr 2025 17:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743701705; cv=none; b=CUd8NndXdfaCwdoywSfnBjX07BztRZRSgefrBLrjMSkRuBtg3wFbjsbMX9JQb+kxmdjZvDa+Vu7ytC+r8K4fCNZvM+btfhLzDUNlQqmMYdSXs2W9+bLIhUHIFuBeJzZuXydW5my5CWEt/D4hZ1zIxKPqkPUFAPs7hvPm+EFbu3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743701705; c=relaxed/simple;
	bh=N+/sPqbGOxBMdM7Zey0dI8Kpexl+RXW3F/uu+lKz95U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XeNiwNYtVACv5rjFNzN5EoDl9DDdQTchJsyALZm1zvaVjBHeGCJdkMnrkzQL+FvtcQ2xrn5VBZMcyq+k36g9Ry1fV7Z3MkdlckiuR8DYlDTaOup4iAVseeAK9xAxmw4l2Btl/AMSEJjQKJB+CidMckHM+knSA/HjQVPgX2nYW64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=f8hniX71; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="f8hniX71"
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id 0MGeuhNL4f1UX0OSvuM8iy; Thu, 03 Apr 2025 17:34:57 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 0OSuuTotORlrs0OSvusQc0; Thu, 03 Apr 2025 17:34:57 +0000
X-Authority-Analysis: v=2.4 cv=Qamtvdbv c=1 sm=1 tr=0 ts=67eec6c1
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=B3fuDwYyW55wTQKIj88FGw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=7T7KSl7uo7wA:10
 a=AwQk-W9g5lI6dlRaMUIA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=N+/sPqbGOxBMdM7Zey0dI8Kpexl+RXW3F/uu+lKz95U=; b=f8hniX71WgPZO1+E0lnTSk3xBQ
	iLjc6NftmI9B7ejNFC9yV655NLm+rGZjHzJeAqSQGpl46kB9TAFV5ZpgwMPXhhtZrfnb7jQMxS0bj
	saYdBslAnFmGXU/rU5upDh4WKckMmhCXzmrlfvZ40hv1VX4w9KOj4Ex8ZMfhi49fdZig9KoW+8Dwh
	vo7OCycgb+DD2AiU86f/S/BmiuNM7sk2Dv2ZURuBguiT0wOE9eyd5/hM4egvm5yySw2byf80FhCJF
	L+PgTNwjSgf28N8gtg+7oQWciHaB2kNO5pZ5O9XXLEeyR15kcjb3FWdp5/T3Upm5BOKeEIzoKGrK2
	9pxaiv1w==;
Received: from [201.172.174.147] (port=55110 helo=[192.168.15.6])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1u0OSu-00000000rpG-17It;
	Thu, 03 Apr 2025 12:34:56 -0500
Message-ID: <08f9d29f-9676-4c92-adfa-32368637f392@embeddedor.com>
Date: Thu, 3 Apr 2025 11:34:50 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] drm/nouveau: disp: Avoid
 -Wflex-array-member-not-at-end warning
To: Danilo Krummrich <dakr@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <Z-2zI55Qf88jTfNK@kspp> <Z-6xwS3qXIyxE05G@pollux>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <Z-6xwS3qXIyxE05G@pollux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.174.147
X-Source-L: No
X-Exim-ID: 1u0OSu-00000000rpG-17It
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.6]) [201.172.174.147]:55110
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDecRYNUWBm5iU2cJZWqgcowhwX0RirMzwaiUzTvPBDYfglE5TUTBmbjdjtUo7wEFvN8py8ssPNxDg21sn3S26h+vqrBM92TOdjcsxRi0bLiVpwDYtxV
 e4a8NuoO0RlLJPGcqn4AiJEbDtxsN1+wzZIBBIjvhhQmaqhzsSEnJoVOdOJlgpMvHeL3JH2XqIvHFkeIa8CRn+yrltdzSLP2mGRvRbScKIBrWCAla3YYKwQk


> Applied this one (as well as the svm and fence one) to drm-misc-next, thanks!

Awesome. :)

Thanks!
--
Gustavo
