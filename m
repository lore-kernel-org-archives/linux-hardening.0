Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEBEC433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 12 Oct 2021 01:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C651860462
	for <linux-hardening@archiver.kernel.org>; Tue, 12 Oct 2021 01:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhJLBgE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 11 Oct 2021 21:36:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:27025 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231135AbhJLBgE (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 11 Oct 2021 21:36:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10134"; a="250404503"
X-IronPort-AV: E=Sophos;i="5.85,366,1624345200"; 
   d="scan'208";a="250404503"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 18:33:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,366,1624345200"; 
   d="scan'208";a="591540770"
Received: from louislifei-optiplex-7050.sh.intel.com (HELO louislifei-OptiPlex-7050) ([10.239.154.151])
  by orsmga004.jf.intel.com with ESMTP; 11 Oct 2021 18:33:57 -0700
Date:   Tue, 12 Oct 2021 09:34:29 +0800
From:   Li Fei1 <fei1.li@intel.com>
To:     Len Baker <len.baker@gmx.com>
Cc:     keescook@chromium.org, gustavoars@kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        fei1.li@intel.com
Subject: Re: [PATCH] virt: acrn: Prefer array_syze and struct_size over open
 coded arithmetic
Message-ID: <20211012013429.GA28284@louislifei-OptiPlex-7050>
References: <20211011103902.15638-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011103902.15638-1-len.baker@gmx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 11, 2021 at 12:39:02PM +0200, Len Baker wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the array_size() helper to do the arithmetic instead of the
> argument "count * size" in the vzalloc() function.
> 
> Also, take the opportunity to add a flexible array member of struct
> vm_memory_region_op to the vm_memory_region_batch structure. And then,
> change the code accordingly and use the struct_size() helper to do the
> arithmetic instead of the argument "size + size * count" in the kzalloc
> function.
> 
> This code was detected with the help of Coccinelle and audited and fixed
> manually.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> Signed-off-by: Len Baker <len.baker@gmx.com>

Hi Baker

Thanks for helping us to fix this issue. This patch looks good to me.
Please add Signed-off-by: Fei Li <fei1.li@intel.com>.
Only two minor comments.


> ---
>  drivers/virt/acrn/acrn_drv.h | 10 ++++++----
>  drivers/virt/acrn/mm.c       |  9 ++++-----
>  2 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/virt/acrn/acrn_drv.h b/drivers/virt/acrn/acrn_drv.h
> index 1be54efa666c..fcc2e3e5232a 100644
> --- a/drivers/virt/acrn/acrn_drv.h
> +++ b/drivers/virt/acrn/acrn_drv.h
> @@ -48,6 +48,7 @@ struct vm_memory_region_op {
>   * @reserved:		Reserved.
>   * @regions_num:	The number of vm_memory_region_op.
>   * @regions_gpa:	Physical address of a vm_memory_region_op array.
> + * @regions_op:		Flexible array of vm_memory_region_op.
One Tab please.
>   *
>   * HC_VM_SET_MEMORY_REGIONS uses this structure to manage EPT mappings of
>   * multiple memory regions of a User VM. A &struct vm_memory_region_batch
> @@ -55,10 +56,11 @@ struct vm_memory_region_op {
>   * ACRN Hypervisor.
>   */
>  struct vm_memory_region_batch {
> -	u16	vmid;
> -	u16	reserved[3];
> -	u32	regions_num;
> -	u64	regions_gpa;
> +	u16				vmid;
> +	u16				reserved[3];
> +	u32				regions_num;
> +	u64				regions_gpa;
> +	struct vm_memory_region_op	regions_op[];
Please use Whitespace instead of Tab.
>  };
> 
>  /**
> diff --git a/drivers/virt/acrn/mm.c b/drivers/virt/acrn/mm.c
> index c4f2e15c8a2b..a881742cd48d 100644
> --- a/drivers/virt/acrn/mm.c
> +++ b/drivers/virt/acrn/mm.c
> @@ -168,7 +168,7 @@ int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
> 
>  	/* Get the page number of the map region */
>  	nr_pages = memmap->len >> PAGE_SHIFT;
> -	pages = vzalloc(nr_pages * sizeof(struct page *));
> +	pages = vzalloc(array_size(nr_pages, sizeof(struct page *)));
>  	if (!pages)
>  		return -ENOMEM;
> 
> @@ -220,16 +220,15 @@ int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
>  	}
> 
>  	/* Prepare the vm_memory_region_batch */
> -	regions_info = kzalloc(sizeof(*regions_info) +
> -			       sizeof(*vm_region) * nr_regions,
> -			       GFP_KERNEL);
> +	regions_info = kzalloc(struct_size(regions_info, regions_op,
> +					   nr_regions), GFP_KERNEL);
>  	if (!regions_info) {
>  		ret = -ENOMEM;
>  		goto unmap_kernel_map;
>  	}
> 
>  	/* Fill each vm_memory_region_op */
> -	vm_region = (struct vm_memory_region_op *)(regions_info + 1);
> +	vm_region = regions_info->regions_op;
>  	regions_info->vmid = vm->vmid;
>  	regions_info->regions_num = nr_regions;
>  	regions_info->regions_gpa = virt_to_phys(vm_region);
> --
> 2.25.1
> 
