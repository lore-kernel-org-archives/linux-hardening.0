Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37FFC433F5
	for <linux-hardening@archiver.kernel.org>; Sun, 17 Oct 2021 17:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0BED61038
	for <linux-hardening@archiver.kernel.org>; Sun, 17 Oct 2021 17:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344364AbhJQRVg (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 17 Oct 2021 13:21:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344366AbhJQRVf (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 17 Oct 2021 13:21:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1654960FE3;
        Sun, 17 Oct 2021 17:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634491165;
        bh=N5I/TK6RMFPLcyd9DVqkH+PDXTwES+K3ZR23ZkNZClY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R6HSq4fLCJnzfn0amTzAgSD3Ca6FdmcMwGDzJO6fdYhuMhf476KP1gdodhoheltAP
         9PL6MJbMWs0+bALZEcCtaAJDgJ3G+dHSBchHzPhtEN3kfdO3ubuHNyJCrFnpEaV3nc
         Egz17o6qOfuQffB6Hx/ta+EtJhjmCR7JpHjRv5Oqbu4cExyYiQw8JQTM2QsfY04Lap
         nr9xV+MxPrOoIUhs/IPMotuIWhVvVuSnBTByue7bN5jRchNFRa6Hu0akvRBsOp9MyG
         zvwsmFpk65JAfDKkhx/BtZHwYFCzgxY1kqRVt9JD4ExWTVt4QTaETia8+8mGprlmBz
         lDnp3rKEA5bTQ==
Date:   Sun, 17 Oct 2021 12:23:57 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Len Baker <len.baker@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: prefer struct_size over open coded arithmetic
Message-ID: <20211017172357.GA1214270@embeddedor>
References: <20211017095650.3718-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017095650.3718-1-len.baker@gmx.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Oct 17, 2021 at 11:56:50AM +0200, Len Baker wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> In this case this is not actually dynamic size: all the operands
> involved in the calculation are constant values. However it is better to
> refactor this anyway, just to keep the open-coded math idiom out of
> code.
> 
> So, use the struct_size() helper to do the arithmetic instead of the
> argument "size + count * size" in the kmalloc() function.
> 
> This code was detected with the help of Coccinelle and audited and fixed
> manually.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> Signed-off-by: Len Baker <len.baker@gmx.com>
> ---
> Hi,
> 
> this patch is built against the linux-next tree (tag next-20211015).

You don't need to include these lines in every patch. Just add [next]
to the subject line, like this:

	[PATCH][next] nvmet: prefer struct_size over open coded arithmetic

It should be clear enough for people that you are talking about
linux-next. And in case someone asks, then you proceed to clarify. :)

> 
> Regards,
> Len
> 
>  drivers/nvme/target/admin-cmd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index aa6d84d8848e..4aa71625c86a 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -278,8 +278,8 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
>  	u16 status;
> 
>  	status = NVME_SC_INTERNAL;
> -	desc = kmalloc(sizeof(struct nvme_ana_group_desc) +
> -			NVMET_MAX_NAMESPACES * sizeof(__le32), GFP_KERNEL);
> +	desc = kmalloc(struct_size(desc, nsids, NVMET_MAX_NAMESPACES),
> +		       GFP_KERNEL);

It might be worth exploring if the flexible array is actually needed,
once the allocation is always determined by NVMET_MAX_NAMESPACES. Maybe
it can be changed to the following and remove the dynamic allocation
entirely?

	struct nvme_ana_group_desc {
		__le32  grpid;
		__le32  nnsids;
		__le64  chgcnt;
		__u8    state;
		__u8    rsvd17[15];
		__le32  nsids[NVMET_MAX_NAMESPACES];
	};

If the above is possible then (at least) these lines should be audited:

drivers/nvme/host/multipath.c-551-              if (WARN_ON_ONCE(offset > ctrl->ana_log_size - sizeof(*desc)))

drivers/nvme/host/multipath.c-566-              offset += sizeof(*desc);
drivers/nvme/host/multipath.c-567-              if (WARN_ON_ONCE(offset > ctrl->ana_log_size - nsid_buf_size))

If the flexible array remains, then this line could use
flex_array_size():

drivers/nvme/host/multipath.c-555-              nsid_buf_size = nr_nsids * sizeof(__le32);

struct_size() could be used here, as well:

drivers/nvme/host/multipath.c-847-      ana_log_size = sizeof(struct nvme_ana_rsp_hdr) +
drivers/nvme/host/multipath.c:848:              ctrl->nanagrpid * sizeof(struct nvme_ana_group_desc) +
drivers/nvme/host/multipath.c-849-              ctrl->max_namespaces * sizeof(__le32);

drivers/nvme/target/admin-cmd.c:267:    return sizeof(struct nvme_ana_group_desc) + count * sizeof(__le32);

Thanks
--
Gustavo


>  	if (!desc)
>  		goto out;
> 
> --
> 2.25.1
> 
