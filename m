Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09864C69;
	Fri, 19 Jul 2024 02:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721354769; cv=none; b=BERvD0Mge8fOUFPofeC2Vxh41QtX3paX9YnXjOi+etuaN1uBbf2K0oHnj+DicX1aBZPeBiuoNt9uqtpjzUHQhJt9HY4KtiL/Rtb8hNbPyN4rhTuYyhYs/HjGcqmd4BdOS/yZit62b5XMl019rxuEUN3ONxFL6rPcLoJKibEu9YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721354769; c=relaxed/simple;
	bh=NyYQW3CCCfI8QILGotGb5NsCyodRsMm2OhzYeSA9h7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MvBEteqQUT4yUgXt1wQaFh5Fifjfpbpzdu9Dnxy28WAV6ZWPHOAPFljTt/FPMgffk+OFbpU0KcCKzMVJy/duD/5XQsO3fudv99CvjrRDkuxQXcv6GVPgDaM0EKnrLUdPQkwQYfvMlnUAmqiezabcYg2TabhUXD9OWtEB/UbsxZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WQCZ93wFVzxTQZ;
	Fri, 19 Jul 2024 10:00:49 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 974A0180088;
	Fri, 19 Jul 2024 10:05:43 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 19 Jul 2024 10:05:42 +0800
Message-ID: <55f10902-566a-9460-9351-b14843adff4c@huawei.com>
Date: Fri, 19 Jul 2024 10:05:41 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] loongarch: Support RANDOMIZE_KSTACK_OFFSET
Content-Language: en-US
To: Huacai Chen <chenhuacai@kernel.org>
CC: <kernel@xen0n.name>, <kees@kernel.org>, <gustavoars@kernel.org>,
	<arnd@arndb.de>, <maobibo@loongson.cn>, <loongarch@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20240718124739.3834489-1-ruanjinjie@huawei.com>
 <CAAhV-H6e8RTU2avkLY7EqO_xJeRdSHm_VzHvTzmqezHQwMSr3g@mail.gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <CAAhV-H6e8RTU2avkLY7EqO_xJeRdSHm_VzHvTzmqezHQwMSr3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/7/19 9:22, Huacai Chen wrote:
> Hi, Jinjie,
> 
> Thank you for your patch, but I think it is better to use drdtime()
> instead of get_random_u16()? drdtime() is similar to rdtsc() of x86
> which is defined in arch/loongarch/include/asm/loongarch.h.

Thank you, you are right.

"DRDTIME" can access independent stable counter of the processor core
according to "Loongson Processor 3C5000L Register Instruction Manual",
which is similar to "RDTSC" in x86.

I'll update it in next version.

> 
> Huacai
> 
> On Thu, Jul 18, 2024 at 8:42 PM Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>
>> Add support of kernel stack offset randomization while handling syscall,
>> the offset is defaultly limited by KSTACK_OFFSET_MAX().
>>
>> In order to avoid trigger stack canaries (due to __builtin_alloca) and
>> slowing down the entry path, use __no_stack_protector attribute to
>> disable stack protector for do_syscall() at function level.
>>
>> With this patch, the REPORT_STACK test show that:
>>         `loongarch64 bits of stack entropy: 7`
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  arch/loongarch/Kconfig          |  1 +
>>  arch/loongarch/kernel/syscall.c | 16 +++++++++++++++-
>>  2 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index ddc042895d01..fcf6451b4e38 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -106,6 +106,7 @@ config LOONGARCH
>>         select HAVE_ARCH_KFENCE
>>         select HAVE_ARCH_KGDB if PERF_EVENTS
>>         select HAVE_ARCH_MMAP_RND_BITS if MMU
>> +       select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
>>         select HAVE_ARCH_SECCOMP
>>         select HAVE_ARCH_SECCOMP_FILTER
>>         select HAVE_ARCH_TRACEHOOK
>> diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/kernel/syscall.c
>> index ec17cd5163b7..a332c6cb76ec 100644
>> --- a/arch/loongarch/kernel/syscall.c
>> +++ b/arch/loongarch/kernel/syscall.c
>> @@ -9,6 +9,7 @@
>>  #include <linux/entry-common.h>
>>  #include <linux/errno.h>
>>  #include <linux/linkage.h>
>> +#include <linux/randomize_kstack.h>
>>  #include <linux/syscalls.h>
>>  #include <linux/unistd.h>
>>
>> @@ -39,7 +40,7 @@ void *sys_call_table[__NR_syscalls] = {
>>  typedef long (*sys_call_fn)(unsigned long, unsigned long,
>>         unsigned long, unsigned long, unsigned long, unsigned long);
>>
>> -void noinstr do_syscall(struct pt_regs *regs)
>> +__no_stack_protector void noinstr do_syscall(struct pt_regs *regs)
>>  {
>>         unsigned long nr;
>>         sys_call_fn syscall_fn;
>> @@ -55,11 +56,24 @@ void noinstr do_syscall(struct pt_regs *regs)
>>
>>         nr = syscall_enter_from_user_mode(regs, nr);
>>
>> +       add_random_kstack_offset();
>> +
>>         if (nr < NR_syscalls) {
>>                 syscall_fn = sys_call_table[nr];
>>                 regs->regs[4] = syscall_fn(regs->orig_a0, regs->regs[5], regs->regs[6],
>>                                            regs->regs[7], regs->regs[8], regs->regs[9]);
>>         }
>>
>> +       /*
>> +        * This value will get limited by KSTACK_OFFSET_MAX(), which is 10
>> +        * bits. The actual entropy will be further reduced by the compiler
>> +        * when applying stack alignment constraints: 16-byte (i.e. 4-bit)
>> +        * aligned, which will remove the 4 low bits from any entropy chosen
>> +        * here.
>> +        *
>> +        * The resulting 6 bits of entropy is seen in SP[9:4].
>> +        */
>> +       choose_random_kstack_offset(get_random_u16());
>> +
>>         syscall_exit_to_user_mode(regs);
>>  }
>> --
>> 2.34.1
>>
>>
