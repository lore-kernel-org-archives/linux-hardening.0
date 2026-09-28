Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963A017A305;
	Mon, 28 Sep 2026 01:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790560747; cv=none; b=eHsVSGnDq/n6dsAlFYFWeg+V9DE/IODlb7CdP6CSB911ab6ZNOu/AZxu4A94NBv+o9ITJhlBI7htbdCaSm1j7nk5prrT3Sf8UAXni6F3OaS6hlQZRaeAtWbtJsnkRn/8Z6j2vXUd8VlpeZQV7TxrReKVtVMRAOiuz+euWNgSTzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790560747; c=relaxed/simple;
	bh=qB62AJSN3Sg4eqEMY1QmfXeoC2Eq6WxKoVkEaEb7qyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Pf0EuPiIySMU7nUHH72Vw/QxgWv7pjDST+YQSXl1obkUsCjf1VGxVIVyQ8YAv688W7EpGiSqiA1iVqR7N8PJQ6i+eG1lfspPl1RIdrJ9Ng0sXSzhF9jDyzsX/zbBm01zNiu9uENTVvQgEd/X8/2PVGgnZryLzA0Clhh8nopJSts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=c8dcqaXp; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="c8dcqaXp"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ezDik2QaMp/3ORzwR99KO4kmsJHD+sAI1866xdo9UFo=;
	b=c8dcqaXpuskHliNTYZeLq0e3Pj81CJDeoPIqV+h3UR+jeMo9uTIBckSAig2RFSP7D/5X1jkSQ
	Kri/L0EkszIApThuKCQWIUkH3ozc+qoSq/k09tuhFDiGJIZpQSdJMxQgaWWjE3J9lJEESgRbTfg
	p3oPCSGaBJkwhzuCuW8e38I=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4htPLN0C5mz1prQs;
	Mon, 28 Sep 2026 09:46:52 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 0033D40538;
	Mon, 28 Sep 2026 09:59:02 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemk200008.china.huawei.com (7.202.194.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 28 Sep 2026 09:59:00 +0800
Message-ID: <a8a8edfd-0f01-4a30-9876-a9eab172eb0e@huawei.com>
Date: Mon, 28 Sep 2026 09:58:59 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ptrace: Add PTRACE_SYSEMU_SINGLESTEP
 syscall-exit-stop test
To: Kees Cook <kees@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<oleg@redhat.com>, <luto@amacapital.net>, <wad@chromium.org>,
	<peterz@infradead.org>, <ada.coupriediaz@arm.com>, <linusw@kernel.org>,
	<yeoreum.yun@arm.com>, <kevin.brodsky@arm.com>, <anshuman.khandual@arm.com>,
	<james.morse@arm.com>, <thuth@redhat.com>, <vladimir.murzin@arm.com>,
	<tglx@kernel.org>, <broonie@kernel.org>, <liqiang01@kylinos.cn>,
	<ryan.roberts@arm.com>, <pengcan@kylinos.cn>, <kmehltretter@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>, Shuah Khan <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>
References: <20260922195719.i.211-kees@kernel.org>
 <bbd65e4d-8096-4939-8308-f0f54c5cb3bc@huawei.com>
 <202609241654.F545D3A88@keescook>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <202609241654.F545D3A88@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk200008.china.huawei.com (7.202.194.74)



在 2026/9/25 7:56, Kees Cook 写道:
> On Thu, Sep 24, 2026 at 12:11:31PM +0800, Jinjie Ruan wrote:
>>
>>
>> 在 2026/9/23 3:57, Kees Cook 写道:
>>> ptrace(2) states that no syscall-exit-stop occurs when a tracee is
>>> continued with PTRACE_SYSEMU or PTRACE_SYSEMU_SINGLESTEP. arm64 gated
>>> its syscall-exit report on
>>>
>>> 	flags & (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP)
>>
>> Hi Kees,
>>
>> The original fix description is a bit off: on arm64 there is no extra
>> syscall-exit-stop; instead, there's an additional pseudo single-step
>> injection.
>>
>> As sashiko pointed out, as commit ac2081cdc4d9 ("arm64: ptrace:
>> Consistently use pseudo-singlestep exceptions") described, for
>> PTRACE_SYSEMU_SINGLESTEP, arm64 still needs the pseudo single-step
>> because its hardware single-step state machine is fast-forwarded over
>> the SVC instruction.
> 
> Ah! Okay. So this test should be tweaked to deal with that? Feel free to

Yes, I understand that these two cases should be distinguished.

> snag/update this test for the series. We didn't have anything testing
> syscall exit stops, so it seemed reasonable to get it written.

I agree with adding a syscall exit stop test case to check whether it
violates what the man page describes.

At the same time, I think we could also add a test case to verify the
problems that may arise from arm64's own missing pseudo single-step.

> 
> -Kees
> 

-- 
Best regards,
Jinjie

