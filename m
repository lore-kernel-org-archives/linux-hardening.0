Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46158C7EE45
	for <linux-hardening@archiver.kernel.org>; Mon, 22 May 2023 19:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbjEVTkM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 22 May 2023 15:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbjEVTjx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 22 May 2023 15:39:53 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F195BDC
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 12:39:48 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64d15660784so3585578b3a.0
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 12:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684784388; x=1687376388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vka/2o5l1FsmD6QMn6ltPo0a4RlZx5eEDRHPQd36/bQ=;
        b=TZp4t9tIX3ZBCHasUB11xMlXPoFE/YMM4EbJwJwSRemcCRTBNDBK8h6PW/aT1uSF3x
         P+4mj1FFzmo6520S/+GPzodFdMfNd2T1lARvMWG3rVxJpBVA8pjhE4IW/oIMjEeuogzj
         TP/9Oi6ni+hbu47KCCC5Wde3MnDVXCijEMJeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684784388; x=1687376388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vka/2o5l1FsmD6QMn6ltPo0a4RlZx5eEDRHPQd36/bQ=;
        b=NSn+cCM3uknsnDCP4TjLgRmTYKFo2dFxPOnJ0DUNNIOlLbjvk9SLFPTk2Flshl14HB
         diEfT+0omTMtPiQrcfOlF34AdIAL/1hLpRrc4emtYW3EEx5lcCJo9G9Omea/7zQEk+JV
         SQ2bo2Ky9/nMooY6nFFa/6iTYh0Vuu6bfmW7YfNpHJ50Ges0puTf6m+eg2IFwKuRFWHM
         CD0jPPwo6tFCYRV+2h2MeiFJcBp4/tGvXgP88vcelp7oF2tyIbXaVqvg7O7yQO4canG3
         o5iFD/MI2RqzvQRgm8BUEcF2y1IyZGlc+lv5nkB6I5IN57tUqxjlwh/A0dUMAkPxWmVy
         lf8w==
X-Gm-Message-State: AC+VfDy0wkbUq3c2SLpcNeBFdC+YWTCrLKPWhcDGiSqb5LOz/bEE71bi
        uAo3/7GJ6tdmmLq0FPHaLwyi1g==
X-Google-Smtp-Source: ACHHUZ6SbNlGLkUA6HPZC11hSL0Hrdf6KCW7w4l7XaDQgUFWkyMLraB82uNVGBe8si4gmo0FNKbc3Q==
X-Received: by 2002:a05:6a20:9384:b0:101:5171:c880 with SMTP id x4-20020a056a20938400b001015171c880mr13180755pzh.62.1684784388330;
        Mon, 22 May 2023 12:39:48 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v5-20020a654605000000b0050f7208b4bcsm256080pgq.89.2023.05.22.12.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 12:39:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     azeemshaikh38@gmail.com, anna@kernel.org,
        trond.myklebust@hammerspace.com
Cc:     Kees Cook <keescook@chromium.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] NFS: Prefer strscpy over strlcpy calls
Date:   Mon, 22 May 2023 12:39:36 -0700
Message-Id: <168478437620.244538.12858579380072843624.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230512155749.1356958-1-azeemshaikh38@gmail.com>
References: <20230512155749.1356958-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, 12 May 2023 15:57:49 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> Check for strscpy()'s return value of -E2BIG on truncate for safe
> replacement with strlcpy().
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] NFS: Prefer strscpy over strlcpy calls
      https://git.kernel.org/kees/c/8ca25e00cf81

-- 
Kees Cook

