Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B169CC77B75
	for <linux-hardening@archiver.kernel.org>; Tue, 16 May 2023 18:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjEPSSD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 16 May 2023 14:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjEPSSD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 16 May 2023 14:18:03 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB82F26AB
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 11:18:00 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64ab2a37812so7586568b3a.1
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 11:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684261080; x=1686853080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8cc9brQlxat+Tem9ifRtXojhPwiKrSHIw+ztKefqiZM=;
        b=X8S2qkYg1pp/fm1FYkzd9Dwv8egcg2UqCZxdE7N8PovhmJzTDlSxrxQKsoN1cHFGxO
         l9frKdWD8CEUSb2FLgsY0sbtihKjkG4aFXSKmVNpuRGXR16iEgNo8VH+7tgfb1Scqdxe
         HhZFOV/3BTqPuy3mHdqP+M9avtial4WLiFT0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684261080; x=1686853080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cc9brQlxat+Tem9ifRtXojhPwiKrSHIw+ztKefqiZM=;
        b=O3C81GK/TbOdOaE2BpoMCXoYOnNuA9xBHsSZR483eBDVxyxlB54ND3pwbK9kunvD+V
         DHbEZDkqziGLc1OKBe341Aetq2tYTYRhzsIqQY/tDKcvefo+TZSiIUkrGXmHIWMZ/7wP
         0fDPlFhDhH8A2gRpPUBj0L3hinJsGpPraKIK4FSqqOMjy82KeYhuZ9o8JAsRBbI4J/V0
         isGC/W2H5WGd8WVRZdDPqj+3Bg0Tfmnn2F/2+c4xy7lah3x1rmdSDTf01P3JSgtSNINE
         BqCtQG7ilflNpqcDMydqYqikKpeUAGB/vofk+D1Pnsmh5Ft5V6L0bvDTV5S+f/XNEHR3
         LI5Q==
X-Gm-Message-State: AC+VfDzXCAmUaMWjlEbExlJLc2CJDbik6H3jPSgH2P+0xOArMfyfW5wS
        hhEIAH6vJ8YXkV2QSGh/zKu6Bg==
X-Google-Smtp-Source: ACHHUZ7bCSpualAL6/85/t5jrNsxBBt/5ZSvZRBDFz2eEP+O5i3BOdH93hdJMG046HdbC+Q42SL2PQ==
X-Received: by 2002:a05:6a20:914c:b0:103:f331:cee9 with SMTP id x12-20020a056a20914c00b00103f331cee9mr23901330pzc.24.1684261080180;
        Tue, 16 May 2023 11:18:00 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k7-20020a63d847000000b005142206430fsm13837990pgj.36.2023.05.16.11.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 11:17:59 -0700 (PDT)
Date:   Tue, 16 May 2023 11:17:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: qla2xxx: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305161117.586BB905F@keescook>
References: <20230516025404.2843867-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516025404.2843867-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 16, 2023 at 02:54:04AM +0000, Azeem Shaikh wrote:
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
