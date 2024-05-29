Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A04733CFC
	for <linux-hardening@vger.kernel.org>; Wed, 29 May 2024 08:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716970556; cv=none; b=gLqy4nHi5DKraNjNkMhHuPR5V5UWWtLKibTvUtkOUIPIRTrOVHuCypA+o9MWxJfySaD1qIjuxF2BioRTs1NLKzK09zqqPLdZB/83uXAL5mup0oVidUWFf18fsh6cj3p6rzn/u+Lw+9DEmNnC+OovfjZzirwHhC4jdwq/jqjvpBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716970556; c=relaxed/simple;
	bh=cuxz7ztoxm/x637MW1ZSYEWD/c8J3SkKlVkO85drTEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ohp59TozwiT7qYL7vKdW9o0rlODVJYEK938kxtyuzkqFHp5osl8MaiH4rqTQxOwgHsE60bAff28k0jGL9lgXW7SqqWy7zO8T/6sqn8AGBArGEvrvjK2y+Qu8w1pZXUzoJ19qcYNjLSBv2Xmjqf8itn4y2sVZsexh1SA3fnEbybE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1716970546-086e23110513300001-PleebU
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id fvfnuKaLOC7Ez4wT (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 29 May 2024 16:15:46 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 29 May
 2024 16:15:45 +0800
Received: from [10.32.65.162] (10.32.65.162) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.27; Wed, 29 May
 2024 16:15:43 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Message-ID: <d8952567-f97d-45ae-976e-5fe5d172df41@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.32.65.162
Date: Wed, 29 May 2024 16:15:37 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/hpet: Read HPET directly if panic in progress
To: Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@intel.com>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <keescook@chromium.org>,
	<tony.luck@intel.com>, <gpiccoli@igalia.com>, <mat.jonczyk@o2.pl>,
	<rdunlap@infradead.org>, <alexandre.belloni@bootlin.com>,
	<mario.limonciello@amd.com>, <yaolu@kylinos.cn>, <bhelgaas@google.com>,
	<justinstitt@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>
X-ASG-Orig-Subj: Re: [PATCH] x86/hpet: Read HPET directly if panic in progress
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
References: <20240528063836.5248-1-TonyWWang-oc@zhaoxin.com>
 <50fc1bd3-909e-41c4-a991-9d81e32ef92c@intel.com> <87wmnda8mc.ffs@tglx>
 <2553dd17-f763-4894-89b7-5f76c03d3a37@zhaoxin.com>
 <199ba55d-8eb8-47df-9f42-55a865b51ab7@zhaoxin.com> <87fru19i3x.ffs@tglx>
Content-Language: en-US
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
In-Reply-To: <87fru19i3x.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1716970546
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 628
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.125498
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------



On 2024/5/29 15:45, Thomas Gleixner wrote:
> 
> 
> [这封邮件来自外部发件人 谨防风险]
> 
> On Wed, May 29 2024 at 14:44, Tony W Wang-oc wrote:
>> Actually, this scenario is what this patch is trying to solve.
>>
>> We encountered hpet_lock deadlock from the call path of the MCE handler,
>> and this hpet_lock deadlock scenario may happen when others exceptions'
>> handler like #PF/#GP... to call the panic. So read_hpet should avoid
>> deadlock if panic in progress.
> 
> That's not what your changelog says.

Yes.
The example flow I gave with the MCE handler in my changelog is misleading.
