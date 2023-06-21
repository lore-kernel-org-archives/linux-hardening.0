Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFB9EB64DC
	for <linux-hardening@archiver.kernel.org>; Wed, 21 Jun 2023 18:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjFUSKA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 21 Jun 2023 14:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjFUSJk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 21 Jun 2023 14:09:40 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1BA19BE
        for <linux-hardening@vger.kernel.org>; Wed, 21 Jun 2023 11:09:38 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-553a1f13d9fso3569722a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 21 Jun 2023 11:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687370978; x=1689962978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NtCU2aNHiXALlbRX9I4DukzgSyp1YjBiNC4CphoFrEw=;
        b=EqOdfYunj6JALtj6gBMDXY1XZ1NuBHwdT6XXru7HPOH40ch1whOqrIXaaidsAZDU3c
         Fyo49GFMqwN5ola8kxFJPPzHnSTASl4xCJIP6q5pNko7QF/Nq7b3hAnUWDPFGJS2E85F
         NsvAwizAbJH+Sdjb0+9M5uQSkL7rxy7YsCFNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687370978; x=1689962978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtCU2aNHiXALlbRX9I4DukzgSyp1YjBiNC4CphoFrEw=;
        b=byGuW71amaeQL/0FbmhWK1cTwn9aZ6bF6WgvEe1DfswhXcYI7RErd1TmNhM7/ohVzw
         RYAg1fM4e2uQHeIbDa2wQYLsnZBsLFGBt+I7zJ7vqSRl0so44QX1JqExEt4XNMPNg3sG
         wnoFgUhaYNMO5d8wbGIbp6DPFQMRcbE3oZnuJ48CRnmA2nnk2koZ0iIVmqgGL3GxezQE
         yQnEQXKOYvKJYf5KJTfKj7QNfEswooIvkWFR7VL77QIXSBl0b7dQ76TI0IsBso249FhK
         jVGVLikzRk2AGhvgHZi30iP82k1BdxsE6csIJ7tuN/9MANQf9lO1LvijWqNeGD6Udb3E
         Fvow==
X-Gm-Message-State: AC+VfDydSdChPGKl2OoqUlyY24fedCc1jLUONAWDNPLeBbM5ViBAeaos
        2R6Or/Pdsa7iMRWk2OTFUj268A==
X-Google-Smtp-Source: ACHHUZ4FWbV1RyWBA8tediI/mnxk6UaQLmEhERVpP43CeGJ2wgt9fIxD9VuISBehmuwGWMB9HhtIlQ==
X-Received: by 2002:a17:90b:38c8:b0:260:fd64:a20 with SMTP id nn8-20020a17090b38c800b00260fd640a20mr2364445pjb.9.1687370977767;
        Wed, 21 Jun 2023 11:09:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x18-20020a17090abc9200b002533ce5b261sm9274479pjr.10.2023.06.21.11.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 11:09:37 -0700 (PDT)
Date:   Wed, 21 Jun 2023 11:09:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bodo Stroesser <bostroesser@gmail.com>,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] scsi: target: tcmu: Replace strlcpy with strscpy
Message-ID: <202306211109.72E5989586@keescook>
References: <20230621030033.3800351-1-azeemshaikh38@gmail.com>
 <20230621030033.3800351-3-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621030033.3800351-3-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jun 21, 2023 at 03:00:33AM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
