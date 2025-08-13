Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AFA2D47EB;
	Wed, 13 Aug 2025 07:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755068726; cv=none; b=DaY7B4DkDbZaKTbo+r0J2qdVqz37WWo6kan4OPmGyiHvuEcbPhjyFxd7CtFqtzZcwyF3WHqUI5/Td559Tq6PbhIiAcVZxNBewWEGzUOHyvMF8PF92xfnspuHzqb+p6TgwcUTZ6Ww6RreiNkQvkhWeePrt58OUXQJY+1HMSJ/szI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755068726; c=relaxed/simple;
	bh=Blj+rAkGaR1Tv69tNIKtlIhVlfPFKhegYi6Zanh+HSQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Z/3W7ZJ4jghP5DpIdtydUbzRodJbxQTol29210UcXOqWqdg9xwv315Z3PbExpQPRL4m4s+jWk3g7pSv+IEZW46Xw5/6oZnAPTPfG5OPYoI8qcNTg6W+RZiImfzqFft6HPjCSEgNqFi41Zk9/lOnfE1ZbRGkc0bvfvzO4DAhl2bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=I3ZFenF/; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="I3ZFenF/"
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id lzZouumiX5wATm5XyuMkI2; Wed, 13 Aug 2025 07:05:18 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id m5XxuPIicwYTkm5XxuHNIO; Wed, 13 Aug 2025 07:05:17 +0000
X-Authority-Analysis: v=2.4 cv=fYCty1QF c=1 sm=1 tr=0 ts=689c392d
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=R1XpmoYe2GHAZdAE2O7VqQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7T7KSl7uo7wA:10
 a=1ml3npyrcYbOIoRaIsMA:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8CHxB1Wtr3Lygs//ada2Fd8yg7mcVvvMNOvlWGSBdN4=; b=I3ZFenF/oSKFdznfXcmVkwDLWH
	jpYuyLFZB/s3kjtkIinOMc6T0qePM+SdCTNDr4vrY9+ffKlxUYYZYaLdOCzNtMF4/brQeOpXIRPuN
	AdZPXWP84dS1Mrhx77NS1c4wmAq8E4QkbwtdzmE/C9692L6HjslLXtKGgJD4FVTjWFxnxgmPYIN+k
	k3LEoWTAbLtowaHrayu2E2gmh/kUS2tYFR+ATad0/BzNOjp5JWrtYUD0Cd1fY6vymUoq7rlrV8O6c
	5Jvfu4fif+ZZYkfJc9N80vKfl7BOm3eAOeJxe7vkMSYrfPMdGmnEbn/ZQ18gzJdHV3SunW4eDbIsD
	5WHOj5Hg==;
Received: from oni-27.109.98-104.oninet.ne.jp ([27.109.98.104]:38110 helo=[192.168.0.175])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1um3n1-00000002TtW-1RYw;
	Wed, 13 Aug 2025 00:12:43 -0500
Message-ID: <d43dac3e-122d-4c16-9c1e-760eac91b8da@embeddedor.com>
Date: Wed, 13 Aug 2025 14:12:30 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] drm/amd/pm: Avoid multiple
 -Wflex-array-member-not-at-end warnings
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kenneth Feng <kenneth.feng@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <Z678TNhCbTk363Tw@kspp>
 <864c7dd5-0deb-4adb-a1cf-c8a809514d7e@embeddedor.com>
 <217b00f5-d03d-4624-9ba9-d838199ef7b9@embeddedor.com>
 <CADnq5_M5Jv4A5CXAKY2Qd-dhrfmecnauRtVY_ghSsut7i=KNww@mail.gmail.com>
 <d07b4edc-6048-4c10-b8ac-dcccd5a932d3@embeddedor.com>
Content-Language: en-US
In-Reply-To: <d07b4edc-6048-4c10-b8ac-dcccd5a932d3@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 27.109.98.104
X-Source-L: No
X-Exim-ID: 1um3n1-00000002TtW-1RYw
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: oni-27.109.98-104.oninet.ne.jp ([192.168.0.175]) [27.109.98.104]:38110
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLKAMFhgpPdujCh/bDfZnwZkmVzdv2KvaLkUlxLNbkEnBIAlkACvXGYJRseIZgTBjIn6+sJR2wiFlUww7wV18+/fC1eiXa3icq30Kyr7niEixUI4OhG0
 36uhZpFLHVpQJ+Red5t7nNhsXKgqRNgYsWw+xMHbP1Z4sYLBvWnsSh4RHQWQqkfwRuFBiqJfwrWILJ/rp+kW03B5uqumXp2TOFykgxwRgzy4yp+sYvsAuvtK
 Mx7+F3DR5LzLZaLQHDQtFtU2TLuaiF3vgTsGxkS+YUk=

Hi!

On 22/04/25 23:58, Gustavo A. R. Silva wrote:
> 
> 
> On 16/04/25 09:04, Alex Deucher wrote:
>> Can you resend, I can't seem to find the original emails.
>> Additionally, all of the NISLANDS structures are unused in amdgpu, so
>> those could be removed.

I'm taking a look at this, and it seems that those NISLANDS structs are actually
needed in amdgpu code. For instance, `struct si_power_info` contains a member
of the type of `struct ni_power_info`, and this latter struct contains a
member of the type of `NISLANDS_SMC_STATETABLE`, thus `NISLANDS_SMC_SWSTATE`
and `NISLANDS_SMC_HW_PERFORMANCE_LEVEL` are needed, and so on.

So, it seems that all those structs should stay. What do you think?

Thanks!
-Gustavo
