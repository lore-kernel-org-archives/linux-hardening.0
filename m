Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2200C77B73
	for <linux-hardening@archiver.kernel.org>; Tue, 30 May 2023 23:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbjE3XGX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 May 2023 19:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbjE3XGT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 May 2023 19:06:19 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174B4106
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:06:18 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b02085bf8dso27024355ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685487977; x=1688079977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcDYCA1ly3FY36KE9EWIOvW5CJ9uAXN9yGVuBTepsnc=;
        b=QmpIBCm0bgCPUs09dyc/o5eU4i6Dw1qVFrByK3z3774DuokLJJ5Dr8qcL8x3GSlukA
         +Es5uMz6GG+AxG59ttJN6rWn/S6DbMZFTkGpodUtwPYNq94ST62VcynrQ6QRWXvciOtf
         sRjTJOSxq67nMa2MM7IZi0If0EEtCYUCpXzVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685487977; x=1688079977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcDYCA1ly3FY36KE9EWIOvW5CJ9uAXN9yGVuBTepsnc=;
        b=WoO39HRyFmos3f3L6SBEZfYftTzO0hVCt4TL81G+6PgUjqzJr2DmBN0a1wmt8dzsAc
         kKeqAJj9i9tsiMgjHijq8AMNc2QfauR8AhD1+hJaEF7SvnSQ6aT3uMZO7iEMl6OrlcFd
         iccjuWRM9pWxbJUxkMR33fW3I123GsS9KSRy4g8nHt5rDNomA7Q4A1u1QnoqNRpdmiR7
         SDNw/ztZb63y7+p1uHiHkI6aN1CTLM3gWKB5e2bQOpZCPw0h+sSBjkBBgZCmoFOa7x7J
         cqp+JyVlmv/HGb13Nk8/95BM0gEJsR+EX5umoWtlBXP5y1/EtiJvl3gUcnD93IwMeTkP
         UhoA==
X-Gm-Message-State: AC+VfDyTp2bJ+sOC2BYYNHke+2Ssuij3ZJWXfKTbY5zYpMjUluw24VvU
        4mlAygVPQ3ARGjdgyyb3ste9+g==
X-Google-Smtp-Source: ACHHUZ6+T0rn+23nFZ2bBysdZXPkmLl084nIIhu+nk6HaZ+/iu7UziuIVXBJvj2OWpYs0rE6mYzohA==
X-Received: by 2002:a17:902:f687:b0:1b0:74f5:bf10 with SMTP id l7-20020a170902f68700b001b074f5bf10mr1904564plg.65.1685487977534;
        Tue, 30 May 2023 16:06:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f54200b001b052483e9csm2810211plf.231.2023.05.30.16.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:06:15 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     azeemshaikh38@gmail.com, krzysztof.kozlowski@linaro.org
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w1: sgi_w1: Replace all non-returning strlcpy with strscpy
Date:   Tue, 30 May 2023 16:06:07 -0700
Message-Id: <168548796310.1350188.6990158151809298087.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523022023.2406955-1-azeemshaikh38@gmail.com>
References: <20230523022023.2406955-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, 23 May 2023 02:20:23 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] w1: sgi_w1: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/4e4424b20cc4

-- 
Kees Cook

