Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04F818E1D
	for <linux-hardening@vger.kernel.org>; Tue, 18 Jun 2024 07:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718694684; cv=none; b=sEu/d7nX1jKll3xL8qWsor/9jiboDqt8sA21nCrbGk1/PjbSB3FABBV3Pqqr0Ejzxnd66GYERyqqyMKSXbOARp73nBl2N7vsDvrVe/WSTm77bcocadEEpWk6Fbh+TCJyax38VwtbYFl9p++nYEZxr6xYKHyZ3yptqgdyNVajFO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718694684; c=relaxed/simple;
	bh=6Du1C8H+xCKiIZNmJ0Zxazc1ceMTeCOCgiJ139ClESM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sHhVpfd5HQ8w1v83XhZ1UoAMqZnAWAihyOiWRNWvZXgVxKMYLhGkd1wDgCtSEtdAxQfxw7YpbLOaURLgFao7ls31p6+u0HgG+UPUYLr/7mEQCYTEFArRVyvJwRPpa2Buo4h0EtWGcw+OJNK4OR++36EMDAth61XhlCeBS1ttSHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=jsg2ZZUl; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="jsg2ZZUl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1718694677;
	bh=BFiARyve/cwwiCokd3FFeipitCdA7bKv+f5EK9mBSXw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jsg2ZZUlUIoNzJQYu6xeRVXsF2wtWaIhCpwa3/aZhKakrqRW4ip/1kUUcJqrt8VKD
	 vsWjAtyXcoL6yIHwm0a6g2pQrZxeWsvU+sJ2x84O///50bENDDKu6JPlO7OjQaQbov
	 Dzq/zSC42ESrDchRKmjntkmwyxsC5wpIp9LqP7tYKdkDdVg4yOTLJe0RKQYlkzfqVA
	 NWU6AaLDpvlUcKt7YRQVTqUHcGmLd6PDzN6GiWw0TlSR5LTJOxnyEoTaXJJ7Cb6VlG
	 Rrls4XLE1KK+Fpm8NQmFdilQF37IwwHRURZmMo1al5sA49KjaYOXfRnkdXylgs4J5G
	 RWDE/6W22rx7w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4W3Hwj1gSNz4wx6;
	Tue, 18 Jun 2024 17:11:17 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kees Cook <kees@kernel.org>, Anjali K <anjalik@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com, naveen@kernel.org,
 christophe.leroy@csgroup.eu, gustavoars@kernel.org,
 linux-hardening@vger.kernel.org, vishalc@linux.ibm.com
Subject: Re: [PATCH] powerpc/pseries: Whitelist dtl slub object for copying
 to userspace
In-Reply-To: <202406171053.F72BF013@keescook>
References: <20240614173844.746818-1-anjalik@linux.ibm.com>
 <202406171053.F72BF013@keescook>
