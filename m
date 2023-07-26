Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2240AC0015E
	for <linux-hardening@archiver.kernel.org>; Wed, 26 Jul 2023 21:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjGZVx0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 26 Jul 2023 17:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjGZVxZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 26 Jul 2023 17:53:25 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B1F26BB
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jul 2023 14:53:24 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686e0213c0bso275744b3a.1
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jul 2023 14:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690408403; x=1691013203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7o3CN+su3di7WaA9bWuG9cZg9fmgR34kXAM5LCkUKN0=;
        b=RBiICJQzenyR3+D4KJZHLpmaQiqoWkKDAQ3LssNG4zdPxb5jhUUj0L6CQFhsgam7vg
         H+zqZacAXrPed3+5TdMOZxPocLkXrVM+FkX/MgCbp9E/kRSRfQ27NA9MPC9Rbu7GxcaK
         o32dURpNXqUP7bKtXqJ+6vcXTllE/LtWrn89Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690408403; x=1691013203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7o3CN+su3di7WaA9bWuG9cZg9fmgR34kXAM5LCkUKN0=;
        b=N5hi8mTLO+iigiGaO1uPWxOoNiIHxFtoY/E4cIcb2kYdFjoJS8X3E/k1MkSgmb3Qdx
         l+PIac60yhhkMqQyA29XmHAvdfViQrmKLebi7+rqaLwpgEbXjO8DQkUBBVsxh0iCFHaE
         eVzoQoFBBaV7W31vjn+6FvXZnRxisfocWenlYvu3wjiaw9iX+6AwAbnFFZBYReBqgZJl
         4GpXBuUxB3XrWnFQjPaVR7Uw87xzSDgpStH8II/y1S32w9otGnw6sqADUzSmMTBUXNFm
         2XhoRi7CwZA9zv/UmkBjmQGxVdBUgydmQFjhym77CXTdXTGT0xur0qovmlW9hJDVkp3B
         s0EA==
X-Gm-Message-State: ABy/qLbTBg6AhEm8HqTvKEyGMthI8c6yf1mp0d7NHj2GP+ToiJnfC1w0
        1SyP0v+VNQvOFJXjltbVEP59sg==
X-Google-Smtp-Source: APBJJlHxmqHoJCbHhpHOLxLueAFUER7U20Jsnko71nzWTdplk4lISZJmwPL6ZD+DateuphlGdXMrCg==
X-Received: by 2002:a05:6a20:13d2:b0:13b:77e6:4fad with SMTP id ho18-20020a056a2013d200b0013b77e64fadmr2492621pzc.59.1690408403634;
        Wed, 26 Jul 2023 14:53:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c20-20020aa78e14000000b0064aea45b040sm64996pfr.168.2023.07.26.14.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 14:53:23 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Qiang Zhao <qiang.zhao@nxp.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc: fsl: qe: Replace all non-returning strlcpy with strscpy
Date:   Wed, 26 Jul 2023 14:53:12 -0700
Message-Id: <169040838888.1782149.4842834187896840611.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523021425.2406309-1-azeemshaikh38@gmail.com>
References: <20230523021425.2406309-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


On Tue, 23 May 2023 02:14:25 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Applied, thanks!

[1/1] soc: fsl: qe: Replace all non-returning strlcpy with strscpy
      (no commit info)

Best regards,
-- 
Kees Cook

