Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DF03BBFA4
	for <linux-hardening@vger.kernel.org>; Wed,  5 Aug 2026 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923400; cv=none; b=HajEIA16HyNI609J9oFDYwgxy9oKjr9Pg5eep8eystnoQjw+1+v/ZnkXTFbhiVMt55ok/6ZoWJXQTvuxk3/NsR8KFsTbnSDUPswTHqBXiVxUdqOLMjiZnw9z8fGBNShKnQsnhOX/cGQydeFHhiC2hTkwOAZbjjkicKwP/EQ8nVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923400; c=relaxed/simple;
	bh=kdm9JLDkzfeR7QzsuL8awd/xo9HMEeVRB2f+mQA1wKM=;
	h=Message-Id:Content-Type:References:To:Cc:From:Subject:
	 Mime-Version:In-Reply-To:Date; b=DPtdpdTENZXTCOvWUM++Yd7DDeK6js/yAgmipbEED/cz4WgY6/nCJ2BHr2HxFw8aVsDG9wo6Kdg+4mu+A72t2d/KG5kHLONgxYLU04gb+zp6fCNgbsjGYwyutjgTEiMfgVh66j6/jxukaEcjbcG8HG+IC4RR4bzd+m8hnSkJ7DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PYAgZ2/H; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PYAgZ2/H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1785923385; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Y/uAgkm9aok/nQAEqWTWVKcO/AScdnJJ1CYyygt77ao=;
 b=PYAgZ2/HQh4Q1saWXhq0KR0656+tdCBoVMDhJraLD5O7zMihn+T0dYuts6xMyDpLaHWXNb
 UpckaM2KvSU4H7co0Nklqlm2K+JleBU7UP2szD6aR+pYMo3aKsRFDE2EH+IHGjCIywz6b0
 Px6zmZbfw62D/pdjfo3wqNtSfF7o0E0JLTt7oBEwVKLw0IUvtxcPUTgeDFHOG2naPSeuhT
 LRh4PNTAJ5HUUJcOganC9g5V0tP6LqTiooq8rtlYUwHdEP2NdDFCBT3LelJzIgkEFiWuzM
 zUFIz4wCVj65kzfeCODfM4L/VS7RA2CECWF5V04KdaUEvnug6OgOw4WpJBwM3A==
Message-Id: <7ce88e5a-8b96-4508-91b1-b72a589e6ac4@bytedance.com>
Content-Type: text/plain; charset=UTF-8
References: <20260803070929.86075-1-lizhe.67@bytedance.com> <20260803144014.e2d4ebb83e9471b695f6290d@linux-foundation.org>
To: "Andrew Morton" <akpm@linux-foundation.org>
Cc: <apopple@nvidia.com>, <arnd@arndb.de>, <balbirs@nvidia.com>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <mingo@redhat.com>, <muchun.song@linux.dev>, 
	<rppt@kernel.org>, <tglx@kernel.org>, <linux-arch@vger.kernel.org>, 
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <x86@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
Subject: Re: [PATCH v9 0/8] mm: optimize zone-device memmap initialization
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a730738+175c56+vger.kernel.org+lizhe.67@bytedance.com>
In-Reply-To: <20260803144014.e2d4ebb83e9471b695f6290d@linux-foundation.org>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Date: Wed, 5 Aug 2026 17:49:22 +0800
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: 7bit

On 8/4/26 5:40 AM, Andrew Morton wrote:
> On Mon,  3 Aug 2026 15:09:21 +0800 "Li Zhe" <lizhe.67@bytedance.com> wrote:
>
>> Test procedure:
>> Rebind the nd_pmem and dax_pmem drivers 30 times and collect the memmap
>> initialization time from the pr_debug() output of
>> memmap_init_zone_device().
>>
>> Base(v7.2-rc1):
>>    Average of nd_pmem rebinds: 244.28 ms
>>    Average of dax_pmem rebinds: 273.31 ms
>>
>> With this series applied:
>>    Average of nd_pmem rebinds: 96.79 ms
>>    Average of dax_pmem rebinds: 119.04 ms
>>
>> This reduces the average memmap initialization time measured during
>> rebind by about 60.4% for nd_pmem and 56.4% for dax_pmem.
> Well that's nice.
>
> Review is partial and it's late in the cycle so I'd prefer to schedule
> this for the next -rc cycle.
>
> AI review might have found a couple of things, please check?
> 	https://sashiko.dev/#/patchset/20260803070929.86075-1-lizhe.67@bytedance.com


Thanks.

I checked the Sashiko comments. The reported items are the same points
that were discussed in the previous v7/v8 reviews. v9 already folds the
related explanation into patch 7, so I do not plan any additional code
change for these items.

Thanks,
Zhe
