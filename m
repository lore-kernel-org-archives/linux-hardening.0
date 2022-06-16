Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F93C43334
	for <linux-hardening@archiver.kernel.org>; Thu, 16 Jun 2022 16:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbiFPQSn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 16 Jun 2022 12:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378276AbiFPQS0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 16 Jun 2022 12:18:26 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5493A48303
        for <linux-hardening@vger.kernel.org>; Thu, 16 Jun 2022 09:18:17 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x4so1910406pfj.10
        for <linux-hardening@vger.kernel.org>; Thu, 16 Jun 2022 09:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YThWgln9l4OPG2o0oO5dP1Gq7H9lMTy8Vq4yIgbkHKk=;
        b=fGDws3BEt9Yg+0C5R4F03o8NCl6tMK4Z+jTdfp9fEL9+lPvBwyXNrucAMpfVQcGMWV
         LgpKgFMnojytc9QA57nfpQsUf7VPKwE1cbgVcbqGl9ZAKdtUgqEgoF+yZtCudxKHzY3E
         GwIvx0+XF0Qm7SPwgtymxXED//Mqbv0K7DFZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YThWgln9l4OPG2o0oO5dP1Gq7H9lMTy8Vq4yIgbkHKk=;
        b=YHK6fKQeLOJBRGAKCGniJ5LL1Qep9m+fAxRLkqsZqJzKkl5+C5hgV7vQyiose0ijaZ
         4YYYvUScg46Irhp4GkKuByuOulFXyIMflB7A4Pv+MKw+ywN0sf5/XEGdYnPY6K2vTw0u
         FD5HjnYWZmozvVTEPYxH1Yx9tpH8Uxmv8yvfUcixQHao+NumwG4gG4sEmDfUcLSNjkts
         MHfY7FBVAciy196On6bKI25quLXY0qJV3T6KYmAQCVSIn9yM+S/5EW7GuSZHFHSbYGzg
         ei16fFtyOFqoX9efN7Fts62PUyaJPU2ouPU3nDUX+3/PSo97hCM+l8/k96HgIPGqApoF
         IHGQ==
X-Gm-Message-State: AJIora+4fy67djMh/OVXH3+SWgM3+Tl6OVKYdfMTLjUQwlU5g3vIFpHJ
        2vG4xc+rXFtjXgRiLDk0fgetaHDLV0qrpA==
X-Google-Smtp-Source: AGRyM1vngQEcxexkSYphjnCYw7tJkdkm+e/gUFDNpwia9hTwRvQEpsjkwfwWKjOzYWXFQh5qE1Ml9w==
X-Received: by 2002:a05:6a00:22d1:b0:51c:15ac:396e with SMTP id f17-20020a056a0022d100b0051c15ac396emr5423982pfj.58.1655396296779;
        Thu, 16 Jun 2022 09:18:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id iy7-20020a170903130700b0016156e0c3cbsm1855692plb.156.2022.06.16.09.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 09:18:16 -0700 (PDT)
Date:   Thu, 16 Jun 2022 09:18:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-hardening@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v4 22/26] arm64: mm: move ro_after_init section into the
 data segment
Message-ID: <202206160917.D7DB8221@keescook>
References: <20220613144550.3760857-1-ardb@kernel.org>
 <20220613144550.3760857-23-ardb@kernel.org>
 <202206130959.3C01F529@keescook>
 <CAMj1kXG8MsL5NHN61W+58Q2di1o9P3kaxUCNe4D5sXcdLhOkUQ@mail.gmail.com>
 <202206131630.B6AE6ECEA3@keescook>
 <CAMj1kXHP8+yErY8F3wzc8=sWfqUYxCJ_AtW0_Gugng-0cpEXPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHP8+yErY8F3wzc8=sWfqUYxCJ_AtW0_Gugng-0cpEXPA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jun 16, 2022 at 01:31:23PM +0200, Ard Biesheuvel wrote:
> We used to have
> 
> text
> --
> rodata
> (ro_after_init)
> --
> inittext
> --
> initdata
> --
> data
> bss
> 
> where -- are the segment boundaries, which are always aligned to 64k on arm64
> 
> After this patch, we get
> 
> text
> --
> rodata
> --
> inittext
> --
> initdata
> --
> (ro_after_init)
> data
> bss
> 
> so in terms of padding due to alignment, there is not a lot of difference.

But how is ro_after_init read-only and data isn't, if there isn't a
segment alignment to make that work out?

-- 
Kees Cook
