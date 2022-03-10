Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F74C433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Mar 2022 08:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbiCJIYv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 10 Mar 2022 03:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbiCJIYu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 10 Mar 2022 03:24:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0D6A134DF8
        for <linux-hardening@vger.kernel.org>; Thu, 10 Mar 2022 00:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646900628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+l4Wm/+i9uQFSCO6Q6PGOilIGdBXACV/1I5jpny3c0=;
        b=JK9gxxRKf7N77Uv2eV0Bot1yVxAS77yPFhPC6ADpQD9BH1LOWM+FOyYCRfZIa/f0XVasSX
        6+mLL74RuXwGNAzWi4wG/XuZY0GS8HYuZf5JLgtYCHyFX9T85GXc9GoRamzUnpOUazIWSL
        RG3DKQdcSs9yVq37IktkS8+l7DuWpfY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-yun3DaDQP2KaG5KDCIkTHA-1; Thu, 10 Mar 2022 03:23:47 -0500
X-MC-Unique: yun3DaDQP2KaG5KDCIkTHA-1
Received: by mail-wm1-f69.google.com with SMTP id x5-20020a1c7c05000000b00389bcc8df46so2015903wmc.0
        for <linux-hardening@vger.kernel.org>; Thu, 10 Mar 2022 00:23:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=/+l4Wm/+i9uQFSCO6Q6PGOilIGdBXACV/1I5jpny3c0=;
        b=DhBryoXZj8R382gHb2VDAWqhgq5eht93M8IXtcYRaCPpEapdSigVag3K8tx4wajBd4
         xX+HRGVJtTr5+Ue0tzFb+ph4HJJdDsB2rxQURbvf1DrUCJu1cXOKg7YR2EGXcFDUsSYN
         yJXHBe2a4b19MKQwcWz7heh5xCRK977f3mJWXA6rjtfBX3dqpHmAw8LUkrP1k0YA3YX8
         wTj+P3DRvxbO9o9rZAE+0m1UlLlE1J22K6CP1hraxLOgTtTbgFh7XvXyugzGDaQcg/az
         dBygLl7ki1xHKgiPFFz5QXfQA5EIwK4CISQIMQcqzLo26mOELa/pLddzHGk5E4gWHinQ
         I98g==
X-Gm-Message-State: AOAM533sllbQUL5s1C7tKCi04QYmkKQ9yWOBmU9BKL/4hT66/qopTwl2
        kyBCzKTUWMBEVY1tapWCgy0J6JAUXC7dxM2jETVr3wBcoZwkGQQNn0Bgpd2LSI2Fv/DX3BwZvRc
        voA5Gx5mAFoYFX50KDG+05njvZaxI
X-Received: by 2002:a7b:c94e:0:b0:386:3694:3e78 with SMTP id i14-20020a7bc94e000000b0038636943e78mr2547361wml.22.1646900626459;
        Thu, 10 Mar 2022 00:23:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZ5LGXrpDG+oZXlWmRve+wbXFrXo6EIpXvBD1ZCdvaQeZfsct49X7TFx7LGk8Zp1FwATZQ/w==
X-Received: by 2002:a7b:c94e:0:b0:386:3694:3e78 with SMTP id i14-20020a7bc94e000000b0038636943e78mr2547338wml.22.1646900626207;
        Thu, 10 Mar 2022 00:23:46 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id i8-20020a7bc948000000b003898dfd7990sm4200666wml.29.2022.03.10.00.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 00:23:45 -0800 (PST)
Message-ID: <9059fa71-330f-f04f-b155-2850abb72a71@redhat.com>
Date:   Thu, 10 Mar 2022 09:23:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ARM/dma-mapping: Remove CMA code when not built with CMA
To:     Kees Cook <keescook@chromium.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Zi Yan <ziy@nvidia.com>, Hari Bathini <hbathini@linux.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-arm-kernel@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20220309175107.195182-1-keescook@chromium.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220309175107.195182-1-keescook@chromium.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 09.03.22 18:51, Kees Cook wrote:
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
>       |                                        ^~~~~~~~~~~~~
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Martin Oliveira <martin.oliveira@eideticom.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

