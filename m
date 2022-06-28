Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C22EC43334
	for <linux-hardening@archiver.kernel.org>; Tue, 28 Jun 2022 18:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbiF1SoV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 28 Jun 2022 14:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbiF1SoS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 28 Jun 2022 14:44:18 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A5F23BFC
        for <linux-hardening@vger.kernel.org>; Tue, 28 Jun 2022 11:44:17 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id z7so10369388qko.8
        for <linux-hardening@vger.kernel.org>; Tue, 28 Jun 2022 11:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=srd0vxfduo9pXREXizXvQ1Gwi/kEACFP1rdXcY0Aglg=;
        b=QDfPPT0fYl+zbzIvYII9znFGb4s02ZWc7rdJXgoVlQii3pb6MPHXUbo2NQcshGpobE
         dWlWXPBgu4AcM4BoWih7Z1Nr6ImLeGEz2FZoCblM4qyf8MsycIzs6ej4nXX7nwNpGP6Q
         WS2wAoLm7tunOmWFHsCTXENR5aJ2dwangh3Hiy+KajaZLCQ31/GJ39i5LG+HlW0f/4Yp
         DzCT3gMR3JvAVHruRt3NJZXTCo87e7XIf3RRiCTD40KLgGYQ8Oy9U016RK3fPhyNykEI
         VcI+7whSObzV9gDqoR9iwpi6V1hWpQPbHnX1dl7fE5ec/owdsM9r7W03JXKpNXxaLmSi
         lJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=srd0vxfduo9pXREXizXvQ1Gwi/kEACFP1rdXcY0Aglg=;
        b=hLgL2dssbjeKsLkaHbuGQByDO9mxg4e0bAU0iLwQ8CS6e7cO7mBTMC8J1AMq8LuGEM
         KHag1vKiZfjCBhfmJ3z4AICp3zML8Io2IkCX7I8k+SYuHo5I5JDLfwsngR7P8iaVQPOt
         ay2xiD8IQ7BYL9HMyn7kRDN9nwK+5sjzGEreywTimTGkPQiwzUzYHcVjuWhgqUSJ2t7a
         NeQeQhfZUlAxNnm7FkUs2yK5G7ctdlQvKmX2Fs2faI4L6jkHQVmfHHfq/GusTEC7Y01u
         ph9j4gVtPoKL3AjTGF8BhW2iXPabnK7vvds5EiWqkyq+emOkiRVmNRb8jWz6ka9GxRnF
         EuNw==
X-Gm-Message-State: AJIora+HQqxBVNMqZz1kUiks3+AsSBkJVpGKB1j8kYCdJCshdh3TlNYF
        jHygPU8ULpaw3kfmmCWksbUN6HHX8PrQtA==
X-Google-Smtp-Source: AGRyM1uBRJ6m7mmrK5Ju1JW1doBHC+UzIgAGX/xwYqaVx3XSmh4juFCDP3TjiYp7BZ5iZ3elpoeXxg==
X-Received: by 2002:a05:622a:7:b0:31b:74bd:1597 with SMTP id x7-20020a05622a000700b0031b74bd1597mr6494688qtw.677.1656441846052;
        Tue, 28 Jun 2022 11:44:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id h9-20020ac85149000000b003050bd1f7c9sm9708477qtn.76.2022.06.28.11.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 11:44:05 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1o6GBw-0035y2-Fs; Tue, 28 Jun 2022 15:44:04 -0300
Date:   Tue, 28 Jun 2022 15:44:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kees Cook <keescook@chromium.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org, dm-devel@redhat.com,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-can@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, io-uring@vger.kernel.org,
        lvs-devel@vger.kernel.org, linux-mtd@lists.infradead.org,
        kasan-dev@googlegroups.com, linux-mmc@vger.kernel.org,
        nvdimm@lists.linux.dev, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, linux-perf-users@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-sctp@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        v9fs-developer@lists.sourceforge.net, linux-rdma@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] treewide: uapi: Replace zero-length arrays with
 flexible-array members
Message-ID: <20220628184404.GS23621@ziepe.ca>
References: <20220627180432.GA136081@embeddedor>
 <6bc1e94c-ce1d-a074-7d0c-8dbe6ce22637@iogearbox.net>
 <20220628004052.GM23621@ziepe.ca>
 <202206281009.4332AA33@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202206281009.4332AA33@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jun 28, 2022 at 10:54:58AM -0700, Kees Cook wrote:

 
> which must also be assuming it's a header. So probably better to just
> drop the driver_data field? I don't see anything using it (that I can
> find) besides as a sanity-check that the field exists and is at the end
> of the struct.

The field is guaranteeing alignment of the following structure. IIRC
there are a few cases that we don't have a u64 already to force this.

Jason
