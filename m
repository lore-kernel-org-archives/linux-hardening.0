Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56C1C77B75
	for <linux-hardening@archiver.kernel.org>; Mon, 22 May 2023 20:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbjEVUy6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 22 May 2023 16:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbjEVUyw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 22 May 2023 16:54:52 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6B592
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 13:54:51 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2536b4b3398so4201355a91.3
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 13:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684788891; x=1687380891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuElaN/qDTwisrD4X6pHQNWgjgAbUbIATBdO1zpDRq4=;
        b=MhuIchJoSP3VNW834mCsQH8QhVAtF7Te4uKXeNA+vCPR8uLVLXQlSOUUqmD3FnOyFq
         wSE2ePdtuZfdxWOxnqhyyk5C3i51P5jAWLvfCTqGtZm/Hv6oG/eG7QO1GYOPLQn9IsUF
         ukspP2HSGuGjgrmweUS3CD9/nlMyJ2RKTL4hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684788891; x=1687380891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZuElaN/qDTwisrD4X6pHQNWgjgAbUbIATBdO1zpDRq4=;
        b=CHfV3OaUt5m3fS1Ay0eFV1JkkYbWrYeqU5clUQ491AIW76PTi85XzloPvfQ9Qwg5oz
         43aCGrK72ke0Bh3uamfK9BkKmCC1hqzBpu+pA+45R2gw0xk9nkB5u0lmjie3D5QBIRY4
         7nhkOVS5WKlbTTNM0g7dtg3q45k85qqNhFy/4asty+8VS/A3hDpM05GtaKCXZco794Pz
         7Kauqb1FtRKV2dOfkJjIkNAMY98oFO5LKeMED7G+/otaH4l/MT48TBBEhlaL038oqowy
         F4k1E2B2Z2/PfGD6Qq6AcUO/55cmnO1OOrTi1BXRjfX19Uwj8xC+Y9pbcTH8qnYn6TDZ
         rxBg==
X-Gm-Message-State: AC+VfDzYgxgjEsiHv3PnMGCccDFtzcdv4IfxABtmZI+p5fT8htvuz2jE
        tYgEylDoxUkh4zfTFb1Y+/+naQ==
X-Google-Smtp-Source: ACHHUZ5RojlqCQM3TmsJ+Nx4QRDer9RPXkiS+1C8Bn4fPCBBrUhOW1RX7WMCawCYR7+Mqz7BmU1sxQ==
X-Received: by 2002:a17:90b:3555:b0:253:3b2b:2a3 with SMTP id lt21-20020a17090b355500b002533b2b02a3mr10962552pjb.43.1684788891123;
        Mon, 22 May 2023 13:54:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j3-20020a17090a31c300b0024de39e8746sm6807748pjf.11.2023.05.22.13.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:54:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Xinhui.Pan@amd.com, azeemshaikh38@gmail.com,
        christian.koenig@amd.com, alexander.deucher@amd.com
Cc:     Kees Cook <keescook@chromium.org>, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, airlied@gmail.com,
        linux-hardening@vger.kernel.org, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/radeon: Replace all non-returning strlcpy with strscpy
Date:   Mon, 22 May 2023 13:54:49 -0700
Message-Id: <168478888725.1444594.8281276970110924816.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522155032.2336283-1-azeemshaikh38@gmail.com>
References: <20230522155032.2336283-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, 22 May 2023 15:50:32 +0000, Azeem Shaikh wrote:
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

[1/1] drm/radeon: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/76ea3f6ef93f

-- 
Kees Cook

