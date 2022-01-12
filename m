Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C62C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 12 Jan 2022 22:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiALWXp (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 12 Jan 2022 17:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiALWXo (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 12 Jan 2022 17:23:44 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D596C061751
        for <linux-hardening@vger.kernel.org>; Wed, 12 Jan 2022 14:23:44 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so15316505pjj.2
        for <linux-hardening@vger.kernel.org>; Wed, 12 Jan 2022 14:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TMVKGQT49DH/LLD/tFy3QBNX0mSxKPeroeqStkkLKDI=;
        b=4mJ6gOW0jxKBgn3no0jpmA7lTgfKK/qra/ahbL067VCRLqG64Vz6ho1TL9diR6f/YW
         ZpuDFNqcApFUH32aT9Z4SXVORRl2PwOR3UJRdWKMsp4FQxE1MOsnL8iIubWzpsyaCNay
         1UhT26UYb/F+VUjUTIqDmE3rQDwY3aWCxgSGeLrlHmOyytf9DB5Y2IQZYkDHO/fSmozX
         za0dcRrwnbJgZamkvLKrFdn1TdpNOA+o764pVasIY7UrCZycKuK1hTjjzuSJpZ/XlA7d
         jgRCJ4eDy9xsLJZ+NEmxfxNE1yDsXsyx4f1027YAsC0ssWYxASU6DRIjNk9AED6jMlTr
         9bYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TMVKGQT49DH/LLD/tFy3QBNX0mSxKPeroeqStkkLKDI=;
        b=zcl8Q5RE2Pq2UbX4WAI0Y5vQYw1wIYAWnvgARzrQFlzWM0NMbx5kahHihDxz4b6MjF
         5vxVI3gTiyaj8cjktu3GNBnT7BHnmXBrwyF/cYN30Qg9jUSxx7WQ7yY1KUBnyfKeoZoN
         e+SpMkvV76fQA4PIt8Xg1KLD1BC2mpUcoFuYP1gtpmjUg2bpYJy4dQ53llkk5VTiGUBv
         JAZfJR2aRCmXYguxSA2RQWreWJkzKTdYaqCmEwzhdwOAXEfXA2g6FU+IsMp657xHrrU4
         BbGVceKg4YdwfAJlF+hGNYXX5BOijskU10/aHaKZq+ohsa0jCk5WZ8b0lgntNsyxehlh
         idBw==
X-Gm-Message-State: AOAM531yjsw//WDLJrE9/BY4qXkfs1T4Lp6qJfhpX/OzxDkCBFn7GeOj
        Ax813/yng4CR9mK5ugPKAAaQOsF+JHym3g==
X-Google-Smtp-Source: ABdhPJyhNaErTayGibYA8zyghPidZI+lSfKnbcuGDtxIF28nf7vE6WFskHj59uD1diaxL90oD9xAvQ==
X-Received: by 2002:a17:902:7e4a:b0:14a:1da5:88dd with SMTP id a10-20020a1709027e4a00b0014a1da588ddmr1783673pln.125.1642026223358;
        Wed, 12 Jan 2022 14:23:43 -0800 (PST)
Received: from ?IPv6:2600:380:767c:9370:809f:a3be:808e:2696? ([2600:380:767c:9370:809f:a3be:808e:2696])
        by smtp.gmail.com with ESMTPSA id v15sm548174pfu.203.2022.01.12.14.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 14:23:42 -0800 (PST)
Subject: Re: [PATCH][RESEND] sata_fsl: Use struct_group() for memcpy() region
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-ide@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20220112220652.3952944-1-keescook@chromium.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <df3eefdc-d8d1-48fa-f5f7-9c2f2382842b@kernel.dk>
Date:   Wed, 12 Jan 2022 15:23:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220112220652.3952944-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 1/12/22 3:06 PM, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memcpy(), memmove(), and memset(), avoid
> intentionally writing across neighboring fields.
> 
> Use struct_group() in struct command_desc around members acmd and fill,
> so they can be referenced together. This will allow memset(), memcpy(),
> and sizeof() to more easily reason about sizes, improve readability,
> and avoid future warnings about writing beyond the end of acmd:
> 
> In function 'fortify_memset_chk',
>     inlined from 'sata_fsl_qc_prep' at drivers/ata/sata_fsl.c:534:3:
> ./include/linux/fortify-string.h:199:4: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
>   199 |    __write_overflow_field();
>       |    ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-ide@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Jens, can you take (or Ack) this? It's a dependency for the FORTIFY_SOURCE
> improvements that are close to being finished. :)

I don't maintain libata anymore, so Damien is the guy to nudge ;-)

-- 
Jens Axboe

