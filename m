Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA21C523A
	for <linux-hardening@vger.kernel.org>; Wed,  4 Dec 2024 01:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733275305; cv=none; b=GgFDOnJvhBxifCrDaQ0J4Vx/ce82ZKAP28etQ4B0sM057FTm/93coejRWQm+asfoLREv9+SifR4zsYqJwJx61rXhaJMVTRvfwGRqw/B3wsIKJGdyecp1nfCfopGZOSd8GYtAKbEYnvNOPNEhcwmPja2EZ+0jdSeuB3hVcdkek8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733275305; c=relaxed/simple;
	bh=9Q0qNEluDZe3E2Pvk3KUcyxz06t4JGOQVnxE8Us6IeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fAcW9AhdExT0u9VNuzsx3E7RWwg0xvsf5rYOGfOyn9/vt4GxAU3tybU9Nl9oW1UU1GZs+o582NPcHsaRIy+5LCLNIhY3Fp6Fzih4eEANxwwzGQCCXU/hEfiNZIvjxyzvY8E/Zo7Q8litWUKGIP4gVNjiKg40WfP3UG17ILzo/DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Y305w1MD9z1V5TY;
	Wed,  4 Dec 2024 09:18:44 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C2B71800A2;
	Wed,  4 Dec 2024 09:21:40 +0800 (CST)
