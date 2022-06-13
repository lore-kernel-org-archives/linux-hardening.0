Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3925FCCA47B
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 08:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237591AbiFMIFG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 04:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239041AbiFMIEf (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 04:04:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4C061707A
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 01:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655107473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yG4TXPIUpzu5JrpFoncCij2pFS/fRyC7T4T0EvjrJIw=;
        b=U5c80HCjuORchfSRleskrTH9kkBsBCMEyGJ3d5Ly5eH7Mtg8ID75cScIp5fOYiu0DjHG15
        mm3LgF/fpLXWLjgVvFPNkT0+kFt909XwpSSkuMkMwgzDdrkpP8mTiVcVKmsNZRB7dr//tK
        j0khV9uxQjcxJj4s7hT7EqGAmBJnDjw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-d33zrsDJOwS2KjK_5RU2Xw-1; Mon, 13 Jun 2022 04:04:31 -0400
X-MC-Unique: d33zrsDJOwS2KjK_5RU2Xw-1
Received: by mail-qt1-f199.google.com with SMTP id u24-20020a05622a199800b0030500f8e1bcso3861252qtc.16
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 01:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yG4TXPIUpzu5JrpFoncCij2pFS/fRyC7T4T0EvjrJIw=;
        b=tYdxEnPIj48/nW3ldBzNXbAJSKKsGtCjgIeDk8P0Yko8FIxvCbvUACwn/wq2n4Faq1
         r4IrV/MdWwGBcSa09zCmb1C6jiptIkoSALwRQdC97D8CdQ4jIdoA3Stryg6IwJ2x04fn
         dB8GEV1JYvIKxWH1BTBZLgDfgLiOBdC2IY0ClD27uFdDQL3kycUuv91wr6F/5GEgZNWn
         S//Z3k6+x3uDqeUgwqlbiiCpkJ4/w0UJdvmChru38YshswSDObFecNRMvFE0lK4arVt8
         zoJHDMOdZeAHik2lNfeDCuOv8oaej3PuMGPHWD33DnOEAmCHiJrvN3UVY+9gjvpz9smE
         sf0g==
X-Gm-Message-State: AOAM531Zij9fJRzK+kCN9j7Ptxwc8aSlhqTI6AkJf+WssL6NGkfTK9pX
        SRiygZgEHLSXkiljinM5pg67gFODiFP1TFmR/lKTLT5cqaHHqSILtixOVcqTSbdz9Jmmx+Ahoky
        TjQVT2+gpWAHRSX1lUflrvFPW2mPZ
X-Received: by 2002:ac8:75c5:0:b0:304:ffea:c434 with SMTP id z5-20020ac875c5000000b00304ffeac434mr21835015qtq.170.1655107471479;
        Mon, 13 Jun 2022 01:04:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyK9pDfdt2ahRKvrZUBXZLqk04TKP9jpVIYJWgt4s4IShRDLBAZDAcAbWT6DSNOcl4fM1ceg==
X-Received: by 2002:ac8:75c5:0:b0:304:ffea:c434 with SMTP id z5-20020ac875c5000000b00304ffeac434mr21834999qtq.170.1655107471225;
        Mon, 13 Jun 2022 01:04:31 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x14-20020a05620a448e00b006a711bb74b6sm6631173qkp.87.2022.06.13.01.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 01:04:30 -0700 (PDT)
Date:   Mon, 13 Jun 2022 16:04:24 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        Uladzislau Rezki <urezki@gmail.com>, linux-xfs@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/3] Fixes for usercopy
Message-ID: <20220613080424.gkfn3v3crjjbgxyb@zlang-mailbox>
References: <20220612213227.3881769-1-willy@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20220612213227.3881769-1-willy@infradead.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=zlang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Jun 12, 2022 at 10:32:24PM +0100, Matthew Wilcox (Oracle) wrote:
> Kees, I'm hoping you'll take these through your tree.  I think they're
> all reasonable fixes to go into 5.19.  The first one is essential;
> it fixes two different bugs that people have hit.
> 
> Matthew Wilcox (Oracle) (3):
>   usercopy: Handle vm_map_ram() areas
>   usercopy: Cast pointer to an integer once
>   usercopy: Make usercopy resilient against ridiculously large copies

Hi Matthew,

[Quick response] ...
After merging this patchset onto linux v5.19-rc2, I can't reproduce bug [1]
anymore. I'd like to keep the test running, if it find other issues I'll
feedback.

Thanks,
Zorro

[1]
https://bugzilla.kernel.org/show_bug.cgi?id=216073

> 
>  include/linux/vmalloc.h |  1 +
>  mm/usercopy.c           | 24 +++++++++++++-----------
>  mm/vmalloc.c            |  2 +-
>  3 files changed, 15 insertions(+), 12 deletions(-)
> 
> -- 
> 2.35.1
> 

