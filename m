Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA5BF4EB;
	Sun,  7 Jul 2024 07:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720337691; cv=none; b=Qig4wjPVYJh5Ifujx2SVqCE/pfp2z34GYRVkNHpQIx1oOIk7Ocf4ZCcuDR3NysDOE6ueMncDNonYW+lvlT4QZUDiEY6miD12FHYUsJ0l/bCMyuircQSjCdut3RItMHf9cqeW/v24F7FUvg0rzI+shimhAbsQq6/uneaDWyBow7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720337691; c=relaxed/simple;
	bh=SdMTMEyAxrDIFF9Na+K5TW8VSz8xAY0Kf2QaI/yF0XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nIy+dYFUo7zeTUOl+0RjVEaGX9KfV8F9v6JCgmWat7lJELptIpHwApsHFu4+/E5RjU2ePxy21DpqONta2uLFvXnBvIIk77Vh0h++/Kx6MUoZLHLYrEmvuMWBuMI6FSUntC/NkrIWXqfAbaEXQE2IPBOxZ5eUF9UcSUr9lNTIQho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtpip3t1720337660tkacxpm
X-QQ-Originating-IP: xEPDphvktVF415/GqFjUMqm3UtXJmiJdfibU97Nz69Q=
Received: from [IPV6:240e:36c:d19:e900:dfc1:d0 ( [255.153.174.1])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 07 Jul 2024 15:34:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8694329200217638920
Message-ID: <B7E3B29557B78CB1+afadbaa6-987e-4db4-96b5-4e4d5465c37b@uniontech.com>
Date: Sun, 7 Jul 2024 15:34:15 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] Revert "bpf: Take return from set_memory_rox() into
 account with bpf_jit_binary_lock_ro()" for linux-6.6.37
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, sashal@kernel.org, ast@kernel.org,
 keescook@chromium.org, linux-hardening@vger.kernel.org,
 christophe.leroy@csgroup.eu, catalin.marinas@arm.com, song@kernel.org,
 puranjay12@gmail.com, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 illusionist.neo@gmail.com, linux@armlinux.org.uk, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 chenhuacai@kernel.org, kernel@xen0n.name, loongarch@lists.linux.dev,
 johan.almbladh@anyfinetworks.com, paulburton@kernel.org,
 tsbogend@alpha.franken.de, linux-mips@vger.kernel.org, deller@gmx.de,
 linux-parisc@vger.kernel.org, iii@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, linux-s390@vger.kernel.org, davem@davemloft.net,
 sparclinux@vger.kernel.org, kuba@kernel.org, hawk@kernel.org,
 netdev@vger.kernel.org, dsahern@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, guanwentao@uniontech.com, baimingcong@uniontech.com
References: <5A29E00D83AB84E3+20240706031101.637601-1-wangyuli@uniontech.com>
 <2024070631-unrivaled-fever-8548@gregkh>
From: WangYuli <wangyuli@uniontech.com>
Content-Language: en-US
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <2024070631-unrivaled-fever-8548@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1


On 2024/7/6 17:30, Greg KH wrote:
> This makes it sound like you are reverting this because of a build
> error, which is not the case here, right?  Isn't this because of the
> powerpc issue reported here:
> 	https://lore.kernel.org/r/20240705203413.wbv2nw3747vjeibk@altlinux.org
> ?

No, it only occurs on ARM64 architecture. The reason is that before 
being modified, the function

bpf_jit_binary_lock_ro() in arch/arm64/net/bpf_jit_comp.c +1651

was introduced with __must_check, which is defined as 
__attribute__((__warn_unused_result__)).


However, at this point, calling bpf_jit_binary_lock_ro(header) 
coincidentally results in an unused-result

warning.

> If not, why not just backport the single missing arm64 commit,

Upstream commit 1dad391daef1 ("bpf, arm64: use bpf_prog_pack for memory 
management") is part of

a larger change that involves multiple commits. It's not an isolated commit.


We could certainly backport all of them to solve this problem, but it's 
not the simplest solution.

> and why
> didn't this show up in testing?

Thanks for the tip.

I'll be sure to keep a closer eye on the stable kernel testing phase in 
the future and hopefully catch any

problems more timely.

> confused,
>
> greg k-h
>
Sincerely
-- 
WangYuli <wangyuli@uniontech.com>
