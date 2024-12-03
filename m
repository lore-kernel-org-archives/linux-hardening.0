Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B34F1E570B
	for <linux-hardening@vger.kernel.org>; Tue,  3 Dec 2024 13:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233522; cv=none; b=O2RZj5PwHSJYD9IU8HeKSgp94zVdjr3p+AcwApXC8PPoI0bC533j5LCXD0vZTlnGUrgo23FDuv6Dd6z20j6Q/gONcjhLrOA0ltv7a9zMfwM2wHPkXWkvsZ5YuC6ytptvFTQhudZlwwGwcExP2jPGt/oqs+oUcSQq7Ekkna5fbqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233522; c=relaxed/simple;
	bh=i9HW0x8+bzxx3I51/K72EH53gCM/Yr4U8dDawlFOtUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WGyvxWhXc7d76WZ5NlVMQ30TdR+1tLHlqPWeiJIadRya3vYC6N1OG+6+ug5jEADWbf1MKvQ8gjxtoGC/tnsLJCguBa92WS0drVsMCh0K1njOrkN60+rcC/ObKHpCrbekQIYmCQYonofRrkVMAMdqooRHBhFS8N0QDv4MH+FAFTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Y2hg22kZvz2GcPC;
	Tue,  3 Dec 2024 21:42:54 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 20B4F1402CB;
	Tue,  3 Dec 2024 21:45:10 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Dec 2024 21:45:09 +0800
Message-ID: <76995749-1c2e-4f78-9aac-a4bff4b8097f@huawei.com>
Date: Tue, 3 Dec 2024 21:45:09 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] mm: usercopy: add a debugfs interface to bypass the
 vmalloc check.
To: Uladzislau Rezki <urezki@gmail.com>
CC: zuoze <zuoze1@huawei.com>, Matthew Wilcox <willy@infradead.org>,
	<gustavoars@kernel.org>, <akpm@linux-foundation.org>,
	<linux-hardening@vger.kernel.org>, <linux-mm@kvack.org>,
	<keescook@chromium.org>
References: <20241203023159.219355-1-zuoze1@huawei.com>
 <Z06FAoq59x07-hoN@casper.infradead.org>
 <57f9eca2-effc-3a9f-932b-fd37ae6d0f87@huawei.com> <Z077_8rNvTGrCb8L@pc636>
 <92768fc4-4fe0-f74a-d61c-dde0eb64e2c0@huawei.com>
 <dd3f0a9f-ec3c-46c3-8231-2022b67094a6@huawei.com> <Z08KAupLBo--JGz8@pc636>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <Z08KAupLBo--JGz8@pc636>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/12/3 21:39, Uladzislau Rezki wrote:
