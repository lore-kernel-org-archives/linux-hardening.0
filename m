Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D44BECAAD2
	for <linux-hardening@archiver.kernel.org>; Mon, 29 Aug 2022 22:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiH2WHX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 29 Aug 2022 18:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiH2WHU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 29 Aug 2022 18:07:20 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25CEA2D9B
        for <linux-hardening@vger.kernel.org>; Mon, 29 Aug 2022 15:07:18 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id q3so6085243pjg.3
        for <linux-hardening@vger.kernel.org>; Mon, 29 Aug 2022 15:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=k2Isl7E2TJrjz9RWvaLb1hVmrU1bdckrw7QzjwxtCok=;
        b=kgkdmJX7EizEvIXDuh3PyH9dF4tkinwEbVoInAmpJDW2RpLs7hLMkXJ04kArFIK4uw
         xJinRNSts20Fpeyl0cWOYrfKmZ93mkCktWz28aG7myBx5tzDJ3gL5KlNzCWRomOCtDQZ
         RUyqDuIw0xjEQayVF6Ia5ksfmxWePWZW1oRRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=k2Isl7E2TJrjz9RWvaLb1hVmrU1bdckrw7QzjwxtCok=;
        b=qTz/9ZDlFjVvHTXZyLbA7MXILKCeYrGs29SDUpq/8tfJGc6QwsWmLYKr6mZ4c4bJZW
         sUCGjWCwbqchmZ+wVu23DV37ltAkZytjup1+BvtFAIJIO9x5Vmlinst4MlERuGF+ajjJ
         yWKMvMBSdAx4zs8TKtsVVd7QNVvVn9R1RNVNojV7qufIMIo63gizxg+XSs13Ssg1w/e0
         APPeFIcZM9wtVT6pTx6I54ga4Hzh+AR03tpqk3QdCqfQYvkmENvDjZvVmOMhb+Wlo83D
         h0Pgolc4/O4XIqeM/GF/MvEA1Z1NoyPUEVj01Ar1Eb32GlOm/kyK/5SqmVMxJ572wuD2
         vAIA==
X-Gm-Message-State: ACgBeo30WfrhP5AUR0LSxjVNelOn6lR7G8wUIOLIh7OidUC7O5WPBIz8
        +8buWiCI4tQeObYm5RvTAjq9XjYSDhIFRw==
X-Google-Smtp-Source: AA6agR4KrLR6NM3om4AqBBqcBSC2Rv/4c/jLw32zl1wdhvYKXC6KOo0sBiRaKJGSYNPNPGv75DjJ2Q==
X-Received: by 2002:a17:902:c94d:b0:16d:c10a:650e with SMTP id i13-20020a170902c94d00b0016dc10a650emr17851903pla.29.1661810838390;
        Mon, 29 Aug 2022 15:07:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id md10-20020a17090b23ca00b001f24c08c3fesm7324164pjb.1.2022.08.29.15.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 15:07:17 -0700 (PDT)
Date:   Mon, 29 Aug 2022 15:07:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ALSA: hda/hdmi: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202208291507.FBA7EF4@keescook>
References: <Yw01A+TvF1FWQ588@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw01A+TvF1FWQ588@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Aug 29, 2022 at 04:52:03PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length array
> declaration in union audio_infoframe with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for a flexible-array member in a union.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
