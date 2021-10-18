Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD290C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Oct 2021 01:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFC1560F24
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Oct 2021 01:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344901AbhJRBJD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 17 Oct 2021 21:09:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:31464 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344765AbhJRBJB (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 17 Oct 2021 21:09:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10140"; a="226919008"
X-IronPort-AV: E=Sophos;i="5.85,380,1624345200"; 
   d="scan'208";a="226919008"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2021 18:06:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,380,1624345200"; 
   d="scan'208";a="493379665"
Received: from louislifei-optiplex-7050.sh.intel.com (HELO louislifei-OptiPlex-7050) ([10.239.154.151])
  by orsmga008.jf.intel.com with ESMTP; 17 Oct 2021 18:06:48 -0700
Date:   Mon, 18 Oct 2021 09:07:16 +0800
From:   Li Fei1 <fei1.li@intel.com>
To:     Len Baker <len.baker@gmx.com>
Cc:     keescook@chromium.org, gustavoars@kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virt: acrn: Prefer array_syze and struct_size over open
 coded arithmetic
Message-ID: <20211018010716.GA31860@louislifei-OptiPlex-7050>
References: <20211011103902.15638-1-len.baker@gmx.com>
 <20211012013429.GA28284@louislifei-OptiPlex-7050>
 <20211015155248.GA3289@titan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015155248.GA3289@titan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Oct 15, 2021 at 05:52:48PM +0200, Len Baker wrote:
> Hi Li,
> 
> On Tue, Oct 12, 2021 at 09:34:29AM +0800, Li Fei1 wrote:
> > On Mon, Oct 11, 2021 at 12:39:02PM +0200, Len Baker wrote:
> > > As noted in the "Deprecated Interfaces, Language Features, Attributes,
> > > and Conventions" documentation [1], size calculations (especially
> > > multiplication) should not be performed in memory allocator (or similar)
> > > function arguments due to the risk of them overflowing. This could lead
> > > to values wrapping around and a smaller allocation being made than the
> > > caller was expecting. Using those allocations could lead to linear
> > > overflows of heap memory and other misbehaviors.
> > >
> > > So, use the array_size() helper to do the arithmetic instead of the
> > > argument "count * size" in the vzalloc() function.
> > >
> > > Also, take the opportunity to add a flexible array member of struct
> > > vm_memory_region_op to the vm_memory_region_batch structure. And then,
> > > change the code accordingly and use the struct_size() helper to do the
> > > arithmetic instead of the argument "size + size * count" in the kzalloc
> > > function.
> > >
> > > This code was detected with the help of Coccinelle and audited and fixed
> > > manually.
> > >
> > > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> > >
> > > Signed-off-by: Len Baker <len.baker@gmx.com>
> >
> > Hi Baker
> >
> > Thanks for helping us to fix this issue. This patch looks good to me.
> > Please add Signed-off-by: Fei Li <fei1.li@intel.com>.
> 
> I can't add the "Signed-off-by" tag by myself. However, if you are in the
> path to forward the patch to the mainline (maintainer's tree), you can
> add by yourself the "Signed-off-by" tag before send a "pull" to Linus.
> See [1] for more information.
> 
> [1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
> 
> If you don't have a maintainer's tree, you can give (as a maintainer) an
> "Acked-by" tag that then I can add to the patch. More info in [2].

Acked-by: Fei Li <fei1.li@intel.com>

thanks.

> 
> [2] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
> 
> > Only two minor comments.
> >
> >
> > > ---
> > >  drivers/virt/acrn/acrn_drv.h | 10 ++++++----
> > >  drivers/virt/acrn/mm.c       |  9 ++++-----
> > >  2 files changed, 10 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/virt/acrn/acrn_drv.h b/drivers/virt/acrn/acrn_drv.h
> > > index 1be54efa666c..fcc2e3e5232a 100644
> > > --- a/drivers/virt/acrn/acrn_drv.h
> > > +++ b/drivers/virt/acrn/acrn_drv.h
> > > @@ -48,6 +48,7 @@ struct vm_memory_region_op {
> > >   * @reserved:		Reserved.
> > >   * @regions_num:	The number of vm_memory_region_op.
> > >   * @regions_gpa:	Physical address of a vm_memory_region_op array.
> > > + * @regions_op:		Flexible array of vm_memory_region_op.
> > One Tab please.
> 
> Sorry, but if I use only one tab, the parameters description are not all
> aligned.
> 
> > >   *
> > >   * HC_VM_SET_MEMORY_REGIONS uses this structure to manage EPT mappings of
> > >   * multiple memory regions of a User VM. A &struct vm_memory_region_batch
> > > @@ -55,10 +56,11 @@ struct vm_memory_region_op {
> > >   * ACRN Hypervisor.
> > >   */
> > >  struct vm_memory_region_batch {
> > > -	u16	vmid;
> > > -	u16	reserved[3];
> > > -	u32	regions_num;
> > > -	u64	regions_gpa;
> > > +	u16				vmid;
> > > +	u16				reserved[3];
> > > +	u32				regions_num;
> > > +	u64				regions_gpa;
> > > +	struct vm_memory_region_op	regions_op[];
> > Please use Whitespace instead of Tab.
> 
> Sorry, but I don't understand. Do you prefer something like?:
> 
> diff --git a/drivers/virt/acrn/acrn_drv.h b/drivers/virt/acrn/acrn_drv.h
> index fcc2e3e5232a..5663c17ad37c 100644
> --- a/drivers/virt/acrn/acrn_drv.h
> +++ b/drivers/virt/acrn/acrn_drv.h
> @@ -56,11 +56,11 @@ struct vm_memory_region_op {
>   * ACRN Hypervisor.
>   */
>  struct vm_memory_region_batch {
> -	u16				vmid;
> -	u16				reserved[3];
> -	u32				regions_num;
> -	u64				regions_gpa;
> -	struct vm_memory_region_op	regions_op[];
> +	u16			   vmid;
> +	u16			   reserved[3];
> +	u32			   regions_num;
> +	u64			   regions_gpa;
> +	struct vm_memory_region_op regions_op[];
>  };
> 
>  /**
> 
> Moreover, for the v2 I will fix the typo "syze->size" in the subject as
> suggested Kees ;)
> 
> Regards,
> Len
