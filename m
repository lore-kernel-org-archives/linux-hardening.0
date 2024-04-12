Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1393A14C593;
	Fri, 12 Apr 2024 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943034; cv=none; b=V7qHexrnaclAaYN3433gCIG2AxS/hV+2UhiVspm6e8+EgZCjtOG0n53pOu3ZyYUkt+SpV/6furg4tFRPP/dAaPA3ZngVrh8tGXTCZ8TdjdQmIqG+eEloncmBSUCmDiIDHAALDrLTxp6483DCaMmoDNSvGTPKdl6mDWEeqanC/PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943034; c=relaxed/simple;
	bh=Kq4lrOrNh1hYJL8fRJfQOOuOPnNOpM61pSMoxRf+tBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZaXu34zOlRFQdhtxUI/d4f/WwWC4mSyWkt0k/wpbsYYbFI+HbXnUM+zZQRiCd/ssCo25cMLpDFaJuaA9FjviZPHYLAHMKdfue+ozY6gyhdQIVYXLelYGq/E7AyPi33tnG28DvHbKCizyE8U2imOUrHycJVmAXdUyP9JXJHQRmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642CAC113CC;
	Fri, 12 Apr 2024 17:30:30 +0000 (UTC)
Date: Fri, 12 Apr 2024 18:30:27 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yaxiong Tian <13327272236@163.com>
Cc: will@kernel.org, keescook@chromium.org, tianyaxiong@kylinos.cn,
	xiongxin@kylinos.cn, rppt@kernel.org, tony.luck@intel.com,
	gpiccoli@igalia.com, songshuaishuai@tinylab.org,
	wangkefeng.wang@huawei.com, akpm@linux-foundation.org,
	ardb@kernel.org, david@redhat.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] arm64: hibernate: Fix level3 translation fault in
 swsusp_save()
Message-ID: <Zhlvs2ol7Va1r1Mr@arm.com>
References: <ZeBRfxQ8WTEVzpfL@kernel.org>
 <20240301021924.33210-1-13327272236@163.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240301021924.33210-1-13327272236@163.com>

For some reason I missed the updated patch.

On Fri, Mar 01, 2024 at 10:19:24AM +0800, Yaxiong Tian wrote:
> From: Yaxiong Tian <tianyaxiong@kylinos.cn>
> 
> On ARM64 machines using UEFI, if can_set_direct_map() return false by
> setting some CONFIGS in kernel build or grub,such as
> NO CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT、NO CONFIG_KFENCE
> NO CONFIG_RODATA_FULL_DEFAULT_ENABLED.Also with setting rodata=off、
> debug_pagealloc=off in grub and NO CONFIG_KFENCE.
> swsusp_save() will fail due to can't finding the map table under the 
> nomap memory.such as:
[...]
> [   48.532162] Call trace:
> [   48.532162]  swsusp_save+0x280/0x538
> [   48.532162]  swsusp_arch_suspend+0x148/0x190
> [   48.532162]  hibernation_snapshot+0x240/0x39c
> [   48.532162]  hibernate+0xc4/0x378
> [   48.532162]  state_store+0xf0/0x10c
> [   48.532162]  kobj_attr_store+0x14/0x24
> 
> This issue can be reproduced in QEMU using UEFI when booting with 
> rodata=off、debug_pagealloc=off in grub and NO CONFIG_KFENCE.
> 
> This is because in swsusp_save()->copy_data_pages()->page_is_saveable(),
> kernel_page_present() presumes that a page is present when can_set_direct_map()
> returns false even for NOMAP ranges.So NOMAP pages will saved in after,and then
> cause level3 translation fault in this pages.

I can see how kernel_page_present() ended up returning true if
!can_set_direct_map(), though based on the function naming only, it
feels a bit unintuitive. Is arm64 the only architecture making use of
MEMBLOCK_NOMAP? Or is it the only one where kernel_page_present() also
returns true if !can_set_direct_map()?

> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index 02870beb271e..d90005de1d26 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -94,7 +94,7 @@ int pfn_is_nosave(unsigned long pfn)
>  	unsigned long nosave_end_pfn = sym_to_pfn(&__nosave_end - 1);
>  
>  	return ((pfn >= nosave_begin_pfn) && (pfn <= nosave_end_pfn)) ||
> -		crash_is_nosave(pfn);
> +		crash_is_nosave(pfn) || !pfn_is_map_memory(pfn);
>  }

This indeed fixes the problem but it looks like an arm64-specific
workaround. I can see at least arm, loongarch and riscv making use of
memblock_is_map_memory() (which is what pfn_is_map_memory() calls). Do
they not have the same problem? On riscv, for example,
kernel_page_present() does not depend on any ARCH_HAS_SET_DIRECT_MAP
related options/conditions (neither does x86 though not sure it cares
about MEMBLOCK_NOMAP). Should we do the same for arm64 and drop the
!can_set_direct_map() condition in kernel_page_present()?

-- 
Catalin
