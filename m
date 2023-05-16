Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94470C7EE23
	for <linux-hardening@archiver.kernel.org>; Tue, 16 May 2023 20:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjEPUIt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 16 May 2023 16:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjEPUIr (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 16 May 2023 16:08:47 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEFE6EB1
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 13:08:45 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-24e1d272b09so67335a91.1
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 13:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684267725; x=1686859725;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u/V262qUw8XfF74g/94L9IkQoQb0N+5s9JpBNYIOMEA=;
        b=bnALCqwxahspYiDsnD2PGqKtgwldIRdNo0VP23zL3wOvjH/is3DvQ9CoNkXBPWId9S
         NoVsQmQhLs4CWxtdpZ1ESPDhZotmLPf7b6pt0ngExFaKxyE3s/NaYNMXxrovY94oSM/h
         bLxopQw8iITqoQAiG/LEFjSNUhdlf6rH6bGqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684267725; x=1686859725;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/V262qUw8XfF74g/94L9IkQoQb0N+5s9JpBNYIOMEA=;
        b=BuvQYVbevA6j9lU/DxxchLxgXOejK2dOvMP+TGl8ikMyj4hK0rs1JgaWP5DdtA3LgV
         E/F9OqmOeUK99lgFkTS/VmSdqMcanqQrREXPKnD/fcjFKoSTK/uqldGh6zIco92rpYph
         YQJhAXehvu9Yz3fCu+NwN1/V/0sds8A86Nrl8WqfRCclj9M0XCIgYK8MNl4TiokAxTJI
         QpRG65aYj1mJ2TtZfkkmR4X56XxS3k/7N+NdiXtlh2NVLrZEg/dhGGMzLO7QOKmmMudW
         +Vjx7roMcSsrhBMMSDKFT1FegU/iQRAppdoDlRkj0G1RCFef4DTmJvXimVbGPcyq/vmf
         RlWA==
X-Gm-Message-State: AC+VfDwrTq6RdkSdyeFgbjS6f45GqsdJvNtNqKLsL4ze6rCs0EiO+czj
        z7VdDNblQwb2Yy1o70baFwFs8A==
X-Google-Smtp-Source: ACHHUZ6zYFxFN3um3mtqJr+uTQ5/Uy0JJzJJ5VCvYr/ssY4KnXlflGz6rnLj2XWp6sVUGOYly/A+uA==
X-Received: by 2002:a17:90b:234f:b0:250:2d63:7b79 with SMTP id ms15-20020a17090b234f00b002502d637b79mr39485711pjb.43.1684267725084;
        Tue, 16 May 2023 13:08:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902c1c600b001a194df5a58sm15983487plc.167.2023.05.16.13.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 13:08:44 -0700 (PDT)
Date:   Tue, 16 May 2023 13:08:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     jeffxu@chromium.org
Cc:     dave.hansen@intel.com, luto@kernel.org, jorgelo@chromium.org,
        groeck@chromium.org, jannh@google.com, sroettger@google.com,
        akpm@linux-foundation.org, jeffxu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/6] Memory Mapping (VMA) protection using PKU - set 1
Message-ID: <202305161307.4A16BB6A47@keescook>
References: <20230515130553.2311248-1-jeffxu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230515130553.2311248-1-jeffxu@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 15, 2023 at 01:05:46PM +0000, jeffxu@chromium.org wrote:
> This patch introduces a new flag, PKEY_ENFORCE_API, to the pkey_alloc()
> function. When a PKEY is created with this flag, it is enforced that any
> thread that wants to make changes to the memory mapping (such as mprotect)
> of the memory must have write access to the PKEY. PKEYs created without
> this flag will continue to work as they do now, for backwards 
> compatibility.
> 
> Only PKEY created from user space can have the new flag set, the PKEY
> allocated by the kernel internally will not have it. In other words,
> ARCH_DEFAULT_PKEY(0) and execute_only_pkey won’t have this flag set,
> and continue work as today.

Cool! Yeah, this looks like it could become quite useful. I assume
V8 folks are on board with this API, etc?

> This set of patch covers mprotect/munmap, I plan to work on other 
> syscalls after this. 

Which ones are on your list currently?

-- 
Kees Cook
