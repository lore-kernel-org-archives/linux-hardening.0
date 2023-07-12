Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD955EB64DA
	for <linux-hardening@archiver.kernel.org>; Wed, 12 Jul 2023 23:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbjGLXz2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjGLXz2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 12 Jul 2023 19:55:28 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B9F1FCC
        for <linux-hardening@vger.kernel.org>; Wed, 12 Jul 2023 16:55:26 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-668704a5b5bso174008b3a.0
        for <linux-hardening@vger.kernel.org>; Wed, 12 Jul 2023 16:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689206126; x=1691798126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/vU/3bfdHl64WUkd75ReRDYfirTILS0gvYwUTQH7DSM=;
        b=J7alN4E4ewEYIushjF5RhD5xtHURzl5VVAKqYeqMlBLF8w84WUPewCv7Owf2hO1Sx8
         s+NCKO3579s52rnAVRhkl9Bu3oO8BbS3ffYhxKwUqGrTmYDf88Wx6URNb5AOSDmk5OMZ
         e9iOjL4hPL/awuWYemSCQciujiFphf+0gfcEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689206126; x=1691798126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vU/3bfdHl64WUkd75ReRDYfirTILS0gvYwUTQH7DSM=;
        b=E1A7xDR2+0tAPXU7EIvRk61L5DcZV6BLssKZlLN9b5WAgM3Jw81MBy8E+zXNnoLUb6
         PChyCI251NztiQEKbL1wc7j+Yk/0k2r8hE4dUpnSMFAwHI/yHRyhu7cmY/Q/9BKhRG0J
         9Pv+A2y8lW/cCCEtfEHPcn0uZ55L+PJRBkBFBSt1lBAFKZwSHJWYWE7Tb093v/gguwok
         RVAd4Qws7ARM0qurLMmu+bc0qzsz0dbd4dXWoxpDopqTOfAd59FCcRPnLru8lLg7NVqm
         wnsFgzRaalV+jFaaYK6YT5OpGkFLG1jQaNg7NSY5MpSY+YEF9ePKdQgO+p9TDlV6V+Vf
         RWMA==
X-Gm-Message-State: ABy/qLayIss5BW0vBnyrEUAwy/dH/E/CQwOsqlDQF4U3V8ixFQdR/oSk
        SUkQIP40GbC8JYoEWJtr48JNlw==
X-Google-Smtp-Source: APBJJlHQZRshLJRZTXRiub4lrbl9NPrV3egVjkpObEu7LZ5J/dFpr8E4upDYkJFMKJLvoGPiSxabFw==
X-Received: by 2002:a05:6a20:3257:b0:120:1baf:e56e with SMTP id hm23-20020a056a20325700b001201bafe56emr21055274pzc.19.1689206126202;
        Wed, 12 Jul 2023 16:55:26 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j2-20020aa783c2000000b0064f76992905sm4120145pfn.202.2023.07.12.16.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:55:25 -0700 (PDT)
Date:   Wed, 12 Jul 2023 16:55:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        linux-hardening@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH] wifi: mwifiex: Replace strlcpy with strscpy
Message-ID: <202307121655.C365BB8@keescook>
References: <20230710030625.812707-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710030625.812707-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jul 10, 2023 at 03:06:25AM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since return value of -errno
> is used to check for truncation instead of sizeof(dest).
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
