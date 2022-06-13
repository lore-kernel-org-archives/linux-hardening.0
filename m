Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD2EC43334
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 19:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346139AbiFMTH0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 15:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347912AbiFMTHP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 15:07:15 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDE4BA9B2
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 10:00:49 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c196so6287644pfb.1
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 10:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=78FqfRH7w514PF+DtTDUVZb4nuJTYN3Ujf+lT2vcKYw=;
        b=m4OpC7yjk6cQfwHjn5M2Ja5+zVSbNNSHFpomFR/Qqq7Xi3Arh2HO/aFpFwpXeVO3To
         V6/wik0x6+IpAZnIWC8NdwPsd66uwH6ttq1p9aEkRggL+0vMDF8GHcC3vY0PIAgQvtN7
         1RV5mijcI0sEmsny/0R8SNQ0O6FKfnzjojjmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=78FqfRH7w514PF+DtTDUVZb4nuJTYN3Ujf+lT2vcKYw=;
        b=1LZOFTCy32EsGAQl8jIBBBXEPTMzgDeOcNEhgmbdRh+sUkxfqz1dJu6D8/XyA9vhS4
         iFy/h0p9jCJwlABhWLL7wL2X0MQTLlGyPqrLvrfAUTGNx6jq2QUHtV3Xt1ZFuU9nIkVN
         CKnjYmASIKThnFDav+E78zjSo9r7jlkhpzZ+Pyx1wjx6vIcnTZem7uD0IMfkKNLG2qDU
         bNAYzfVGNyCqZCna0uTVdU9amTEOlFb39ppbz2hKvzYEsO4xetwio5dDcS/Z/Y9l6clN
         VKoxkKHnA8C/aUEXKvDxheGq9H8bQP37vybPd/yLs0tz9QOwElqMJM0jwrVQSl3w+hzI
         /7cQ==
X-Gm-Message-State: AOAM532E+8zGlJVs23cOLFzDG40+YRefimjfvuks/bvyZDVLvQ6NxnYw
        ZaI2E+GPcToZtXdFtveZXT6k7g==
X-Google-Smtp-Source: ABdhPJwSHItZ1lerCMUPRWO1QCPNxs3aNf9iR9dOztuCtjArjjevQt7KrPA/zfU6UdslsPTNiKMJIw==
X-Received: by 2002:a05:6a00:2389:b0:51c:3ca7:b177 with SMTP id f9-20020a056a00238900b0051c3ca7b177mr164659pfc.17.1655139648707;
        Mon, 13 Jun 2022 10:00:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p28-20020a63741c000000b003fd9b8b865dsm5811318pgc.0.2022.06.13.10.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 10:00:48 -0700 (PDT)
Date:   Mon, 13 Jun 2022 10:00:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v4 22/26] arm64: mm: move ro_after_init section into the
 data segment
Message-ID: <202206130959.3C01F529@keescook>
References: <20220613144550.3760857-1-ardb@kernel.org>
 <20220613144550.3760857-23-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613144550.3760857-23-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jun 13, 2022 at 04:45:46PM +0200, Ard Biesheuvel wrote:
> Currently, the ro_after_init sections sits right in the middle of the
> text/rodata/inittext segment, making it difficult to map any of those
> non-writable during early boot. So instead, move it to the start of
> .data, and update the init sequences so that the section is remapped
> read-only once startup completes.
> 
> Note that this moves the entire HYP data section into .data as well -
> this likely needs to remain as a single block for now, but could perhaps
> split into a .rodata and .data..ro_after_init section later.

If I'm reading this correctly, this means that .data..ro_after_init now
lives between .data and .rodata?

Do the various LKDTM tests still pass after this change?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
