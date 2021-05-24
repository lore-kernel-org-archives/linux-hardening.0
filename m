Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2729FC04FF3
	for <linux-hardening@archiver.kernel.org>; Mon, 24 May 2021 19:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDEEA6109F
	for <linux-hardening@archiver.kernel.org>; Mon, 24 May 2021 19:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbhEXTte (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 May 2021 15:49:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47993 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232107AbhEXTte (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 May 2021 15:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621885685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zfxZbd43HV5BQck0fhkJc4tszzGku44t8kIMaje1IsQ=;
        b=Re6lMqpYq99AE3Yl1/kIXhL++2IxjYIVDjnwRx4gRb1BwCNAJS00OPfF8r7N9ZB5JZ6fyN
        9IP2O7k9fif6pra+IbSw6vAb0HIQfFmZkHS7lI6KR+JNzrEYCRbR7hHc2hd+d5L1zB88iH
        ufoN6KVfRtC5WA5VWkI2/QPlS71hCvw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-pD1I8wdkO_2yhId0Ep0XBA-1; Mon, 24 May 2021 15:48:03 -0400
X-MC-Unique: pD1I8wdkO_2yhId0Ep0XBA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D015180FD65;
        Mon, 24 May 2021 19:48:02 +0000 (UTC)
Received: from x1.home.shazbot.org (ovpn-113-225.phx2.redhat.com [10.3.113.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A6641001281;
        Mon, 24 May 2021 19:48:02 +0000 (UTC)
Date:   Mon, 24 May 2021 13:48:01 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] vfio/iommu_type1: Use struct_size() for kzalloc()
Message-ID: <20210524134801.406bc4bf@x1.home.shazbot.org>
In-Reply-To: <20210513230155.GA217517@embeddedor>
References: <20210513230155.GA217517@embeddedor>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 13 May 2021 18:01:55 -0500
"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows
> that, in the worst scenario, could lead to heap overflows.
> 
> This code was detected with the help of Coccinelle and, audited and
> fixed manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index a0747c35a778..a3e925a41b0d 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2795,7 +2795,7 @@ static int vfio_iommu_iova_build_caps(struct vfio_iommu *iommu,
>  		return 0;
>  	}
>  
> -	size = sizeof(*cap_iovas) + (iovas * sizeof(*cap_iovas->iova_ranges));
> +	size = struct_size(cap_iovas, iova_ranges, iovas);
>  
>  	cap_iovas = kzalloc(size, GFP_KERNEL);
>  	if (!cap_iovas)


Looks good, applied to vfio for-linus branch for v5.13.  Thanks,

Alex

