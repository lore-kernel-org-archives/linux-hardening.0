Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BA5C77B7D
	for <linux-hardening@archiver.kernel.org>; Wed, 17 May 2023 19:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjEQTOU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 17 May 2023 15:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjEQTOS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 17 May 2023 15:14:18 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6A9D05F
        for <linux-hardening@vger.kernel.org>; Wed, 17 May 2023 12:14:05 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6439d505274so844642b3a.0
        for <linux-hardening@vger.kernel.org>; Wed, 17 May 2023 12:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684350845; x=1686942845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FOcRPuLGObm+Vg1R2GCaP1lmxZ7GfKsTU0IS+UkR3zs=;
        b=SUqO4jCCzRBEgKPabZ2BR1iWXlDt2bJ4YSx2nTK+jnAsmW8ztUDPnxFpi2XNxv89H0
         xkQ2xhTIBVlUIXd65WUWWEmzgGVJRq5XXv4dHzNMp9TnfYmVeRGoc5/iYDZuxhtKLl+X
         R/owG4gwXqt6fPHMYaTSzJ+vYIB2PSQuBqtjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684350845; x=1686942845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOcRPuLGObm+Vg1R2GCaP1lmxZ7GfKsTU0IS+UkR3zs=;
        b=R8Yl6KXHCTnEgcbI7N14sUfjmA5jWMgtXrwIUYLxH6MDUMaAYLYXMCd9Y+BLN+8YGI
         o03zVgvEDTi4zXbArRGnrnyOpx2udot412Ritw5IHDmveZHZy1GmAM8n9irqE/mLNzr8
         a9uf/igS0DUr+5A1hvskQ/osOJqbKRQEaUtAfSwz8XZzVPS3hkCfpfWNN4RZ4h9Yec+k
         GodvpzVjXb6+T/jxVacC86L1rFNMiCl7mIU1h8L0Zss2OaR8W0leFvX01F86JT2Oihum
         T4lQ9rKoKqZjQQ+kJvxTsR6t6F6Hacxdys3sk1/9nsM6zlNz8fknrfuIIx8/IjCF0aYx
         wI0w==
X-Gm-Message-State: AC+VfDzfg0qJHvHt/Sk9+Ij6irPAUmmJnGYwr6pyC78QzP/ZVwd2sxMW
        nOAQYXYsPl2JoY1+Nn/bm8kHzQ==
X-Google-Smtp-Source: ACHHUZ4LRkx/6YsdhklEs/2vurTILxouu44+3QT3dOA1O72v+gTZjxf++gH4zzIh+dIYs6Tt7TknXQ==
X-Received: by 2002:a05:6a00:15c1:b0:64c:ae1c:3385 with SMTP id o1-20020a056a0015c100b0064cae1c3385mr866272pfu.32.1684350845462;
        Wed, 17 May 2023 12:14:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f13-20020aa782cd000000b0062e63cdfcb6sm16005552pfn.94.2023.05.17.12.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:14:05 -0700 (PDT)
Date:   Wed, 17 May 2023 12:14:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] scsi: ibmvscsi: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305171214.77A5A62DD@keescook>
References: <20230517143409.1520298-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517143409.1520298-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, May 17, 2023 at 02:34:09PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