Date: Tue, 18 Jun 2024 17:11:15 +1000
Message-ID: <87cyoe67zg.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kees Cook <kees@kernel.org> writes:
> On Fri, Jun 14, 2024 at 11:08:44PM +0530, Anjali K wrote:
>> Reading the dispatch trace log from /sys/kernel/debug/powerpc/dtl/cpu-*
>> results in a BUG() when the config CONFIG_HARDENED_USERCOPY is enabled as
>> shown below.
>> 
>>     kernel BUG at mm/usercopy.c:102!
>>     Oops: Exception in kernel mode, sig: 5 [#1]
>>     LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
>>     Modules linked in: xfs libcrc32c dm_service_time sd_mod t10_pi sg ibmvfc
>>     scsi_transport_fc ibmveth pseries_wdt dm_multipath dm_mirror dm_region_hash dm_log dm_mod fuse
>>     CPU: 27 PID: 1815 Comm: python3 Not tainted 6.10.0-rc3 #85
>>     Hardware name: IBM,9040-MRX POWER10 (raw) 0x800200 0xf000006 of:IBM,FW1060.00 (NM1060_042) hv:phyp pSeries
>>     NIP:  c0000000005d23d4 LR: c0000000005d23d0 CTR: 00000000006ee6f8
>>     REGS: c000000120c078c0 TRAP: 0700   Not tainted  (6.10.0-rc3)
>>     MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 2828220f  XER: 0000000e
>>     CFAR: c0000000001fdc80 IRQMASK: 0
>>     [ ... GPRs omitted ... ]
>>     NIP [c0000000005d23d4] usercopy_abort+0x78/0xb0
>>     LR [c0000000005d23d0] usercopy_abort+0x74/0xb0
>>     Call Trace:
>>      usercopy_abort+0x74/0xb0 (unreliable)
>>      __check_heap_object+0xf8/0x120
>>      check_heap_object+0x218/0x240
>>      __check_object_size+0x84/0x1a4
>>      dtl_file_read+0x17c/0x2c4
>>      full_proxy_read+0x8c/0x110
>>      vfs_read+0xdc/0x3a0
>>      ksys_read+0x84/0x144
>>      system_call_exception+0x124/0x330
>>      system_call_vectored_common+0x15c/0x2ec
>>     --- interrupt: 3000 at 0x7fff81f3ab34
>> 
>> Commit 6d07d1cd300f ("usercopy: Restrict non-usercopy caches to size 0")
>> requires that only whitelisted areas in slab/slub objects can be copied to
>> userspace when usercopy hardening is enabled using CONFIG_HARDENED_USERCOPY.
>> Dtl contains hypervisor dispatch events which are expected to be read by
>> privileged users. Hence mark this safe for user access.
>> Specify useroffset=0 and usersize=DISPATCH_LOG_BYTES to whitelist the
>> entire object.
>> 
>> Co-developed-by: Vishal Chourasia <vishalc@linux.ibm.com>
>> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
>> Signed-off-by: Anjali K <anjalik@linux.ibm.com>
>> ---
>>  arch/powerpc/platforms/pseries/setup.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
>> index 284a6fa04b0c..cba40d9d1284 100644
>> --- a/arch/powerpc/platforms/pseries/setup.c
>> +++ b/arch/powerpc/platforms/pseries/setup.c
>> @@ -343,8 +343,8 @@ static int alloc_dispatch_log_kmem_cache(void)
>>  {
>>  	void (*ctor)(void *) = get_dtl_cache_ctor();
>>  
>> -	dtl_cache = kmem_cache_create("dtl", DISPATCH_LOG_BYTES,
>> -						DISPATCH_LOG_BYTES, 0, ctor);
>> +	dtl_cache = kmem_cache_create_usercopy("dtl", DISPATCH_LOG_BYTES,
>> +						DISPATCH_LOG_BYTES, 0, 0, DISPATCH_LOG_BYTES, ctor);
>>  	if (!dtl_cache) {
>>  		pr_warn("Failed to create dispatch trace log buffer cache\n");
>>  		pr_warn("Stolen time statistics will be unreliable\n");
>
> Are you sure you want to universally expose this memory region? It
> sounds like it's only exposed via a debug interface. Maybe it'd be
> better to use a bounce buffer in the debug interface instead?

I'm not sure what the threat is?

The log entries are written by the hypervisor, but never read.

That kmem_cache is only used to allocate the array of dtl_entry structs,
the ring buffer itself (struct dtl) is allocated statically. So
overwriting the dtl_entries can't corrupt the structure of the ring
buffer, just the content.

An attacker could read the entries and see some kernel pointers, but
those are everywhere.

So it seems pretty harmless.

I guess there isn't a kmem_cache_create_user_readonly() ?

> diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/pseries/dtl.c
> index 3f1cdccebc9c..3adcff5cc4b2 100644
> --- a/arch/powerpc/platforms/pseries/dtl.c
> +++ b/arch/powerpc/platforms/pseries/dtl.c
> @@ -257,6 +257,22 @@ static int dtl_file_release(struct inode *inode, struct file *filp)
>  	return 0;
>  }
>  
> +static inline int bounce_copy(char __user *buf, void *src, size_t size)
> +{
> +	u8 *bounce;
> +	int rc;
> +
> +	bounce = kmalloc(size, GFP_KERNEL);
> +	if (!bounce)
> +		return -ENOMEM;
> +
> +	memcpy(bounce, src, size);
> +	rc = copy_to_user(buf, bounce, size);
> +
> +	kfree(bounce);
> +	return rc;
> +}

Is there no generic version of that?

> @@ -300,7 +316,7 @@ static ssize_t dtl_file_read(struct file *filp, char __user *buf, size_t len,
>  	if (i + n_req > dtl->buf_entries) {
>  		read_size = dtl->buf_entries - i;
>  
> -		rc = copy_to_user(buf, &dtl->buf[i],
> +		rc = bounce_copy(buf, &dtl->buf[i],
>  				read_size * sizeof(struct dtl_entry));
>  		if (rc)
>  			return -EFAULT;
> @@ -312,7 +328,7 @@ static ssize_t dtl_file_read(struct file *filp, char __user *buf, size_t len,
>  	}
>  
>  	/* .. and now the head */
> -	rc = copy_to_user(buf, &dtl->buf[i], n_req * sizeof(struct dtl_entry));
> +	rc = bounce_copy(buf, &dtl->buf[i], n_req * sizeof(struct dtl_entry));
>  	if (rc)
>  		return -EFAULT;
>  
>

cheers
