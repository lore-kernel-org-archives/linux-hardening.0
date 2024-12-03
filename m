Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAAB2E3EE
	for <linux-hardening@vger.kernel.org>; Tue,  3 Dec 2024 11:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733225032; cv=none; b=Ye/pSowHrEw4d96hNL0wjehP8onSbX4RLiS1p6APsM8RHDB/8J1HY7/3a+UNubAAhJSIQNiSW3c61/+gUbEC0hU/pC12v7RHrF0+aQXbD+9XJW2wZuZGmn//0wEDwuvWI88gCvDFL/9xlkV6ctWmhTx+4dSaBJzstEd5YBjZuzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733225032; c=relaxed/simple;
	bh=LUmaomtBOXT4T/HvvBP7Q5wwuJkzCGOMppBz7v3cyeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CO9FKEVEXIRuUtsorisu3m29fBx6jLB1J5AgFW9S8RnjFrgrfy1ehytJV/V7eubpjKcjhUcLp863h368sR3h2pm5NJqhDNtb4Fen/97Ev2+c0BiNi2OdDZQGQ8jNgPiDdFMDjy/c/tCstFj9VUNjkG+HEFOusyGD/i7bQ8Hv/hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Y2dWt0s6sz1T6LP;
	Tue,  3 Dec 2024 19:21:30 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B6091402CB;
	Tue,  3 Dec 2024 19:23:46 +0800 (CST)
Received: from [10.174.177.186] (10.174.177.186) by
 kwepemg500008.china.huawei.com (7.202.181.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Dec 2024 19:23:45 +0800
Message-ID: <57f9eca2-effc-3a9f-932b-fd37ae6d0f87@huawei.com>
Date: Tue, 3 Dec 2024 19:23:44 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH -next] mm: usercopy: add a debugfs interface to bypass the
 vmalloc check.
To: Matthew Wilcox <willy@infradead.org>
CC: <gustavoars@kernel.org>, <akpm@linux-foundation.org>,
	<linux-hardening@vger.kernel.org>, <linux-mm@kvack.org>,
	<keescook@chromium.org>, <urezki@gmail.com>, <wangkefeng.wang@huawei.com>
References: <20241203023159.219355-1-zuoze1@huawei.com>
 <Z06FAoq59x07-hoN@casper.infradead.org>
From: zuoze <zuoze1@huawei.com>
In-Reply-To: <Z06FAoq59x07-hoN@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg500008.china.huawei.com (7.202.181.45)

We have implemented host-guest communication based on the TUN device
using XSK[1]. The hardware is a Kunpeng 920 machine (ARM architecture),
and the operating system is based on the 6.6 LTS version with kernel
version 6.6. The specific stack for hotspot collection is as follows:

-  100.00%     0.00%  vhost-12384  [unknown]      [k] 0000000000000000
    - ret_from_fork
       - 99.99% vhost_task_fn
          - 99.98% 0xffffdc59f619876c
             - 98.99% handle_rx_kick
                - 98.94% handle_rx
                   - 94.92% tun_recvmsg
                      - 94.76% tun_do_read
                         - 94.62% tun_put_user_xdp_zc
                            - 63.53% __check_object_size
                               - 63.49% __check_object_size.part.0
                                    find_vmap_area
                            - 30.02% _copy_to_iter
                                 __arch_copy_to_user
                   - 2.27% get_rx_bufs
                      - 2.12% vhost_get_vq_desc
                           1.49% __arch_copy_from_user
                   - 0.89% peek_head_len
                        0.54% xsk_tx_peek_desc
                   - 0.68% vhost_add_used_and_signal_n
                      - 0.53% eventfd_signal
                           eventfd_signal_mask
             - 0.94% handle_tx_kick
                - 0.94% handle_tx
                   - handle_tx_copy
                      - 0.59% vhost_tx_batch.constprop.0
                           0.52% tun_sendmsg

It can be observed that most of the overhead is concentrated in the 
find_vmap_area function.

[1]: https://www.kernel.org/doc/html/latest/networking/af_xdp.html

在 2024/12/3 12:11, Matthew Wilcox 写道:
> On Tue, Dec 03, 2024 at 10:31:59AM +0800, Ze Zuo wrote:
>> The commit 0aef499f3172 ("mm/usercopy: Detect vmalloc overruns") introduced
>> vmalloc check for usercopy. However, in subsystems like networking, when
>> memory allocated using vmalloc or vmap is subsequently copied using
>> functions like copy_to_iter/copy_from_iter, the check is triggered. This
>> adds overhead in the copy path, such as the cost of searching the
>> red-black tree, which increases the performance burden.
>>
>> We found that after merging this patch, network bandwidth performance in
>> the XDP scenario significantly dropped from 25 Gbits/sec to 8 Gbits/sec,
>> the hardened_usercopy is enabled by default.
> 
> What is "the XDP scenario", exactly?  Are these large or small packets?
> What's taking the time in find_vmap_area()?  Is it lock contention?
> 
