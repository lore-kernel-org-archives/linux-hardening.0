Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F39FC38A02
	for <linux-hardening@archiver.kernel.org>; Fri, 28 Oct 2022 15:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJ1Pzb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 28 Oct 2022 11:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJ1Pza (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 28 Oct 2022 11:55:30 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CC27CAB3
        for <linux-hardening@vger.kernel.org>; Fri, 28 Oct 2022 08:55:23 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id y4so5212856plb.2
        for <linux-hardening@vger.kernel.org>; Fri, 28 Oct 2022 08:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eKtdiD5asKcGWot3PAICGzT56u80z6HIjVaZyNSw2rU=;
        b=I13VML/uh+kpbw0loNqqGGtHcl0MU3xDY7M5+O+4t94zrswJ/AafsezCP1INGzrkol
         kyMoBR16m2ZSRmmbNcD2kHnxgAD2KZ8K6/chntP49loRvF0PNfC24xjLe0nRiSzoV2hi
         Mm3wE5/gacRneLCq9+pxLNp/+NIKG2OYeAeTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKtdiD5asKcGWot3PAICGzT56u80z6HIjVaZyNSw2rU=;
        b=CMjP+sg6pR50cKtAMoWsoNaJc0GSnh2vPVzjKqPz1s03YxCDgM2QTSijkXGSGsNJ2c
         8hCCy5xD+imBVI5wP92paZGCM760nbAwj6alZLSk7vqs3PZkt5tr2ajXeEpYJzGxhIo/
         9jj6Z0aJhwZDLUmlezFH0KIESSGk1DZ+zyclVWDZ/Sqz7FY3/20aWLJkbDoOPu3zuzw6
         k9c8hGt9265zFmv8WUDBM7ovtGxcNX67ztR7B/zg5b2YJaC1MGTuV7WeMNMAQ4BhTq+V
         DDs2JOk+/viniPig1dUUBUBz4nZyE2uFhZvbzXz1/B+HhIeCSfcNOnYFJrqdw+wiCBPp
         I8MQ==
X-Gm-Message-State: ACrzQf3uiNUWneeiE9OwWmtL1MVSgJp+m6pTaXY6I6wu1G8n6jAWSWnr
        L/8Z2fmm2Je4yleIVivGN1NOIbMi6G0cJQ==
X-Google-Smtp-Source: AMsMyM76iHfon276M7DiZpG6PeoABKRPBat/8o0gplD0ZsjUdnkI3K3VC2rsQzxNgPypVSewqGRHEw==
X-Received: by 2002:a17:903:22cb:b0:186:a8ae:d107 with SMTP id y11-20020a17090322cb00b00186a8aed107mr27503882plg.119.1666972522809;
        Fri, 28 Oct 2022 08:55:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q11-20020a170902a3cb00b00174f7d107c8sm3180484plb.293.2022.10.28.08.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:55:22 -0700 (PDT)
Date:   Fri, 28 Oct 2022 08:55:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Terrell <terrelln@meta.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: Coverity: HUF_buildCTableFromTree(): Memory - corruptions
Message-ID: <202210280854.5DC7284@keescook>
References: <202210261704.A5AAF0C@keescook>
 <2B7F32C0-2068-4191-AB35-8BA6C3B94935@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2B7F32C0-2068-4191-AB35-8BA6C3B94935@fb.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 27, 2022 at 11:07:42PM +0000, Nick Terrell wrote:
> > If these are false positives, please let us know so we can mark it as
> > such, or teach the Coverity rules to be smarter. If not, please make sure
> > fixes get into linux-next. :) For patches fixing this, please include
> > these lines (but double-check the "Fixes" first):
> 
> These are all false positives.

Okay, thanks for investigating them!

-- 
Kees Cook