Received: from [10.174.177.186] (10.174.177.186) by
 kwepemg500008.china.huawei.com (7.202.181.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Dec 2024 09:21:39 +0800
Message-ID: <df576430-8ead-67f5-44c1-f65ae2843886@huawei.com>
Date: Wed, 4 Dec 2024 09:21:38 +0800
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
To: Uladzislau Rezki <urezki@gmail.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>
CC: Matthew Wilcox <willy@infradead.org>, <gustavoars@kernel.org>,
	<akpm@linux-foundation.org>, <linux-hardening@vger.kernel.org>,
	<linux-mm@kvack.org>, <keescook@chromium.org>
References: <Z06FAoq59x07-hoN@casper.infradead.org>
 <57f9eca2-effc-3a9f-932b-fd37ae6d0f87@huawei.com> <Z077_8rNvTGrCb8L@pc636>
 <92768fc4-4fe0-f74a-d61c-dde0eb64e2c0@huawei.com>
 <dd3f0a9f-ec3c-46c3-8231-2022b67094a6@huawei.com> <Z08KAupLBo--JGz8@pc636>
 <76995749-1c2e-4f78-9aac-a4bff4b8097f@huawei.com> <Z08M88NdLfugqhu9@pc636>
 <d659d925-a322-4566-955a-97894a2aa795@huawei.com> <Z08TlFqWVWs47g9z@pc636>
 <Z09VwuhfQbbro-gA@pc638.lan>
From: zuoze <zuoze1@huawei.com>
In-Reply-To: <Z09VwuhfQbbro-gA@pc638.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg500008.china.huawei.com (7.202.181.45)



在 2024/12/4 3:02, Uladzislau Rezki 写道:
> On Tue, Dec 03, 2024 at 03:20:04PM +0100, Uladzislau Rezki wrote:
>> On Tue, Dec 03, 2024 at 10:10:26PM +0800, Kefeng Wang wrote:
>>>
>>>
>>> On 2024/12/3 21:51, Uladzislau Rezki wrote:
>>>> On Tue, Dec 03, 2024 at 09:45:09PM +0800, Kefeng Wang wrote:
>>>>>
>>>>>
>>>>> On 2024/12/3 21:39, Uladzislau Rezki wrote:
>>>>>> On Tue, Dec 03, 2024 at 09:30:09PM +0800, Kefeng Wang wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2024/12/3 21:10, zuoze wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> 在 2024/12/3 20:39, Uladzislau Rezki 写道:
>>>>>>>>> On Tue, Dec 03, 2024 at 07:23:44PM +0800, zuoze wrote:
>>>>>>>>>> We have implemented host-guest communication based on the TUN device
>>>>>>>>>> using XSK[1]. The hardware is a Kunpeng 920 machine (ARM architecture),
>>>>>>>>>> and the operating system is based on the 6.6 LTS version with kernel
>>>>>>>>>> version 6.6. The specific stack for hotspot collection is as follows:
>>>>>>>>>>
>>>>>>>>>> -  100.00%     0.00%  vhost-12384  [unknown]      [k] 0000000000000000
>>>>>>>>>>        - ret_from_fork
>>>>>>>>>>           - 99.99% vhost_task_fn
>>>>>>>>>>              - 99.98% 0xffffdc59f619876c
>>>>>>>>>>                 - 98.99% handle_rx_kick
>>>>>>>>>>                    - 98.94% handle_rx
>>>>>>>>>>                       - 94.92% tun_recvmsg
>>>>>>>>>>                          - 94.76% tun_do_read
>>>>>>>>>>                             - 94.62% tun_put_user_xdp_zc
>>>>>>>>>>                                - 63.53% __check_object_size
>>>>>>>>>>                                   - 63.49% __check_object_size.part.0
>>>>>>>>>>                                        find_vmap_area
>>>>>>>>>>                                - 30.02% _copy_to_iter
>>>>>>>>>>                                     __arch_copy_to_user
>>>>>>>>>>                       - 2.27% get_rx_bufs
>>>>>>>>>>                          - 2.12% vhost_get_vq_desc
>>>>>>>>>>                               1.49% __arch_copy_from_user
>>>>>>>>>>                       - 0.89% peek_head_len
>>>>>>>>>>                            0.54% xsk_tx_peek_desc
>>>>>>>>>>                       - 0.68% vhost_add_used_and_signal_n
>>>>>>>>>>                          - 0.53% eventfd_signal
>>>>>>>>>>                               eventfd_signal_mask
>>>>>>>>>>                 - 0.94% handle_tx_kick
>>>>>>>>>>                    - 0.94% handle_tx
>>>>>>>>>>                       - handle_tx_copy
>>>>>>>>>>                          - 0.59% vhost_tx_batch.constprop.0
>>>>>>>>>>                               0.52% tun_sendmsg
>>>>>>>>>>
>>>>>>>>>> It can be observed that most of the overhead is concentrated in the
>>>>>>>>>> find_vmap_area function.
>>>>>>>>>>
>>> ...
>>>>>
>>>> Thank you. Then you have tons of copy_to_iter/copy_from_iter calls
>>>> during your test case. Per each you need to find an area which might
>>>> be really heavy.
>>>
>>> Exactly, no vmalloc check before 0aef499f3172 （"mm/usercopy: Detect vmalloc
>>> overruns"), so no burden in find_vmap_area in old kernel.
>>>
>> Yep. It will slow down for sure.
>>
>>>>
>>>> How many CPUs in a system you have?
>>>>
>>>
>>> 128 core
>> OK. Just in case, do you see in a boot log something like:
>>
>> "Failed to allocate an array. Disable a node layer"
>>
> And if you do not see such failing message, it means that a node layer
> is up and running fully, can you also test below patch on your workload?

We did not see such failing message. As for the test patch you
suggested, we will test it and check the results. Thank you very much.

> 
> <snip>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 634162271c00..35b28be27cf4 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -896,7 +896,7 @@ static struct vmap_node {
>    * is fully disabled. Later on, after vmap is initialized these
>    * parameters are updated based on a system capacity.
>    */
> -static struct vmap_node *vmap_nodes = &single;
> +static struct vmap_node **vmap_nodes;
>   static __read_mostly unsigned int nr_vmap_nodes = 1;
>   static __read_mostly unsigned int vmap_zone_size = 1;
>   
> @@ -909,13 +909,13 @@ addr_to_node_id(unsigned long addr)
>   static inline struct vmap_node *
>   addr_to_node(unsigned long addr)
>   {
> -	return &vmap_nodes[addr_to_node_id(addr)];
> +	return vmap_nodes[addr_to_node_id(addr)];
>   }
>   
>   static inline struct vmap_node *
>   id_to_node(unsigned int id)
>   {
> -	return &vmap_nodes[id % nr_vmap_nodes];
> +	return vmap_nodes[id % nr_vmap_nodes];
>   }
>   
>   /*
> @@ -1060,7 +1060,7 @@ find_vmap_area_exceed_addr_lock(unsigned long addr, struct vmap_area **va)
>   
>   repeat:
>   	for (i = 0, va_start_lowest = 0; i < nr_vmap_nodes; i++) {
> -		vn = &vmap_nodes[i];
> +		vn = vmap_nodes[i];
>   
>   		spin_lock(&vn->busy.lock);
>   		*va = __find_vmap_area_exceed_addr(addr, &vn->busy.root);
> @@ -2240,7 +2240,7 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end,
>   	purge_nodes = CPU_MASK_NONE;
>   
>   	for (i = 0; i < nr_vmap_nodes; i++) {
> -		vn = &vmap_nodes[i];
> +		vn = vmap_nodes[i];
>   
>   		INIT_LIST_HEAD(&vn->purge_list);
>   		vn->skip_populate = full_pool_decay;
> @@ -2272,7 +2272,7 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end,
>   		nr_purge_helpers = clamp(nr_purge_helpers, 1U, nr_purge_nodes) - 1;
>   
>   		for_each_cpu(i, &purge_nodes) {
> -			vn = &vmap_nodes[i];
> +			vn = vmap_nodes[i];
>   
>   			if (nr_purge_helpers > 0) {
>   				INIT_WORK(&vn->purge_work, purge_vmap_node);
> @@ -2291,7 +2291,7 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end,
>   		}
>   
>   		for_each_cpu(i, &purge_nodes) {
> -			vn = &vmap_nodes[i];
> +			vn = vmap_nodes[i];
>   
>   			if (vn->purge_work.func) {
>   				flush_work(&vn->purge_work);
> @@ -2397,7 +2397,7 @@ struct vmap_area *find_vmap_area(unsigned long addr)
>   	 */
>   	i = j = addr_to_node_id(addr);
>   	do {
> -		vn = &vmap_nodes[i];
> +		vn = vmap_nodes[i];
>   
>   		spin_lock(&vn->busy.lock);
>   		va = __find_vmap_area(addr, &vn->busy.root);
> @@ -2421,7 +2421,7 @@ static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
>   	 */
>   	i = j = addr_to_node_id(addr);
>   	do {
> -		vn = &vmap_nodes[i];
> +		vn = vmap_nodes[i];
>   
>   		spin_lock(&vn->busy.lock);
>   		va = __find_vmap_area(addr, &vn->busy.root);
> @@ -4928,7 +4928,7 @@ static void show_purge_info(struct seq_file *m)
>   	int i;
>   
>   	for (i = 0; i < nr_vmap_nodes; i++) {
> -		vn = &vmap_nodes[i];
> +		vn = vmap_nodes[i];
>   
>   		spin_lock(&vn->lazy.lock);
>   		list_for_each_entry(va, &vn->lazy.head, list) {
> @@ -4948,7 +4948,7 @@ static int vmalloc_info_show(struct seq_file *m, void *p)
>   	int i;
>   
>   	for (i = 0; i < nr_vmap_nodes; i++) {
> -		vn = &vmap_nodes[i];
> +		vn = vmap_nodes[i];
>   
>   		spin_lock(&vn->busy.lock);
>   		list_for_each_entry(va, &vn->busy.head, list) {
> @@ -5069,6 +5069,7 @@ static void __init vmap_init_free_space(void)
>   
>   static void vmap_init_nodes(void)
>   {
> +	struct vmap_node **nodes;
>   	struct vmap_node *vn;
>   	int i, n;
>   
> @@ -5087,23 +5088,34 @@ static void vmap_init_nodes(void)
>   	 * set of cores. Therefore a per-domain purging is supposed to
>   	 * be added as well as a per-domain balancing.
>   	 */
> -	n = clamp_t(unsigned int, num_possible_cpus(), 1, 128);
> +	n = 1024;
>   
>   	if (n > 1) {
> -		vn = kmalloc_array(n, sizeof(*vn), GFP_NOWAIT | __GFP_NOWARN);
> -		if (vn) {
> +		nodes = kmalloc_array(n, sizeof(struct vmap_node **),
> +			GFP_NOWAIT | __GFP_NOWARN | __GFP_ZERO);
> +
> +		if (nodes) {
> +			for (i = 0; i < n; i++) {
> +				nodes[i] = kmalloc(sizeof(struct vmap_node), GFP_NOWAIT | __GFP_ZERO);
> +
> +				if (!nodes[i])
> +					break;
> +			}
> +
>   			/* Node partition is 16 pages. */
>   			vmap_zone_size = (1 << 4) * PAGE_SIZE;
> -			nr_vmap_nodes = n;
> -			vmap_nodes = vn;
> +			nr_vmap_nodes = i;
> +			vmap_nodes = nodes;
>   		} else {
>   			pr_err("Failed to allocate an array. Disable a node layer\n");
> +			vmap_nodes[0] = &single;
> +			nr_vmap_nodes = 1;
>   		}
>   	}
>   #endif
>   
>   	for (n = 0; n < nr_vmap_nodes; n++) {
> -		vn = &vmap_nodes[n];
> +		vn = vmap_nodes[n];
>   		vn->busy.root = RB_ROOT;
>   		INIT_LIST_HEAD(&vn->busy.head);
>   		spin_lock_init(&vn->busy.lock);
> @@ -5129,7 +5141,7 @@ vmap_node_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
>   	int i, j;
>   
>   	for (count = 0, i = 0; i < nr_vmap_nodes; i++) {
> -		vn = &vmap_nodes[i];
> +		vn = vmap_nodes[i];
>   
>   		for (j = 0; j < MAX_VA_SIZE_PAGES; j++)
>   			count += READ_ONCE(vn->pool[j].len);
> @@ -5144,7 +5156,7 @@ vmap_node_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>   	int i;
>   
>   	for (i = 0; i < nr_vmap_nodes; i++)
> -		decay_va_pool_node(&vmap_nodes[i], true);
> +		decay_va_pool_node(vmap_nodes[i], true);
>   
>   	return SHRINK_STOP;
>   }
> <snip>
> 
> it sets a number of nodes to 1024. It would be really appreciated to see
> the perf-delta with this patch. If it improves the things or not.
> 
> Thank you in advance.
> 
> --
> Uladzislau Rezki
> 