> On Tue, Dec 03, 2024 at 09:30:09PM +0800, Kefeng Wang wrote:
>>
>>
>> On 2024/12/3 21:10, zuoze wrote:
>>>
>>>
>>> 在 2024/12/3 20:39, Uladzislau Rezki 写道:
>>>> On Tue, Dec 03, 2024 at 07:23:44PM +0800, zuoze wrote:
>>>>> We have implemented host-guest communication based on the TUN device
>>>>> using XSK[1]. The hardware is a Kunpeng 920 machine (ARM architecture),
>>>>> and the operating system is based on the 6.6 LTS version with kernel
>>>>> version 6.6. The specific stack for hotspot collection is as follows:
>>>>>
>>>>> -  100.00%     0.00%  vhost-12384  [unknown]      [k] 0000000000000000
>>>>>      - ret_from_fork
>>>>>         - 99.99% vhost_task_fn
>>>>>            - 99.98% 0xffffdc59f619876c
>>>>>               - 98.99% handle_rx_kick
>>>>>                  - 98.94% handle_rx
>>>>>                     - 94.92% tun_recvmsg
>>>>>                        - 94.76% tun_do_read
>>>>>                           - 94.62% tun_put_user_xdp_zc
>>>>>                              - 63.53% __check_object_size
>>>>>                                 - 63.49% __check_object_size.part.0
>>>>>                                      find_vmap_area
>>>>>                              - 30.02% _copy_to_iter
>>>>>                                   __arch_copy_to_user
>>>>>                     - 2.27% get_rx_bufs
>>>>>                        - 2.12% vhost_get_vq_desc
>>>>>                             1.49% __arch_copy_from_user
>>>>>                     - 0.89% peek_head_len
>>>>>                          0.54% xsk_tx_peek_desc
>>>>>                     - 0.68% vhost_add_used_and_signal_n
>>>>>                        - 0.53% eventfd_signal
>>>>>                             eventfd_signal_mask
>>>>>               - 0.94% handle_tx_kick
>>>>>                  - 0.94% handle_tx
>>>>>                     - handle_tx_copy
>>>>>                        - 0.59% vhost_tx_batch.constprop.0
>>>>>                             0.52% tun_sendmsg
>>>>>
>>>>> It can be observed that most of the overhead is concentrated in the
>>>>> find_vmap_area function.
>>>>>
>>>> I see. Yes, it is pretty contented, since you run the v6.6 kernel. There
>>>> was a work that tends to improve it to mitigate a vmap lock contention.
>>>> See it here: https://lwn.net/Articles/956590/
>>>>
>>>> The work was taken in the v6.9 kernel:
>>>>
>>>> <snip>
>>>> commit 38f6b9af04c4b79f81b3c2a0f76d1de94b78d7bc
>>>> Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
>>>> Date:   Tue Jan 2 19:46:23 2024 +0100
>>>>
>>>>       mm: vmalloc: add va_alloc() helper
>>>>
>>>>       Patch series "Mitigate a vmap lock contention", v3.
>>>>
>>>>       1. Motivation
>>>> ...
>>>> <snip>
>>>>
>>>> Could you please try the v6.9 kernel on your setup?
>>>>
>>>> How to solve it, probably, it can be back-ported to the v6.6 kernel.
>>>
>>> All the vmalloc-related optimizations have already been merged into 6.6,
>>> including the set of optimization patches you suggested. Thank you very
>>> much for your input.
>>>
>>
>> It is unclear, we have backported the vmalloc optimization into our 6.6
>> kernel before, so the above stack already with those patches and even
>> with those optimization, the find_vmap_area() is still the hotpots.
>>
>>
> Could you please check that all below patches are in your v6.6 kernel?

Yes，

