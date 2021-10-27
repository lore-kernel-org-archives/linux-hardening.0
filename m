Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73953C433FE
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 08:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5441B61075
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 08:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239217AbhJ0IIC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 27 Oct 2021 04:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239133AbhJ0IH7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 27 Oct 2021 04:07:59 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F100C061570;
        Wed, 27 Oct 2021 01:05:33 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 9E9E4452; Wed, 27 Oct 2021 10:05:31 +0200 (CEST)
Date:   Wed, 27 Oct 2021 10:05:24 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] iommu/dma: Use kvcalloc() instead of kvzalloc()
Message-ID: <YXkIRNjAD7ilduyO@8bytes.org>
References: <20210928222229.GA280355@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928222229.GA280355@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 28, 2021 at 05:22:29PM -0500, Gustavo A. R. Silva wrote:
> Use 2-factor argument form kvcalloc() instead of kvzalloc().
> 
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/iommu/dma-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

