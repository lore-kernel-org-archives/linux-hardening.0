Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D2CC433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 25 Oct 2021 22:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A433061039
	for <linux-hardening@archiver.kernel.org>; Mon, 25 Oct 2021 22:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbhJYWUQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 25 Oct 2021 18:20:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232653AbhJYWUQ (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 25 Oct 2021 18:20:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C570B6103C;
        Mon, 25 Oct 2021 22:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635200273;
        bh=QkYHE9nBzpL7NgurcgGT1Os0R31FtFuTUb+WoH+Edko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QV01YdsKAuhzKmqw5/xTMfU6tZKu83OFlfz7iuVL2KcOByB1Tky/EDIlZbpFKDfHx
         7tg4xh22BPWz6YHToanIqmgU9iTmU8DwdQ8qM5EZpijLLBqkDy0S/Wv4ei8ELagqcA
         nk5DGjFwteaKnlcecAkUKO+OE4pakO6tODWjoege5iaVK6RiPh92e03gwbxNu59ZYZ
         qorDMWXiEUPccNGFvnu6oweS+Uwiwc1aw2wzzmp5ZL/2j0H0CJ8j0scHfkns8yBzEC
         3DyFJEO8DuLJ4sEJsGB8eQRqgQttrBXVAfZtZfsjrIN3lWhy4dSUTsC+1EOXNizpPO
         hJc+sxQBLkt6g==
Date:   Mon, 25 Oct 2021 17:22:44 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Len Baker <len.baker@gmx.com>
Cc:     Fei Li <fei1.li@intel.com>, Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2][next] virt: acrn: Prefer array_size and struct_size
 over open coded arithmetic
Message-ID: <20211025222244.GB1437674@embeddedor>
References: <20211023101554.4064-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211023101554.4064-1-len.baker@gmx.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Oct 23, 2021 at 12:15:54PM +0200, Len Baker wrote:
[..]
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

This form is better:

	array_size(nr_pages, sizeof(*pages))

Thanks
--
Gustavo
