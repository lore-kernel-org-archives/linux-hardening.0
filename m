Return-Path: <SRS0=kTaS=D7=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B3AC4363A
	for <linux-hardening@archiver.kernel.org>; Sat, 24 Oct 2020 11:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4840824248
	for <linux-hardening@archiver.kernel.org>; Sat, 24 Oct 2020 11:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RB4Ifw11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758618AbgJXLBy (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 24 Oct 2020 07:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758622AbgJXLBy (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 24 Oct 2020 07:01:54 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2D3C0613CE;
        Sat, 24 Oct 2020 04:01:53 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i2so4325423ljg.4;
        Sat, 24 Oct 2020 04:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J7AXGwZjHBo0cvQ8nOxRhJ0Ve52DSlFqmlnOi+p9Ml4=;
        b=RB4Ifw11Et8ewDdQ71Y1JyrVaP+QLMh5l+oakjdrwQqGAl+nHe8uPPEeSLuG61NzR1
         sNlfoKNM/zeyich0IQ1x7luJpp1P6jMpoTUVVoSPsU2FWKW0VjThcIA/BY+ubptMqYcP
         3TX7OTFWPFRQe36AXd0enGK0j7/iTZ0RkxsX4jm9C4QkD6paQFYN5MRRUIcmOvvXluLO
         aJBFFdJLrm9qiUoerblrXizM7ULYrs0ROpLNN1rvpc2qY2j+u0jYs0g9nhxBGIYcPuLh
         RlMyDCwNUtdirjqOiqSuOweLQ7UgzXjflCcohOUD/148FRKfYGfxCgeHAR6lJU/HzaV8
         Ampg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J7AXGwZjHBo0cvQ8nOxRhJ0Ve52DSlFqmlnOi+p9Ml4=;
        b=tkmDQL9F/sbUXM567YsZo9U+TQ/DZSFp0vdVEs9EaKIJQzqmEikvC+19WKXy5JHPiI
         i3jNRPDEL7XKPo0mRgShSslNt2k9qE1Y/Pizp2h/IJuoSvCWe0zY5KOhE42cR26CR/Re
         zLCJtcbqtMmNEHLe9sgp9QVxRuTxoUj58ffLeiDmh2eTgNIZsGnYDVYGhAkGCg36jJ3F
         95SeMACHsV4ulbKI/FX6dZ5O2HSsFixv9U+XWHzrX0xcTk7eCswycuKBtYM9AAF7QIwN
         +8kystwXGDSAimPjTyOTuMn+A9YtzFLzWqhdcDEvZTxVJyk4vvIw/XENZ/HTgiuq7kLh
         fKMw==
X-Gm-Message-State: AOAM532tui9+U5lhVoa2+GDKxmU/OoE4OkKgOH18OGYLRUq890gvyyH9
        +6AMM9P8uLDONSi+dySVfB7iZv4BVxY=
X-Google-Smtp-Source: ABdhPJziG/fPpVvjAmCunEwpSNa2+UJyviag/t3AiZqI88dIphjawUEOM+KFCId+O3zeCfP2ehG6zg==
X-Received: by 2002:a2e:8997:: with SMTP id c23mr2256835lji.132.1603537311739;
        Sat, 24 Oct 2020 04:01:51 -0700 (PDT)
Received: from [192.168.1.112] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id v20sm483354lji.90.2020.10.24.04.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2020 04:01:51 -0700 (PDT)
Subject: Re: BTI interaction between seccomp filters in systemd and glibc
 mprotect calls, causing service failures
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, libc-alpha@sourceware.org,
        systemd-devel@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Dave Martin <dave.martin@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org
References: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com>
 <20201022075447.GO3819@arm.com>
 <78464155-f459-773f-d0ee-c5bdbeb39e5d@gmail.com>
 <202010221256.A4F95FD11@keescook> <20201023090232.GA25736@gaia>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <cf655c11-d854-281a-17ae-262ddf0aaa08@gmail.com>
Date:   Sat, 24 Oct 2020 14:01:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201023090232.GA25736@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 23.10.2020 12.02, Catalin Marinas wrote:
> On Thu, Oct 22, 2020 at 01:02:18PM -0700, Kees Cook wrote:
>> Regardless, it makes sense to me to have the kernel load the executable
>> itself with BTI enabled by default. I prefer gaining Catalin's suggested
>> patch[2]. :)
> [...]
>> [2] https://lore.kernel.org/linux-arm-kernel/20201022093104.GB1229@gaia/
> 
> I think I first heard the idea at Mark R ;).
> 
> It still needs glibc changes to avoid the mprotect(), or at least ignore
> the error. Since this is an ABI change and we don't know which kernels
> would have it backported, maybe better to still issue the mprotect() but
> ignore the failure.

What about kernel adding an auxiliary vector as a flag to indicate that 
BTI is supported and recommended by the kernel? Then dynamic loader 
could use that to detect that a) the main executable is BTI protected 
and there's no need to mprotect() it and b) PROT_BTI flag should be 
added to all PROT_EXEC pages.

In absence of the vector, the dynamic loader might choose to skip doing 
PROT_BTI at all (since the main executable isn't protected anyway 
either, or maybe even the kernel is up-to-date but it knows that it's 
not recommended for some reason, or maybe the kernel is so ancient that 
it doesn't know about BTI). Optionally it could still read the flag from 
ELF later (for compatibility with old kernels) and then do the 
mprotect() dance, which may trip seccomp filters, possibly fatally.

-Topi
