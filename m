Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF24C77B73
	for <linux-hardening@archiver.kernel.org>; Tue, 30 May 2023 23:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbjE3XUu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 May 2023 19:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbjE3XUt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 May 2023 19:20:49 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C96106
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:20:46 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d2a87b9daso3777100b3a.0
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488846; x=1688080846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t1Vwudjwyl03xNqdmEt3B/zK+8nDlcD2+obxiHedFtc=;
        b=UpKCPRGTApVb+TnbUkA1rmKWwn3cbDDqGG87xKnLphX3hLSXpvmZJ7vh4sbHMO4K/F
         rReUuw4P2VmI92qdg7np8UhXfw4V0zswbJS9y7zcsH/wjthAk2oboKs8vzMoDI+VY9cs
         xzHJYPVHMWUI/MT4C9/3+MzpMi7T5KAz1M6+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488846; x=1688080846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1Vwudjwyl03xNqdmEt3B/zK+8nDlcD2+obxiHedFtc=;
        b=XSH+80laQ3udbLopxT2AagL9eV425SsSMrHme/DFkcKhhGSazqMYIWQ57P1J1Bwhr6
         Vh2L6AYsgTHj40pWdurvnIjpyyVLfYv1PANqwevWlv8J5zyUbf1xKTVYj43oG4BMzPIt
         sdfvbm2iNTr9dIH47uLNFAq50DTF6x4975cSW2QqKoDYAqsAOHnlu6nrIOM0YpKuPFkw
         w6eZQgrupN73Gd+JoAgN5K4xbpSjHjvCipWrTVn8YM4MzD5zxo8fCLPZNUYpnivmvsMu
         fFgBGcY5CMp9Ht7zfkBWA+DXngbs3g1kbhANHHhkBFfb7CPMY1Bbvyg9are3fBJGLjEI
         8O7w==
X-Gm-Message-State: AC+VfDwjII5NkQueoTQEu717cKhTpEWBFInuMP5oaM9P8m37MWIQOg+Z
        T30PjcgTAAQDQcQlV2BK3iqeTw==
X-Google-Smtp-Source: ACHHUZ4/ikUrzoQRWgtj8W7r0NCpEjCwxIwlmB9MrrGvTXySQQTcE+FkqJIm8sbd4vfJu7fOFdam8Q==
X-Received: by 2002:aa7:88c5:0:b0:63f:ffd:5360 with SMTP id k5-20020aa788c5000000b0063f0ffd5360mr5340134pff.21.1685488845916;
        Tue, 30 May 2023 16:20:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7810f000000b0064ceb16a1a2sm2110446pfi.182.2023.05.30.16.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:20:45 -0700 (PDT)
Date:   Tue, 30 May 2023 16:20:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Michal Simek <monstr@monstr.eu>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of/flattree: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305301620.44CC8F786@keescook>
References: <20230530162202.983558-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530162202.983558-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 30, 2023 at 04:22:02PM +0000, Azeem Shaikh wrote:
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
