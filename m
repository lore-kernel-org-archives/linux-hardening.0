Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544271E570E
	for <linux-hardening@vger.kernel.org>; Tue,  3 Dec 2024 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733232616; cv=none; b=klmK0b7E4ZaATwo2Z8QzfVRA58JNH8DhVSZI6CAb3a6hfIoOcQ3pWhc+sssnF7HfXo0b3a4EX2aS6a1Z4L6VlTNUfRWP66dv+wZfttOjyUc7eU+vjTVRhcsT2l9tgGuexk5VwJTNWsBupPqqoaLyMYr20rzlWi3Q8EJfMjJtHdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733232616; c=relaxed/simple;
	bh=uoPd73DyXENEN1depzz7qcznAGV14IM6pY/R7oMUTEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E9OPJ3L3Ztd79ksz1OZoz6W4RoP73C7EsMsxdK1xNrJd5uw0DSOFjUmNMBdUJ0CxGxJY+sMNvaNeXfzVOIFmx+AFP16ircHjlVgwA0UkIl+dZwdTJns2iNCi/k0p7mSndrqxYRssn4ZJwusiDqGi7aQbUL4MNsvbyv6NDn+0GHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Y2hNC67SHz1JD6m;
	Tue,  3 Dec 2024 21:30:03 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 771F11A0188;
	Tue,  3 Dec 2024 21:30:10 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Dec 2024 21:30:09 +0800
Message-ID: <dd3f0a9f-ec3c-46c3-8231-2022b67094a6@huawei.com>
Date: Tue, 3 Dec 2024 21:30:09 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] mm: usercopy: add a debugfs interface to bypass the
 vmalloc check.
To: zuoze <zuoze1@huawei.com>, Uladzislau Rezki <urezki@gmail.com>
CC: Matthew Wilcox <willy@infradead.org>, <gustavoars@kernel.org>,
	<akpm@linux-foundation.org>, <linux-hardening@vger.kernel.org>,
	<linux-mm@kvack.org>, <keescook@chromium.org>
References: <20241203023159.219355-1-zuoze1@huawei.com>
 <Z06FAoq59x07-hoN@casper.infradead.org>
 <57f9eca2-effc-3a9f-932b-fd37ae6d0f87@huawei.com> <Z077_8rNvTGrCb8L@pc636>
 <92768fc4-4fe0-f74a-d61c-dde0eb64e2c0@huawei.com>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <92768fc4-4fe0-f74a-d61c-dde0eb64e2c0@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/12/3 21:10, zuoze wrote:
> 
> 
> 在 2024/12/3 20:39, Uladzislau Rezki 写道:
>> On Tue, Dec 03, 2024 at 07:23:44PM +0800, zuoze wrote:
>>> We have implemented host-guest communication based on the TUN device
>>> using XSK[1]. The hardware is a Kunpeng 920 machine (ARM architecture),
>>> and the operating system is based on the 6.6 LTS version with kernel
>>> version 6.6. The specific stack for hotspot collection is as follows:
>>>
>>> -  100.00%     0.00%  vhost-12384  [unknown]      [k] 0000000000000000
>>>     - ret_from_fork
>>>        - 99.99% vhost_task_fn
>>>           - 99.98% 0xffffdc59f619876c
>>>              - 98.99% handle_rx_kick
>>>                 - 98.94% handle_rx
>>>                    - 94.92% tun_recvmsg
>>>                       - 94.76% tun_do_read
>>>                          - 94.62% tun_put_user_xdp_zc
>>>                             - 63.53% __check_object_size
>>>                                - 63.49% __check_object_size.part.0
>>>                                     find_vmap_area
>>>                             - 30.02% _copy_to_iter
>>>                                  __arch_copy_to_user
>>>                    - 2.27% get_rx_bufs
>>>                       - 2.12% vhost_get_vq_desc
>>>                            1.49% __arch_copy_from_user
>>>                    - 0.89% peek_head_len
>>>                         0.54% xsk_tx_peek_desc
>>>                    - 0.68% vhost_add_used_and_signal_n
>>>                       - 0.53% eventfd_signal
>>>                            eventfd_signal_mask
>>>              - 0.94% handle_tx_kick
>>>                 - 0.94% handle_tx
>>>                    - handle_tx_copy
>>>                       - 0.59% vhost_tx_batch.constprop.0
>>>                            0.52% tun_sendmsg
>>>
>>> It can be observed that most of the overhead is concentrated in the
>>> find_vmap_area function.
>>>
>> I see. Yes, it is pretty contented, since you run the v6.6 kernel. There
>> was a work that tends to improve it to mitigate a vmap lock contention.
>> See it here: https://lwn.net/Articles/956590/
>>
>> The work was taken in the v6.9 kernel:
>>
>> <snip>
>> commit 38f6b9af04c4b79f81b3c2a0f76d1de94b78d7bc
>> Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
>> Date:   Tue Jan 2 19:46:23 2024 +0100
>>
>>      mm: vmalloc: add va_alloc() helper
>>
>>      Patch series "Mitigate a vmap lock contention", v3.
>>
>>      1. Motivation
>> ...
>> <snip>
>>
>> Could you please try the v6.9 kernel on your setup?
>>
>> How to solve it, probably, it can be back-ported to the v6.6 kernel.
> 
> All the vmalloc-related optimizations have already been merged into 6.6,
> including the set of optimization patches you suggested. Thank you very
> much for your input.
> 

It is unclear, we have backported the vmalloc optimization into our 6.6
kernel before, so the above stack already with those patches and even
with those optimization, the find_vmap_area() is still the hotpots.


