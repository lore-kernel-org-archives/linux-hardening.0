Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF701B86D8
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jul 2024 18:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720550352; cv=none; b=iEyT8eTcb03pxiP/oUo+LkMiV51qgli4+ArzR+09qCxXDQYDB80+kaO0UR4Yn5nBQkhLW1EICrFgP6+nm3nzTGveQi+k/+leZdfsBLy1/mQLe3raS2Guae5JZyf8jWWp8AOwfh1WGzmGY6cCJXvfFpowfNL80KLrQvUq/J9qFtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720550352; c=relaxed/simple;
	bh=at4EsWC72kT00VKxxmqnlOC0igBZImvWpcDtL72NrcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KGtJEbSZ6/aEENxLJMqReLd7pSAPOEcjtR+gW8DeUtr+lNEhldjSmo8a1Kq/ZP2FepacqRMgcIvlU4SSTOEfqAs7MOWVhDPbKIWhtgc9eCKrWLLFLXPUOQqdGAF9o0gMK8yHMw93waqfEVMA2LblZRP8rQn4TPVFcik5Rc643D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=EMbD4TuP; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="EMbD4TuP"
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id RFYLsAPJtJXoqRFiYsAsgp; Tue, 09 Jul 2024 18:37:34 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id RFiWsy5BBKjfORFiXsN7hO; Tue, 09 Jul 2024 18:37:33 +0000
X-Authority-Analysis: v=2.4 cv=BqJWwpX5 c=1 sm=1 tr=0 ts=668d836d
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=wYkD_t78qR0A:10 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=oGMlB6cnAAAA:8
 a=1XWaLZrsAAAA:8 a=8K4sKswruK-ULGrGXUgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=NdAtdrkLVvyUPsUoGJp4:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=A8ezBF4AaCnowVFoVmRVzdwt6z2QVTYX8NN5Cjxe1+4=; b=EMbD4TuPh16NWTORuNa7IHiTHx
	dCWy2hj9xoG52EUditg5pe2iCr6CE4Q/otUsBFXlN51J/TBUXr24p/hcF5mDkg+crAJsDj1k+9l5G
	A2c12YSH8CXNkXWPFgbLLguSrdUGjmejap8gUHKsrVOPCBsTHlfIQepFLYZbuV9dNjqNYZGiFTej5
	5cnFY9OFLG3MCLiQtv3cTqd9Zm3YNHL9GHOp7O/2GWHYaN4L3d7e2qnBk8tnkPGVX3+5OjwWifbcm
	UGp3c6GhwK8cN2b7AkFv9Q/MoRQBNfGPKjNQs2nOQp1rDISd52s6nENrtGtDU7kmXv+0V3+lWtGo7
	x69nCMnA==;
Received: from [201.172.173.139] (port=55666 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sRFiU-0045JG-1p;
	Tue, 09 Jul 2024 13:37:30 -0500
Message-ID: <725db889-459e-45ae-8222-02dd6621f302@embeddedor.com>
Date: Tue, 9 Jul 2024 12:37:27 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/syscall: Avoid memcpy() for ia32
 syscall_get_arguments()
To: Mirsad Todorovac <mtodorovac69@gmail.com>, Kees Cook <kees@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Peter Collingbourne <pcc@google.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240708202202.work.477-kees@kernel.org>
 <e95852cf-231a-4525-9075-fad42930d328@embeddedor.com>
 <39b94091-d452-4dac-9012-ae43024462cd@gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <39b94091-d452-4dac-9012-ae43024462cd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sRFiU-0045JG-1p
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.173.139]:55666
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfICa0CGBGsUMHSC/pr3DEwQ7zGxdu/aa/IcZlcX55P+xbGdj7JAuAFdCYBuUM6eFpQ5mkaSU3o22a0Fhaqq1uduKhajD37R+7uuSLhWg8V0oWLNpo+Kc
 hB6FU2vB2E+yfpoPtobFBdEyOFTnxH/E1G9GIb/A+0Xgf4vhzxmfekv+MLgfko+67kBEepHCjkTJ2BM+7rqt/sAWJQSyFqeiYMprZ5i9TG7vvoGY7CqpgATD



