Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5197E1A2540
	for <linux-hardening@vger.kernel.org>; Wed,  5 Jun 2024 12:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588987; cv=none; b=l4g5HrBcth2gyPkHKh7c2KPfBK0oeZtP3M1FMR1QKN/tO0jzzCvWsKkAeM5/hj7MkO1B9pnk1HQjdJPdDDOEcRx5oJ/lr6oGVnKRIdUyQwdPXV3JqGe8zPYGy9RqgXFP65CWnKLh9i892PF02MC264adORhMqnHX2GlqBBawtXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588987; c=relaxed/simple;
	bh=v45rZFkWL4y7M1IeR8TMrI/U03EwanvNHD6H4XwB3Gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LMJJ5LsvKnvpP3W+Q7/0n2bWZRY+n5ubGgu+JB7vaEhTakDPjk/O/wlVT9aZbP1W4LixqdHUydWZykto8F3ArsdoivVdBJ4GryWE4Raf2ghl75SCuCCKBGTQnRuUuR0ZkgEBANwQdZfRdSnrR4JwTYlh2S4DWaBDMdr/5cd03Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1717588980-1eb14e157819080001-PleebU
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id JhSxNtY1raheGU8k (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 05 Jun 2024 20:03:00 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.27; Wed, 5 Jun
 2024 20:02:59 +0800
Received: from [10.32.65.162] (10.32.65.162) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.27; Wed, 5 Jun
 2024 20:02:57 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Message-ID: <46741fad-425c-4ed2-97be-3f2679da63eb@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.32.65.162
Date: Wed, 5 Jun 2024 20:02:52 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/hpet: Read HPET directly if panic in progress
To: Borislav Petkov <bp@alien8.de>
X-ASG-Orig-Subj: Re: [PATCH] x86/hpet: Read HPET directly if panic in progress
CC: Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds
	<torvalds@linux-foundation.org>, Dave Hansen <dave.hansen@intel.com>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <keescook@chromium.org>, <tony.luck@intel.com>,
	<gpiccoli@igalia.com>, <mat.jonczyk@o2.pl>, <rdunlap@infradead.org>,
	<alexandre.belloni@bootlin.com>, <mario.limonciello@amd.com>,
	<yaolu@kylinos.cn>, <bhelgaas@google.com>, <justinstitt@google.com>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
	<CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>
References: <20240528063836.5248-1-TonyWWang-oc@zhaoxin.com>
 <50fc1bd3-909e-41c4-a991-9d81e32ef92c@intel.com> <87wmnda8mc.ffs@tglx>
 <CAHk-=wgMoeOTL1V3wTO=o=U1OXn7xF8OWv2hB9NF9Z=G4KotfQ@mail.gmail.com>
 <87le3t9i8c.ffs@tglx> <0aff3f62-a8a5-4358-ae3f-2ded339aface@zhaoxin.com>
 <20240605093609.GCZmAxidNIBP5bkDcX@fat_crate.local>
 <e4f307dd-3264-45f6-82eb-0102f7fb99d7@zhaoxin.com>
 <20240605113323.GFZmBNA7ec2s191_2w@fat_crate.local>
Content-Language: en-US
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
In-Reply-To: <20240605113323.GFZmBNA7ec2s191_2w@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1717588980
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1262
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.125831
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------



On 2024/6/5 19:33, Borislav Petkov wrote:
> 
> 
> [这封邮件来自外部发件人 谨防风险]
> 
> On Wed, Jun 05, 2024 at 06:10:07PM +0800, Tony W Wang-oc wrote:
>> It may also happen without setting fake_panic, such as an MCE error of the
>> UCNA/SRAO type occurred?
> 
> Which types exactly do you mean when you're looking at the severities[]
> array in severity.c?
> 
> And what scenario are you talking about?
> 
> To get an #MC exception and detect only UCNA/SRAO errors? Can that even
> happen on any hardware?
> 

Yes, I mean an #MC exception happened and detect only like SRAO errors 
like below:

         MCESEV(
                 AO, "Action optional: memory scrubbing error",
                 SER, MASK(MCI_UC_AR|MCACOD_SCRUBMSK, 
MCI_STATUS_UC|MCACOD_SCRUB)
                 ),
         MCESEV(
                 AO, "Action optional: last level cache writeback error",
                 SER, MASK(MCI_UC_AR|MCACOD, MCI_STATUS_UC|MCACOD_L3WB)
                 ),

I think these errors are actually encountered on some platforms that 
support these type of errors report to the #MC.

Sincerely
TonyWWang-oc
> --
> Regards/Gruss,
>      Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