$ git lg v6.6..HEAD  --oneline mm/vmalloc.c
* 86fee542f145 mm: vmalloc: ensure vmap_block is initialised before 
adding to queue
* f459a0b59f7c mm/vmalloc: fix page mapping if vm_area_alloc_pages() 
with high order fallback to order 0
* 0be7a82c2555 mm: vmalloc: fix lockdep warning
* 58b99a00d0a0 mm/vmalloc: eliminated the lock contention from twice to once
* 2c549aa32fa0 mm: vmalloc: check if a hash-index is in cpu_possible_mask
* 0bc6d608b445 mm: fix incorrect vbq reference in purge_fragmented_block
* 450f8c5270df mm/vmalloc: fix vmalloc which may return null if called 
with __GFP_NOFAIL
* 2ea2bf4a18c3 mm: vmalloc: bail out early in find_vmap_area() if vmap 
is not init
* bde74a3e8a71 mm/vmalloc: fix return value of vb_alloc if size is 0
* 8c620d05b7c3 mm: vmalloc: refactor vmalloc_dump_obj() function
* b0c8281703b8 mm: vmalloc: improve description of vmap node layer
* ecc3f0bf5c5a mm: vmalloc: add a shrinker to drain vmap pools
* dd89a137f483 mm: vmalloc: set nr_nodes based on CPUs in a system
* 8e63c98d86f6 mm: vmalloc: support multiple nodes in vmallocinfo
* cc32683cef48 mm: vmalloc: support multiple nodes in vread_iter
* 54d5ce65633d mm: vmalloc: add a scan area of VA only once
* ee9c199fb859 mm: vmalloc: offload free_vmap_area_lock lock
* c2c272d78b5a mm: vmalloc: remove global purge_vmap_area_root rb-tree
* c9b39e3ffa86 mm/vmalloc: remove vmap_area_list
* 091d2493d15f mm: vmalloc: remove global vmap_area_root rb-tree
* 53f06cc34bac mm: vmalloc: move vmap_init_free_space() down in vmalloc.c
* bf24196d9ab9 mm: vmalloc: rename adjust_va_to_fit_type() function
* 6e9c94401e34 mm: vmalloc: add va_alloc() helper
* ae528eb14e9a mm: Introduce vmap_page_range() to map pages in PCI 
address space
* e1dbcfaa1854 mm: Introduce VM_SPARSE kind and vm_area_[un]map_pages().
* d3a24e7a01c4 mm: Enforce VM_IOREMAP flag and range in ioremap_page_range.
* fc9813220585 mm/vmalloc: fix the unchecked dereference warning in 
vread_iter()
* a52e0157837e ascend: export interfaces required by ascend drivers
* 9b1283f2bec2 mm/vmalloc: Extend vmalloc usage about hugepage
> 
> 
> <snip>
> commit 8be4d46e12af32342569840d958272dbb3be3f4c
> Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Date:   Wed Jan 24 19:09:20 2024 +0100
> 
>      mm: vmalloc: refactor vmalloc_dump_obj() function
> 
> commit 15e02a39fb6b43f37100563c6a246252d5d1e6da
> Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Date:   Wed Jan 24 19:09:19 2024 +0100
> 
>      mm: vmalloc: improve description of vmap node layer
> 
> commit 7679ba6b36dbb300b757b672d6a32a606499e14b
> Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Date:   Tue Jan 2 19:46:33 2024 +0100
> 
>      mm: vmalloc: add a shrinker to drain vmap pools
> 
> commit 8f33a2ff307248c3e55a7696f60b3658b28edb57
> Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Date:   Tue Jan 2 19:46:32 2024 +0100
> 
>      mm: vmalloc: set nr_nodes based on CPUs in a system
> 
> commit 8e1d743f2c2671aa54f6f91a2b33823f92512870
> Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Date:   Tue Jan 2 19:46:31 2024 +0100
> 
>      mm: vmalloc: support multiple nodes in vmallocinfo
> 
> commit 53becf32aec1c8049b854f0c31a11df5ed75df6f
> Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Date:   Tue Jan 2 19:46:30 2024 +0100
> 
>      mm: vmalloc: support multiple nodes in vread_iter
> 
> commit 96aa8437d169b8e030a98e2b74fd9a8ee9d3be7e
> Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Date:   Fri Feb 2 20:06:28 2024 +0100
> 
>      mm: vmalloc: add a scan area of VA only once
> 
> commit 72210662c5a2b6005f6daea7fe293a0dc573e1a5
> Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Date:   Tue Jan 2 19:46:29 2024 +0100
> 
>      mm: vmalloc: offload free_vmap_area_lock lock
> 
> commit 282631cb2447318e2a55b41a665dbe8571c46d70
> Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Date:   Tue Jan 2 19:46:28 2024 +0100
> 
>      mm: vmalloc: remove global purge_vmap_area_root rb-tree
> 
> commit 55c49fee57af99f3c663e69dedc5b85e691bbe50
> Author: Baoquan He <bhe@redhat.com>
> Date:   Tue Jan 2 19:46:27 2024 +0100
> 
>      mm/vmalloc: remove vmap_area_list
> 
> commit d093602919ad5908532142a048539800fa94a0d1
> Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Date:   Tue Jan 2 19:46:26 2024 +0100
> 
>      mm: vmalloc: remove global vmap_area_root rb-tree
> 
> commit 7fa8cee003166ef6db0bba70d610dbf173543811
> Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Date:   Tue Jan 2 19:46:25 2024 +0100
> 
>      mm: vmalloc: move vmap_init_free_space() down in vmalloc.c
> 
> 
> commit 5b75b8e1b9040b34f43809b1948eaa4e83e39112
> Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Date:   Tue Jan 2 19:46:24 2024 +0100
> 
>      mm: vmalloc: rename adjust_va_to_fit_type() function
> 
> 
> commit 38f6b9af04c4b79f81b3c2a0f76d1de94b78d7bc
> Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Date:   Tue Jan 2 19:46:23 2024 +0100
> 
>      mm: vmalloc: add va_alloc() helper
> <snip>
> 
> Thank you!
> 
> --
> Uladzislau Rezki

