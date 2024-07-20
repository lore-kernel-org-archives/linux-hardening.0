Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7DF7E1;
	Sat, 20 Jul 2024 02:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721443939; cv=none; b=SFz2ZSH8V063y5zQjiWGVvizIhOdLQDmm4OY5IYeGbXi9p6ZgpyfF1vUWM5DYXB6DIF888UoIWOkq7uHB65kVpt9BZlvFVBBucj5m/vJD1qRsnWdKbWCllbqQeyzuZqLmDrrUoxJ4VKI+X++twknUSqgpP/mCxUvZN3lLOTuMTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721443939; c=relaxed/simple;
	bh=rXWQ+aYhcvCvsxoqQktWoi6QYVfimbAyisHo0NWeYk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PYklG3Bddza5C/PwHSdSrAux9h/UfzhDwAKbNT3bkdifhDKtkm0JqctysyYnWwNs8hmALtjJjgbKCcuGqqbpKVooGcDd/MFWuWJdZGyCfEyG16DufI2B0HHpYyTeI15qWvsQdU457zqEDxhxWSLOjakLBcnTe3a3a2hO08ydWUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WQrYQ30XvzyN2x;
	Sat, 20 Jul 2024 10:47:22 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 38353140121;
	Sat, 20 Jul 2024 10:52:08 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 20 Jul 2024 10:52:07 +0800
Message-ID: <a654c7e2-929c-cbeb-cfd5-b8bbb00845d2@huawei.com>
Date: Sat, 20 Jul 2024 10:52:06 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] loongarch: Support RANDOMIZE_KSTACK_OFFSET
Content-Language: en-US
To: Kees Cook <kees@kernel.org>
CC: <chenhuacai@kernel.org>, <kernel@xen0n.name>, <gustavoars@kernel.org>,
	<arnd@arndb.de>, <maobibo@loongson.cn>, <loongarch@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20240719031427.119274-1-ruanjinjie@huawei.com>
 <202407190858.3097E9AF98@keescook>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <202407190858.3097E9AF98@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/7/20 0:01, Kees Cook wrote:
> On Fri, Jul 19, 2024 at 11:14:27AM +0800, Jinjie Ruan wrote:
>> Add support of kernel stack offset randomization while handling syscall,
>> the offset is defaultly limited by KSTACK_OFFSET_MAX().
>>
>> In order to avoid trigger stack canaries (due to __builtin_alloca) and
>> slowing down the entry path, use __no_stack_protector attribute to
>> disable stack protector for do_syscall() at function level.
>>
>> With this patch, the REPORT_STACK test show that:
>> 	`loongarch64 bits of stack entropy: 7`
> 
> I suspect this will report the correct "6" after now that this commit
> has landed:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=872bb37f6829d4f7f3ed5afe2786add3d4384b4b

Hi, Kees

I noticed your patch, and I reconfirm that I have updated to the latest
mainline and that your patch is in the code.

However，the following REPORT_STACK test of your below script has the
same result (run multiple times).

And riscv64, arm64, x86 also has the 7 bit  of stack entropy.

for i in $(seq 1 1000); do
	echo "REPORT_STACK" >/sys/kernel/debug/provoke-crash/DIRECT
done
offsets=$(dmesg | grep 'Stack offset' | cut -d: -f3 | sort | uniq -c |
sort -n | wc -l)
echo "$(uname -m) bits of stack entropy: $(echo "obase=2; $offsets" | bc
| wc -L)"

> 
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> Suggested-by: Huacai Chen <chenhuacai@kernel.org>
> 
> Thanks for adding this and getting it tested!
> 
> Reviewed-by: Kees Cook <kees@kernel.org>
> 
