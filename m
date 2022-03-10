Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D1EC4332F
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Mar 2022 07:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239953AbiCJHCG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 10 Mar 2022 02:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239961AbiCJHCF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 10 Mar 2022 02:02:05 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B435812F434;
        Wed,  9 Mar 2022 23:00:55 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9ABD468CFE; Thu, 10 Mar 2022 08:00:43 +0100 (CET)
Date:   Thu, 10 Mar 2022 08:00:41 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Logan Gunthorpe <logang@deltatee.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Zi Yan <ziy@nvidia.com>, Hari Bathini <hbathini@linux.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-arm-kernel@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ARM/dma-mapping: Remove CMA code when not built with
 CMA
Message-ID: <20220310070041.GA24874@lst.de>
References: <20220309175107.195182-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309175107.195182-1-keescook@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Mar 09, 2022 at 09:51:07AM -0800, Kees Cook wrote:
> The MAX_CMA_AREAS could be set to 0, which would result in code that would
> attempt to operate beyond the end of a zero-sized array. If CONFIG_CMA
> is disabled, just remove this code entirely. Found when building with
> -Warray-bounds:
> 
> arch/arm/mm/dma-mapping.c:396:22: warning: array subscript <unknown> is outside array bounds of 'str
> uct dma_contig_early_reserve[0]' [-Warray-bounds]
>   396 |         dma_mmu_remap[dma_mmu_remap_num].size = size;
>       |         ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
> arch/arm/mm/dma-mapping.c:389:40: note: while referencing 'dma_mmu_remap'
>   389 | static struct dma_contig_early_reserve dma_mmu_remap[MAX_CMA_AREAS] __initdata;

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
