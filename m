Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BADC433F5
	for <linux-hardening@archiver.kernel.org>; Sat, 14 May 2022 21:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbiENVmd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 14 May 2022 17:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiENVmd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 14 May 2022 17:42:33 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C0318382
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 14:42:32 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id s14so11100379plk.8
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 14:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AFfYNEwGAYrl2b1S77DLqgyE3imbGmmk2zhtDuc4ynI=;
        b=kl+nhaCiLE0304bc2Ws7byy+Zt93NbD2+JC8TxTzCPciiAnAK0kjyD+9A7Pqt/OSpz
         cwhEIIPnypOidev2krXJk0uSWujLyzMsR070AKg0DyjxHXCPDqBOwqC8CwPiOrV8gksg
         php3DyRROqICsm53xVIbeWQxek7z5RoSPRTBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AFfYNEwGAYrl2b1S77DLqgyE3imbGmmk2zhtDuc4ynI=;
        b=qbqpyKZoVkZ3wU44sHWEXooKsC9j0c1vXJFrswI7/EXAmrzuFzat+UeYRW9B142D28
         LF/rHeiN67TPN0q0Mh921dxkBuxNR91abN2Bw5/ghcuJuR8dVGXfZuFTFCsRO1O8QSOu
         cPH9rHhBThaauaMUrCMi0ZfX53Lkut0pmAwIzBYMvJJoCwiFLvTts50yU8IJoYFGwLmI
         P+8VzDO59/+aB1CcFSHwEzOhdnK1dQ8sdSwMBYCfUe16ERiMNRkYenlKiwM2GVGVLH26
         o8z/oHMDA4nDf0VhMunriEOTrdmeSMvGcY0o1XwFpcnL70dUUXUlOPpPG9uCcPKHubBj
         s3KA==
X-Gm-Message-State: AOAM533y27xMVy1RAnM3MAIQFdnYFD7uFr1O3iuzHL9LpFCXmDqzBdE8
        5vodYbd1huDBrmUuWuZtVn7tK1XzDMmktg==
X-Google-Smtp-Source: ABdhPJxop1xGmlluyC4skdT7bVdphvZ9BLwlNF0GxA/dVjB1BI12ZPD2SnJuyX+8EvOjL5/QmefH+g==
X-Received: by 2002:a17:90b:3b46:b0:1dc:b314:52e6 with SMTP id ot6-20020a17090b3b4600b001dcb31452e6mr11561361pjb.134.1652564551616;
        Sat, 14 May 2022 14:42:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m4-20020a056a00080400b0050dc76281c4sm4094903pfk.158.2022.05.14.14.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:42:31 -0700 (PDT)
Date:   Sat, 14 May 2022 14:42:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH v2 01/21] efi/libstub: Filter out CC_FLAGS_CFI
Message-ID: <202205141441.C3B7CF6@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-2-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-2-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 13, 2022 at 01:21:39PM -0700, Sami Tolvanen wrote:
> Explicitly filter out CC_FLAGS_CFI in preparation for the flags being
> removed from CC_FLAGS_LTO.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Is it worth merging all the "existing" CC_FLAGS_LTO/CFI splits into a
single patch? Either way:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
