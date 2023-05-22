Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C95C7EE2A
	for <linux-hardening@archiver.kernel.org>; Mon, 22 May 2023 20:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjEVUy6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 22 May 2023 16:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbjEVUyx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 22 May 2023 16:54:53 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11764B9
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 13:54:52 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-53033a0b473so4586407a12.0
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 13:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684788891; x=1687380891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NoMOPLv7no4oTfFk9NPdm7qdXLsHesaFY5RP9uixIY=;
        b=YAbkAhamHMqgwB/fmb97d06Aas3nfKBdgo3MFaaijc8nFzNSIQN4hG+Q3a31wS63AP
         K/0Q5fEOURfRDKRvNesUwiJ2FuPd/kvLXtteSJHVjZDEzM4ir/gWRYNlsj+jTs6J34x8
         tM4UB+Q+LycG1DFt0P+cdepL/65Bzozly6vJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684788891; x=1687380891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NoMOPLv7no4oTfFk9NPdm7qdXLsHesaFY5RP9uixIY=;
        b=lim8zunx4EIs0mft5zGu7T/KgfE8uWXd1h5yo0LxHjYFwIqarR7oHyTgQ6qdsx3PVX
         yNrlt0J7YwvouBWgFm0Kkvib3uY918ve0xpCqdW+pKj4pQMSgvqdg9G0w7QuMGz1vh24
         6uCRw5Q9wVfhedx1JpHX+jRjmPHJ+hcD8uj10YXJQXNWEyuBXit5suNo5fWmk0zkHW60
         7zYFaRat60IAQ6UPBZLaEQa1VjkjgO4Ie2dMnKLXPar558i7M9C0vCLRukbEQx5TcGqO
         6y/6aUTQuzzITFSMyOlCmikuXsDNzKO9DPWwXnZF7QtnO5d423CYnknq2xr3BR0ywh5V
         ggTA==
X-Gm-Message-State: AC+VfDyAfDIqERwJRDxey3be0aLMWP4Y8k1oe2mZoOMtF63IE4k07jre
        +kFBSK5IQZ1NDj3Br1lMrUZCIQ==
X-Google-Smtp-Source: ACHHUZ4WCaSPgXTc5XPwlg4IRq/kzCNCY0JzzAU84nb9QtSpKKa25DGdSRYQ9MlGMDG8WMvF0qdEIw==
X-Received: by 2002:a17:902:c944:b0:1a6:46f2:4365 with SMTP id i4-20020a170902c94400b001a646f24365mr14314154pla.30.1684788891502;
        Mon, 22 May 2023 13:54:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902bd8a00b001a1a82fc6d3sm5231582pls.268.2023.05.22.13.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:54:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     azeemshaikh38@gmail.com, evan.quan@amd.com
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        Xinhui.Pan@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, airlied@gmail.com,
        alexander.deucher@amd.com, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, christian.koenig@amd.com
Subject: Re: [PATCH] drm/amd/pm: Replace all non-returning strlcpy with strscpy
Date:   Mon, 22 May 2023 13:54:48 -0700
Message-Id: <168478888725.1444594.3121115156306616962.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522155245.2336818-1-azeemshaikh38@gmail.com>
References: <20230522155245.2336818-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, 22 May 2023 15:52:45 +0000, Azeem Shaikh wrote:
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

[1/1] drm/amd/pm: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/0f53b61b1ca0

-- 
Kees Cook

