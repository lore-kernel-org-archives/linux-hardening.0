Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266D1C77B7A
	for <linux-hardening@archiver.kernel.org>; Tue, 30 May 2023 23:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbjE3XGP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 May 2023 19:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbjE3XGO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 May 2023 19:06:14 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344C2E8
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:06:13 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b065154b79so2543875ad.1
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685487972; x=1688079972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmRWiU8SYa7qmzcA6BuCFr6v3g/uip8NyNgDQrX+Fjc=;
        b=jNd1r7EdeRMW5RqgAY4YmvOndWy9qNNwSgXuxU0T+cjCG0FdVF31XHiBuwbn0+KRdG
         o8GLIYyhUGys5Ms9TCU4yiY3riv8HwZgCBsNs8BOqRCLxYaCzBXFBgABRh9o7YYSVO93
         rZGhtzbENiSmVFKKEjkFoXJfo6S3aiCl92P9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685487972; x=1688079972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmRWiU8SYa7qmzcA6BuCFr6v3g/uip8NyNgDQrX+Fjc=;
        b=F4khy2J4+x0Qdtl06mF9v239BDw4EgD7ggjVrh/Vo3lwSffLv/3PXyFNTtigQAou2O
         hqxjGMxRVduY402sfbYkpHvTYGmWcfNLlb+zQCbHUzWrQRRN3l/hNL47K4bBOOkS5UhS
         tFdePKPY5oTlKjcLzEfb0O+ZlVxkNcIQu5fp5wFcWglxU6i0WMnNdwz0RmD8UJp6t4Ub
         BLyuGihjwKt02Y9YiyVK9WGCmgvucsUG26M2BCg3wCqIhdrWShcIHj0sT6Y5Qi5kZToS
         I2JzyB/rd7HK8l/+SFSG2jRQWCog+TmaL5pDqiOPU+jK47HqYU71xKkw9F7WwvjX+dii
         AlnQ==
X-Gm-Message-State: AC+VfDy9kSm/Sh0YBH3ytNyLcFLVYVwUX4H7ZCGtuCq7+5uP0wtQ+a66
        ncx3KU6ROrtlvhPMFy/siuD4Rg==
X-Google-Smtp-Source: ACHHUZ5fqZh5pSU+w6W+/GY6NcvobRUfpGpThn0wcJW908lMOgIGH5bJ90CYchgBaG9eKril1P2p3w==
X-Received: by 2002:a17:903:32cb:b0:1b0:4a2:5928 with SMTP id i11-20020a17090332cb00b001b004a25928mr14842770plr.8.1685487972713;
        Tue, 30 May 2023 16:06:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902b68200b001ac8218ddb7sm10781022pls.84.2023.05.30.16.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:06:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     tzimmermann@suse.de, azeemshaikh38@gmail.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        imre.deak@intel.com, jani.nikula@intel.com, airlied@gmail.com,
        linux-hardening@vger.kernel.org, daniel@ffwll.ch, sam@ravnborg.org,
        khaled.almahallawy@intel.com, dri-devel@lists.freedesktop.org,
        alexander.deucher@amd.com, lyude@redhat.com, jim.cromie@gmail.com,
        ville.syrjala@linux.intel.com, Wayne.Lin@amd.com
Subject: Re: [PATCH] drm/display/dp_mst: Replace all non-returning strlcpy with strscpy
Date:   Tue, 30 May 2023 16:06:01 -0700
Message-Id: <168548796305.1350188.17508138666156714348.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522155124.2336545-1-azeemshaikh38@gmail.com>
References: <20230522155124.2336545-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, 22 May 2023 15:51:24 +0000, Azeem Shaikh wrote:
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

[1/1] drm/display/dp_mst: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/09c8ecb20243

-- 
Kees Cook