On 09/07/24 12:20, Mirsad Todorovac wrote:
> 
> 
> On 7/9/24 01:44, Gustavo A. R. Silva wrote:
>>
>>
>> On 7/8/24 14:22, Kees Cook wrote:
>>> Modern (fortified) memcpy() prefers to avoid writing (or reading) beyond
>>> the end of the addressed destination (or source) struct member:
>>>
>>> In function ‘fortify_memcpy_chk’,
>>>       inlined from ‘syscall_get_arguments’ at ./arch/x86/include/asm/syscall.h:85:2,
>>>       inlined from ‘populate_seccomp_data’ at kernel/seccomp.c:258:2,
>>>       inlined from ‘__seccomp_filter’ at kernel/seccomp.c:1231:3:
>>> ./include/linux/fortify-string.h:580:25: error: call to ‘__read_overflow2_field’ declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror=attribute-warning]
>>>     580 |                         __read_overflow2_field(q_size_field, size);
>>>         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> As already done for x86_64 and compat mode, do not use memcpy() to
>>> extract syscall arguments from struct pt_regs but rather just perform
>>> direct assignments. Binary output differences are negligible, and actually
>>> ends up using less stack space:
>>>
>>> -       sub    $0x84,%esp
>>> +       sub    $0x6c,%esp
>>>
>>> and less text size:
>>>
>>>      text    data     bss     dec     hex filename
>>>     10794     252       0   11046    2b26 gcc-32b/kernel/seccomp.o.stock
>>>     10714     252       0   10966    2ad6 gcc-32b/kernel/seccomp.o.after
>>>
>>> Reported-by: Mirsad Todorovac <mtodorovac69@gmail.com>
>>> Closes: https://lore.kernel.org/lkml/9b69fb14-df89-4677-9c82-056ea9e706f5@gmail.com/
>>> Signed-off-by: Kees Cook <kees@kernel.org>
>>> ---
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Borislav Petkov <bp@alien8.de>
>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>> Cc: x86@kernel.org
>>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>>> Cc: Daniel Sneddon <daniel.sneddon@linux.intel.com>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Brian Gerst <brgerst@gmail.com>
>>> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
>>> Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
>>> Cc: Peter Collingbourne <pcc@google.com>
>>
>> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>
>> Thanks
> 
> I can confirm that the error was fixed after applying the patch, in the same build environment.
> 
> Tested-by: Mirsad Todorovac <mtodorovac69@gmail.com>
> 
> However, why memcpy() directly from struct pt_regs doesn't work is beyond my understanding :-/
> 

This is because under CONFIG_FORTIFY_SOURCE=y, memcpy() prevents writing or reading beyond
the boundaries of dest/src objects.

--
Gustavo

> FWIW, bulk memcpy() might be replaced by a single assembler instruction? Or am I thinking still
> in 6502 mode? :-)
> 
> Best regards,
> Mirsad Todorovac
> 
>> -- 
>> Gustavo
>>
>>> ---
>>>    arch/x86/include/asm/syscall.h | 7 ++++++-
>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
>>> index 2fc7bc3863ff..7c488ff0c764 100644
>>> --- a/arch/x86/include/asm/syscall.h
>>> +++ b/arch/x86/include/asm/syscall.h
>>> @@ -82,7 +82,12 @@ static inline void syscall_get_arguments(struct task_struct *task,
>>>                         struct pt_regs *regs,
>>>                         unsigned long *args)
>>>    {
>>> -    memcpy(args, &regs->bx, 6 * sizeof(args[0]));
>>> +    args[0] = regs->bx;
>>> +    args[1] = regs->cx;
>>> +    args[2] = regs->dx;
>>> +    args[3] = regs->si;
>>> +    args[4] = regs->di;
>>> +    args[5] = regs->bp;
>>>    }
>>>      static inline int syscall_get_arch(struct task_struct *task)
