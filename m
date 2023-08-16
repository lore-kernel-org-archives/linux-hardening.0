Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D69C25B7D
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Aug 2023 21:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346382AbjHPVHW (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Aug 2023 17:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346413AbjHPVHL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Aug 2023 17:07:11 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1282713
        for <linux-hardening@vger.kernel.org>; Wed, 16 Aug 2023 14:07:09 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-53482b44007so4259525a12.2
        for <linux-hardening@vger.kernel.org>; Wed, 16 Aug 2023 14:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692220029; x=1692824829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r3Yx/ofvM8SKQSiO3tHzoOQnNC0JboOEN9yZBTokARA=;
        b=ZzbqonGaOBv1EZxtYkwzcNc/Pza7vRjEHIfgAoe2wtMO4uUVRTZDOnNVhtsQKZGD+e
         Mfakd4mq9tKyJNO9S0XpGOUmbgB09a8EPzJNB5LhIeqQAA67c6KLpe5RE55XZyvNFdlA
         rjRwK8P6umzK3/QTZma3kszvAnRVjPePnXxkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692220029; x=1692824829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3Yx/ofvM8SKQSiO3tHzoOQnNC0JboOEN9yZBTokARA=;
        b=M4tQ5gY5MG+zuzPux4TWK335SC23rs7YuV0mboswrUiuPRxo+SIR6ITQasPOcJg1QU
         UJ3csDEftwFSGo8NELjvaR+PvaIQ+m5OWGNlqUIFaaEo/tBA6LzlNhFUGePoLA4oEkIX
         UA/2Mfxm5pHHsFXuFgGTqII82AzW5hMtmgjSQZ0mCHriObq+Zqk+D1JsovwTg3/SQJ6t
         t4RYmr5zFVCfXSZ9ExaQfPbIKc+WVdiGX9ig0EZNLLoRva1Fw5VdxHUTkMKdCIHcONOZ
         qz7haeGRUxTa9cEtHVHS8RQOonOu9oCncnDWCrJ3AvjsXoc3IBNGdSLqYC2QCfrRHn4h
         sdWQ==
X-Gm-Message-State: AOJu0Yxj6vR+cV25dfK1YLgF8uLP1qi2GIxPj1u4I/MnJ/4QQ8B/G9w5
        70/Me9yPmjfsFzJ3ssTP2cgzww==
X-Google-Smtp-Source: AGHT+IGtyVYYg0njIa2w4f4XfQY20e85rwgXh3WhXGv6SkwlDP1zqM0PSyoWql9zf4cbOAdyz6C0fw==
X-Received: by 2002:a05:6a20:1444:b0:132:cd2d:16fd with SMTP id a4-20020a056a20144400b00132cd2d16fdmr4020731pzi.38.1692220029384;
        Wed, 16 Aug 2023 14:07:09 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j20-20020aa783d4000000b00682c864f35bsm11916050pfn.140.2023.08.16.14.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 14:07:08 -0700 (PDT)
Date:   Wed, 16 Aug 2023 14:07:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     nathanl@linux.ibm.com
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/rtas_flash: allow user copy to flash block
 cache objects
Message-ID: <202308161407.48AAE65CB@keescook>
References: <20230810-rtas-flash-vs-hardened-usercopy-v2-1-dcf63793a938@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810-rtas-flash-vs-hardened-usercopy-v2-1-dcf63793a938@linux.ibm.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 10, 2023 at 10:37:55PM -0500, Nathan Lynch via B4 Relay wrote:
> From: Nathan Lynch <nathanl@linux.ibm.com>
> 
> With hardened usercopy enabled (CONFIG_HARDENED_USERCOPY=y), using the
> /proc/powerpc/rtas/firmware_update interface to prepare a system
> firmware update yields a BUG():
> 
> kernel BUG at mm/usercopy.c:102!
> Oops: Exception in kernel mode, sig: 5 [#1]
> LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
> Modules linked in:
> CPU: 0 PID: 2232 Comm: dd Not tainted 6.5.0-rc3+ #2
> Hardware name: IBM,8408-E8E POWER8E (raw) 0x4b0201 0xf000004 of:IBM,FW860.50 (SV860_146) hv:phyp pSeries
> NIP:  c0000000005991d0 LR: c0000000005991cc CTR: 0000000000000000
> REGS: c0000000148c76a0 TRAP: 0700   Not tainted  (6.5.0-rc3+)
> MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 24002242  XER: 0000000c
> CFAR: c0000000001fbd34 IRQMASK: 0
> [ ... GPRs omitted ... ]
> NIP [c0000000005991d0] usercopy_abort+0xa0/0xb0
> LR [c0000000005991cc] usercopy_abort+0x9c/0xb0
> Call Trace:
> [c0000000148c7940] [c0000000005991cc] usercopy_abort+0x9c/0xb0 (unreliable)
> [c0000000148c79b0] [c000000000536814] __check_heap_object+0x1b4/0x1d0
> [c0000000148c79f0] [c000000000599080] __check_object_size+0x2d0/0x380
> [c0000000148c7a30] [c000000000045ed4] rtas_flash_write+0xe4/0x250
> [c0000000148c7a80] [c00000000068a0fc] proc_reg_write+0xfc/0x160
> [c0000000148c7ab0] [c0000000005a381c] vfs_write+0xfc/0x4e0
> [c0000000148c7b70] [c0000000005a3e10] ksys_write+0x90/0x160
> [c0000000148c7bc0] [c00000000002f2c8] system_call_exception+0x178/0x320
> [c0000000148c7e50] [c00000000000d520] system_call_common+0x160/0x2c4
> --- interrupt: c00 at 0x7fff9f17e5e4
> 
> The blocks of the firmware image are copied directly from user memory
> to objects allocated from flash_block_cache, so flash_block_cache must
> be created using kmem_cache_create_usercopy() to mark it safe for user
> access.
> 
> Fixes: 6d07d1cd300f ("usercopy: Restrict non-usercopy caches to size 0")
> Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
