Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963F2378D77;
	Mon,  9 Feb 2026 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770643518; cv=none; b=j91yYdbSxjSV5/irSshm6AJVvqHZskn8lqb6/cMuxgOUbzPjxKv5J4RNC/wHw4i1cmvHO3dJZaZnDQSFD5uDURQKmHUrZY13GVo09oGN/7nGpp/u6VV8XMIWaeL3/uf1Qb9/xN4g5o4niru++SNn3FjOrqtEMtBJc9nlZOEcRAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770643518; c=relaxed/simple;
	bh=moYgjyLmOs5KKCRMA8KppwOMAyf7G1C9uxxTTxdKAZU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rSLrpv6PFPZA5Nw0CWR9kJhlyol6iF/kAi2okYekG1ws8cOz8olLxLiBRHSR6eF0NxDAUlY3NeHGG0GSaUlrbhrLni+JKfsD0Jpr9b4cm3khjfnFAu7KahzPXAqDJczkTQZuEajWVLFJojYb3GUC8Uk0DJHg17nNTNYYGY5XdKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FLZEIi8w; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FLZEIi8w"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JP4IbHsF/5YAbH5J94xCvyClExqMVG02cDoNWQwvPBQ=;
	b=FLZEIi8wDbq1RCgJ/4jdPYnzhY5Y09gbuel1W6qKZ8xZWUlTu8O9yb6QHzPK4lA6JKobB2+9n
	5ehZ+TITYJNmAH2ho7wCxuB92k7OX/Z++k7k+KxHhpi2gbsIwy/AgGTR6w5tzv7YoeduelL7Da+
	CYmv34HS43pkBShRogReoHw=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4f8lgd3BGyz1T4GQ;
	Mon,  9 Feb 2026 21:20:45 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 170CC4056A;
	Mon,  9 Feb 2026 21:25:15 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 9 Feb 2026 21:25:14 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <chleroy@kernel.org>, <andriy.shevchenko@intel.com>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<kees@kernel.org>, <andy@kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <lilinjie8@huawei.com>,
	<liaohua4@huawei.com>, <xieyuanbin1@huawei.com>
Subject: Re: [PATCH 2/2] powerpc/text-patching: Fix possible stringop-overread compilation error
Date: Mon, 9 Feb 2026 21:25:01 +0800
Message-ID: <20260209132510.84205-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <bca0abe3-5b8d-4493-a338-b41322e9e85d@kernel.org>
References: <bca0abe3-5b8d-4493-a338-b41322e9e85d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj100009.china.huawei.com (7.202.194.3)

On Fri, 6 Feb 2026 20:53:55 +0100, Christophe Leroy (CS GROUP) wrote:
> Le 06/02/2026 à 19:26, Kees Cook a écrit :
>>
>> Isn't it possible to do this and not need __compiletime_strlen at all?
>>
>> 	n_len = strnlen(name, min(__member_size(name), KSYM_NAME_LEN));
>
> ppc_kallsyms_lookup_name() only has two callers and they call it with a
> built-in string. I think we can do something a lot simpler, something
> like (untested):
>
> static inline unsigned long __ppc_kallsyms_lookup_name(const char *name)
> {
> 	unsigned long addr = kallsyms_lookup_name(name);
>
> 	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2) && addr)
> 		addr = ppc_function_entry((void *)addr);
>
> 	return addr;
> }
>
> #ifdef CONFIG_PPC64_ELF_ABI_V1
> #define ppc_kallsyms_lookup_name(x)	__ppc_kallsyms_lookup_name("." ## x);
> #else
> #define ppc_kallsyms_lookup_name(x)	__ppc_kallsyms_lookup_name(x)
> #endif
>
> Christophe

When CONFIG_PPC64_ELF_ABI_V1=y, it seems that the try of lookupinp
the original non-dot symbol is missing.

What about this (Only the compilation test is performed):
```c
static inline unsigned long __ppc_kallsyms_lookup_name(const char *name)
{
	unsigned long addr = kallsyms_lookup_name(name);

	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2) && addr)
		addr = ppc_function_entry((void *)addr);

	return addr;
}

#define ppc_kallsyms_lookup_name(x) ({					\
		unsigned long addr = 0;					\
		if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V1))		\
			addr = __ppc_kallsyms_lookup_name("." x);	\
		if (!addr)						\
			addr = __ppc_kallsyms_lookup_name(x);		\
		addr;							\
	})
```
