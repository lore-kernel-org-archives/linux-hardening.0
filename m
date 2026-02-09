Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328983783C2;
	Mon,  9 Feb 2026 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770646300; cv=none; b=dagQjz0XtPYYh2y7I0CXwtzgnLQc7NTyO2XM5I4dNMMtij8eANhdi6gD7mXmUuEzkUs9bhzALrXSNYkiM3nKzebk4ewzpJQ00mveiXRhJHD8kIqa2bsv+63snDOa4u/pJLsPu2UZKDJJ13k8ceNkYF256CAnCTLctEDEoAmxbrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770646300; c=relaxed/simple;
	bh=pYQeRlToKVdnFEmZHq1dakoaVYFqd0G7wpJuDMKLjGk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=anwBYfgfS25HiIicbyBZ9+AninYSOXg5krZJGZ/6VTVDd0nv1iQcL9oRau9IdB+3AEoyuwKfOudNRCOLFePLkPVbMQV76h7s+k4UdBKhDEVrwmqYymgkAP1TgeF/2sw+DpmCZXR3Q6Ux5U2NfMLIXZ6y1pd26DCg5F+AvrjXO3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=lzxZT3+u; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="lzxZT3+u"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=aH91xLSmg33pp2gJzXKqb559lxedqqea4mhjrttOweE=;
	b=lzxZT3+uZNiQBf7G4BOKZ2HoE7l7gGXGZPFa+xNFivz2fjzxt3yDElwtYbNnTSb1Y+E6x0Tit
	MZaBgJVxsT+Dem3M2UQiq76YdppN6DLeqMcHwW0naVZU1g4+Wb2LStxzkh2Cauetgq2x0dkfiNV
	oDkAaHGUOcbQjKxZhIsP6EA=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4f8mjJ02dGzpSv1;
	Mon,  9 Feb 2026 22:07:16 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id C71E840567;
	Mon,  9 Feb 2026 22:11:35 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 9 Feb 2026 22:11:35 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <chleroy@kernel.org>, <andriy.shevchenko@intel.com>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<kees@kernel.org>, <andy@kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <lilinjie8@huawei.com>,
	<liaohua4@huawei.com>, <xieyuanbin1@huawei.com>
Subject: Re: [PATCH 2/2] powerpc/text-patching: Fix possible stringop-overread compilation error
Date: Mon, 9 Feb 2026 22:11:25 +0800
Message-ID: <20260209141131.7041-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <5cfae419-427a-471b-8bbe-645f56442e2c@kernel.org>
References: <5cfae419-427a-471b-8bbe-645f56442e2c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemj100009.china.huawei.com (7.202.194.3)

On Mon, 9 Feb 2026 14:41:51 +0100, Christophe Leroy (CS GROUP) wrote:
> Le 09/02/2026 à 14:25, Xie Yuanbin a écrit :
>> On Fri, 6 Feb 2026 20:53:55 +0100, Christophe Leroy (CS GROUP) wrote:
>>> ppc_kallsyms_lookup_name() only has two callers and they call it with a
>>> built-in string. I think we can do something a lot simpler, something
>>> like (untested):
>>>
>>> static inline unsigned long __ppc_kallsyms_lookup_name(const char *name)
>>> {
>>> 	unsigned long addr = kallsyms_lookup_name(name);
>>>
>>> 	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2) && addr)
>>> 		addr = ppc_function_entry((void *)addr);
>>>
>>> 	return addr;
>>> }
>>>
>>> #ifdef CONFIG_PPC64_ELF_ABI_V1
>>> #define ppc_kallsyms_lookup_name(x)	__ppc_kallsyms_lookup_name("." ## x);
>>> #else
>>> #define ppc_kallsyms_lookup_name(x)	__ppc_kallsyms_lookup_name(x)
>>> #endif
>>>
>>> Christophe
>>
>> When CONFIG_PPC64_ELF_ABI_V1=y, it seems that the try of lookupinp
>> the original non-dot symbol is missing.
>>
>> What about this (Only the compilation test is performed):
>> ```c
>> static inline unsigned long __ppc_kallsyms_lookup_name(const char *name)
>> {
>> 	unsigned long addr = kallsyms_lookup_name(name);
>>
>> 	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2) && addr)
>> 		addr = ppc_function_entry((void *)addr);
>>
>> 	return addr;
>> }
>>
>> #define ppc_kallsyms_lookup_name(x) ({					\
>> 		unsigned long addr = 0;					\
>> 		if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V1))		\
>> 			addr = __ppc_kallsyms_lookup_name("." x);	\
>> 		if (!addr)						\
>> 			addr = __ppc_kallsyms_lookup_name(x);		\
>> 		addr;							\
>> 	})
>> ```
>
> Good point.
>
> To avoid duplicating the string I'd suggest:
>
> static inline unsigned long __ppc_kallsyms_lookup_name(const char *name)
> {
> 	unsigned long addr = kallsyms_lookup_name(name);
>
> 	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V1) && !addr)
> 		addr = kallsyms_lookup_name(name + 1);
> 	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2) && addr)
> 		addr = ppc_function_entry((void *)addr);
>
> 	return addr;
> }
>
> #ifdef CONFIG_PPC64_ELF_ABI_V1
> #define ppc_kallsyms_lookup_name(x)	__ppc_kallsyms_lookup_name("." x);
> #else
> #define ppc_kallsyms_lookup_name(x)	__ppc_kallsyms_lookup_name(x)
> #endif

This seems good, but there seems to be an extra ';' after
'__ppc_kallsyms_lookup_name("." x)' ?

After removing the extra ';', I performed a compilation test,
no warnings.
