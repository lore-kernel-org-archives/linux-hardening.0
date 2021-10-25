Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B53DC433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 25 Oct 2021 21:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49E6F61073
	for <linux-hardening@archiver.kernel.org>; Mon, 25 Oct 2021 21:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhJYVCh (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 25 Oct 2021 17:02:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233258AbhJYVCf (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 25 Oct 2021 17:02:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FE3961073;
        Mon, 25 Oct 2021 21:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635195612;
        bh=ZyMliUqV47n8vJU6KxKqCmYFPqznH//sZgzNbYo7fRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s23QMnt9wl/QSimJBd4IO2681Yl0aMOOywtpMlgtJ8dEv/Udi6W+mtFYRfwSRwaG6
         7IwW5sLh2mMRKlbKw2wBcBHmRGEHusnRNE+b/F/alR84XEs4G/PZ0D35HLAKFguzOb
         LaEyeW3UTEBSnVYAJqIMf3OjBlgs4bs61wFLdBaDTzi9VKOYfo43iBv9+1jAL8BSCB
         Y8yyB9GaKlsJ3scxWbHJv0lQ+V627i2l7t48sSw6gIkiYihIzOcGkHiJLzydXPPNLX
         bYsudmxKNwbHAKrPHcPwn6xyxcomLqmxoW6PkFzvH845Otn01aqDhNsSuyrqfrwZIl
         JZrhBxQCGGQAw==
Date:   Mon, 25 Oct 2021 16:05:03 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Len Baker <len.baker@gmx.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: prefer flex_array_size and struct_size over open
 coded arithmetic
Message-ID: <20211025210503.GA1437674@embeddedor>
References: <20211024172921.4110-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211024172921.4110-1-len.baker@gmx.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Oct 24, 2021 at 07:29:21PM +0200, Len Baker wrote:
> In an effort to avoid open-coded arithmetic in the kernel [1], use the
> flex_array_size() and struct_size() helpers instead of an open-coded
> calculation.
> 
> [1] https://github.com/KSPP/linux/issues/160
> 
> Signed-off-by: Len Baker <len.baker@gmx.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  drivers/nvme/host/multipath.c   | 2 +-
>  drivers/nvme/target/admin-cmd.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 954e84df6eb7..7f2071f2460c 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -562,7 +562,7 @@ static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
>  			return -EINVAL;
> 
>  		nr_nsids = le32_to_cpu(desc->nnsids);
> -		nsid_buf_size = nr_nsids * sizeof(__le32);
> +		nsid_buf_size = flex_array_size(desc, nsids, nr_nsids);
> 
>  		if (WARN_ON_ONCE(desc->grpid == 0))
>  			return -EINVAL;
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 403de678fd06..6fb24746de06 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -264,7 +264,7 @@ static u32 nvmet_format_ana_group(struct nvmet_req *req, u32 grpid,
>  	desc->chgcnt = cpu_to_le64(nvmet_ana_chgcnt);
>  	desc->state = req->port->ana_state[grpid];
>  	memset(desc->rsvd17, 0, sizeof(desc->rsvd17));
> -	return sizeof(struct nvme_ana_group_desc) + count * sizeof(__le32);
> +	return struct_size(desc, nsids, count);
>  }
> 
>  static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
> --
> 2.25.1
> 
