Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BDA2BD0D
	for <linux-hardening@vger.kernel.org>; Wed,  5 Jun 2024 06:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717568639; cv=none; b=CtAntl+oMK5Nk9g/4ZPJ/Y/v0KGVEtjyRm6nQSUX3ptnfAMBpADUFedgXh4ZY4hYPy7aJ/z3S+JJf1Cub50Dp9CH5VQxHrJ7r3WY/PBCJKmBZKyLru23hwCzyFVvZLui+HLjBsRgqErn+cf0NRjcz3RA8ps6ajKgiODTRcenzD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717568639; c=relaxed/simple;
	bh=D1FGYykQrnI/TmCi/edyw84RB2hRS16xw2RjxjfQM+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XpINLvmw/pPHeMu6Pdtm+yh17J/7Xe/eaRq8WVmALUlZmx1sHA+9yo9+FqOcvCLokjWTAsUd6chyfP2+RGi5b1QSqofVEhdf1JBng9Ktx2RrVdFqO/+/IfDRsKQ9FdhOQBhwWsDYQAsHNGcb8a+jwXiB8PVJ+JtcIJzEFiztzYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1717568626-1eb14e157518a10001-PleebU
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id wzHAcNBuJgAVOrCV (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 05 Jun 2024 14:23:46 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 5 Jun
 2024 14:23:45 +0800
Received: from [10.32.65.162] (10.32.65.162) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.27; Wed, 5 Jun
 2024 14:23:43 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Message-ID: <0aff3f62-a8a5-4358-ae3f-2ded339aface@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.32.65.162
Date: Wed, 5 Jun 2024 14:23:32 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/hpet: Read HPET directly if panic in progress
To: Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds
	<torvalds@linux-foundation.org>
X-ASG-Orig-Subj: Re: [PATCH] x86/hpet: Read HPET directly if panic in progress
CC: Dave Hansen <dave.hansen@intel.com>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<keescook@chromium.org>, <tony.luck@intel.com>, <gpiccoli@igalia.com>,
	<mat.jonczyk@o2.pl>, <rdunlap@infradead.org>,
	<alexandre.belloni@bootlin.com>, <mario.limonciello@amd.com>,
	<yaolu@kylinos.cn>, <bhelgaas@google.com>, <justinstitt@google.com>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
	<CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>
References: <20240528063836.5248-1-TonyWWang-oc@zhaoxin.com>
 <50fc1bd3-909e-41c4-a991-9d81e32ef92c@intel.com> <87wmnda8mc.ffs@tglx>
 <CAHk-=wgMoeOTL1V3wTO=o=U1OXn7xF8OWv2hB9NF9Z=G4KotfQ@mail.gmail.com>
 <87le3t9i8c.ffs@tglx>
Content-Language: en-US
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
In-Reply-To: <87le3t9i8c.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1717568626
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2578
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.125820
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------



On 2024/5/29 15:42, Thomas Gleixner wrote:
> 
> 
> [这封邮件来自外部发件人 谨防风险]
> 
> Linus!
> 
> On Tue, May 28 2024 at 16:22, Linus Torvalds wrote:
>> On Tue, 28 May 2024 at 15:12, Thomas Gleixner <tglx@linutronix.de> wrote:
>> I see the smiley, but yeah, I don't think we really care about it.
> 
> Indeed. But the same problem exists on other architectures as
> well. drivers/clocksource alone has 4 examples aside of i8253
> 
>>>    1) Should we provide a panic mode read callback for clocksources which
>>>       are affected by this?
>>
>> The current patch under discussion may be ugly, but looks workable.
>> Local ugliness isn't necessarily a show-stopper.
>>
>> So if the HPET is the *only* case which has this situation, I vote for
>> just doing the ugly thing.
>>
>> Now, if *other* cases exist, and can't be worked around in similar
>> ways, then that argues for a more "proper" fix.
>>
>> And no, I don't think i8253 is a strong enough argument. I don't
>> actually believe you can realistically find a machine that doesn't
>> have HPET or the TSC and really falls back on the i8253 any more. And
>> if you *do* find hw like that, is it SMP-capable? And can you find
>> somebody who cares?
> 
> Probably not.
> 
>>>    2) Is it correct to claim that a MCE which hits user space and ends up in
>>>       mce_panic() is still just a regular exception or should we upgrade to
>>>       NMI class context when we enter mce_panic() or even go as far to
>>>       upgrade to NMI class context for any panic() invocation?
>>

After MCE has occurred, it is possible for the MCE handler to execute 
the add_taint() function without panic. For example, the fake_panic is 
configured.

So the above patch method does not seem to be able to cover the printk 
deadlock caused by the add_taint() function in the MCE handler when a 
MCE occurs in user space.

Sincerely
TonyWWang-oc

>> I do think that an NMI in user space should be considered mostly just
>> a normal exception. From a kernel perspective, the NMI'ness just
>> doesn't matter.
> 
> That's correct. I don't want to change that at all especially not for
> recoverable MCEs.
> 
>> That said, I find your suggestion of making 'panic()' just basically
>> act as an NMI context intriguing. And cleaner than the
>> atomic_read(&panic_cpu) thing.
>>
>> Are there any other situations than this odd HPET thing where that
>> would change semantics?
> 
> I need to go and stare at this some more.
> 
> Thanks,
> 
>          tglx
