Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3731C7EE24
	for <linux-hardening@archiver.kernel.org>; Tue, 30 May 2023 23:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbjE3XGQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 May 2023 19:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbjE3XGP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 May 2023 19:06:15 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC40E8
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:06:14 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-52cbd7d0c37so3239126a12.3
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685487974; x=1688079974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSt3Az2tny3eQlaVqB2zu16ttm63V7AZ7el7ka8wKXU=;
        b=X9z9+aQDWH74vRy4IFplfW22Zx5BEwKFKnlpZHyhVJxEScox69ft1HKu2FLKLcSrge
         Vd01P1Id4crkK4Hcd6tBX8pKrEOECwVQjb9ZktMnA4BEPLyas9jK1raP4sSjp79/Qxz0
         LeIwDXRtXCqgbmHoSHUaf6xq8WrxB3sDiqNBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685487974; x=1688079974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSt3Az2tny3eQlaVqB2zu16ttm63V7AZ7el7ka8wKXU=;
        b=G9CJEg1ZGXLnoTIEXcRHHF8L0nFn8wC0FM8MAFCUarOa4Gjq6W/GnI18zLkOAYX2L8
         qffAoaAdgHGf1O8jWndKhCKxgkvfPQX5JzrDqXNCnh9F2rVzuzLU99ood5lEgcIktkBC
         952f/g9KpPTiThHSeX4f0TjaXOw/LiauAGR1QwNoQzg9rIDgh5qDW8q65f1Kv1dY/gPF
         pwqMCm8khogFuqH7hzHJuyXe08CUOYc8LFeE5rIca5GKW0vhaqrKkILuWEMB9rnV1jo6
         Z6EFr7R3CQNrday5omy9MImXLYt+PTJneyRrfp+wsYP08DTwsOBmSGFSdjTDSgR+AOnO
         6ebA==
X-Gm-Message-State: AC+VfDzQE+oUQgPXtyx3EgFQJ/4gBE6MIpnpt7Q4uwZY0+OjGocla8/5
        GDmG5julJWP/2qXzwOntf8l9dw==
X-Google-Smtp-Source: ACHHUZ5RyXdOh/r8J51+MHLiWlyfvyIhJb8ljPwpidWRnHRRfPfGJtDpjXj925079sXa9tjNwK9UlA==
X-Received: by 2002:a17:903:2303:b0:1b0:7739:657a with SMTP id d3-20020a170903230300b001b07739657amr1763269plh.50.1685487974391;
        Tue, 30 May 2023 16:06:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902b20400b001a6b2813c13sm10810243plr.172.2023.05.30.16.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:06:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     azeemshaikh38@gmail.com, mripard@kernel.org, wens@csie.org
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        jernej.skrabec@gmail.com, linux-sunxi@lists.linux.dev,
        linux-hardening@vger.kernel.org, daniel@ffwll.ch,
        samuel@sholland.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, airlied@gmail.com
Subject: Re: [PATCH] drm/sun4i: hdmi: Replace all non-returning strlcpy with strscpy
Date:   Tue, 30 May 2023 16:06:05 -0700
Message-Id: <168548796308.1350188.7857893772168629136.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522155331.2336966-1-azeemshaikh38@gmail.com>
References: <20230522155331.2336966-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, 22 May 2023 15:53:31 +0000, Azeem Shaikh wrote:
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

[1/1] drm/sun4i: hdmi: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/6036094a9380

-- 
Kees Cook

