Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCD41F4261
	for <linux-hardening@vger.kernel.org>; Tue,  3 Dec 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733235033; cv=none; b=qBsFvociw259XG1lkZNSYyD/+tGN2t/zQEC5b8eq/qBUbCiNFCy3quv2v72JX/u13snzJxC9cYkMVoB3gjQgwC5KsWOAa5AYIAMYcZkraY0udv0i9+WpttcgY20bL5XF9xfpdu1jB9p6i/fhxl4+Bb1FFzoM2th/N4qCl82l+f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733235033; c=relaxed/simple;
	bh=tqA3TSsbSQcOIi2KAkTfgJqNwDsqVcUZ522UJWaCDiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QIhG3NiRIW5Fiycd3CSIHcG4HxtqO1La7isOjCCNXQflxsalqGT4AE7OoRxfvxXmEOmtgfd6aC9MiTPsWE9yGNOv7FbxzBt2rIkzBKmPAmxl67/pLqeseteDnNkTWCwOD8ypt6jmHuUzqKMZthUpuHZfIAfrZGlZZsDRV40tA7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Y2jGh5pWRz1JDX1;
	Tue,  3 Dec 2024 22:10:20 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 731A314037F;
	Tue,  3 Dec 2024 22:10:27 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Dec 2024 22:10:26 +0800
Message-ID: <d659d925-a322-4566-955a-97894a2aa795@huawei.com>
Date: Tue, 3 Dec 2024 22:10:26 +0800
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
 <76995749-1c2e-4f78-9aac-a4bff4b8097f@huawei.com> <Z08M88NdLfugqhu9@pc636>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <Z08M88NdLfugqhu9@pc636>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/12/3 21:51, Uladzislau Rezki wrote:
> On Tue, Dec 03, 2024 at 09:45:09PM +0800, Kefeng Wang wrote:
>>
>>
>> On 2024/12/3 21:39, Uladzislau Rezki wrote:
>>> On Tue, Dec 03, 2024 at 09:30:09PM +0800, Kefeng Wang wrote:
>>>>
>>>>
>>>> On 2024/12/3 21:10, zuoze wrote:
>>>>>
>>>>>
>>>>> 在 2024/12/3 20:39, Uladzislau Rezki 写道:
>>>>>> On Tue, Dec 03, 2024 at 07:23:44PM +0800, zuoze wrote:
>>>>>>> We have implemented host-guest communication based on the TUN device
>>>>>>> using XSK[1]. The hardware is a Kunpeng 920 machine (ARM architecture),
>>>>>>> and the operating system is based on the 6.6 LTS version with kernel
>>>>>>> version 6.6. The specific stack for hotspot collection is as follows:
>>>>>>>
>>>>>>> -  100.00%     0.00%  vhost-12384  [unknown]      [k] 0000000000000000
>>>>>>>       - ret_from_fork
>>>>>>>          - 99.99% vhost_task_fn
>>>>>>>             - 99.98% 0xffffdc59f619876c
>>>>>>>                - 98.99% handle_rx_kick
>>>>>>>                   - 98.94% handle_rx
>>>>>>>                      - 94.92% tun_recvmsg
>>>>>>>                         - 94.76% tun_do_read
>>>>>>>                            - 94.62% tun_put_user_xdp_zc
>>>>>>>                               - 63.53% __check_object_size
>>>>>>>                                  - 63.49% __check_object_size.part.0
>>>>>>>                                       find_vmap_area
>>>>>>>                               - 30.02% _copy_to_iter
>>>>>>>                                    __arch_copy_to_user
>>>>>>>                      - 2.27% get_rx_bufs
>>>>>>>                         - 2.12% vhost_get_vq_desc
>>>>>>>                              1.49% __arch_copy_from_user
>>>>>>>                      - 0.89% peek_head_len
>>>>>>>                           0.54% xsk_tx_peek_desc
>>>>>>>                      - 0.68% vhost_add_used_and_signal_n
>>>>>>>                         - 0.53% eventfd_signal
>>>>>>>                              eventfd_signal_mask
>>>>>>>                - 0.94% handle_tx_kick
>>>>>>>                   - 0.94% handle_tx
>>>>>>>                      - handle_tx_copy
>>>>>>>                         - 0.59% vhost_tx_batch.constprop.0
>>>>>>>                              0.52% tun_sendmsg
>>>>>>>
>>>>>>> It can be observed that most of the overhead is concentrated in the
>>>>>>> find_vmap_area function.
>>>>>>>
...
>>
> Thank you. Then you have tons of copy_to_iter/copy_from_iter calls
> during your test case. Per each you need to find an area which might
> be really heavy.

Exactly, no vmalloc check before 0aef499f3172 （"mm/usercopy: Detect 
vmalloc overruns"), so no burden in find_vmap_area in old kernel.

> 
> How many CPUs in a system you have?
> 

128 core
