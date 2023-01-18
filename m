Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01194C32793
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Jan 2023 20:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjARUZS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Jan 2023 15:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjARUZR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Jan 2023 15:25:17 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5527B5356B
        for <linux-hardening@vger.kernel.org>; Wed, 18 Jan 2023 12:25:17 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id k13so283614plg.0
        for <linux-hardening@vger.kernel.org>; Wed, 18 Jan 2023 12:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46uvpXl2kyYV0aM1iCgQPff7hpPKEZ+B8VHs2uJkR+w=;
        b=dVrLXEcaBgvYU97sVNjHhooNFluRwtCPIzI//8G66FkmP1s40nUOucz3RYYRCmKPEx
         fgAuo93zirmhoRnivzsrrpUlIi7sQ0gBclnpogdyRCed3aYi5zJIfP2UUAlSRaGHu3FY
         EJ/SCqvd85Pez6eZdqkI7PJHIqi08dl2llj6SGz+7m9awA47Z8PY5ht2YfomVwqW/N4c
         o+mLDbKw/NnG/cjzG+m1KedoySUjoabCM0SJm+w3pf8PXQQlL/D4EpRJyOBeZXJZwxKA
         EaO/qCyf3Abk921jr1UjDFVflLUTdJsuOxZSfxhi8yIYOerNOpUxe4hmrjpb0+VxEYJz
         VQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46uvpXl2kyYV0aM1iCgQPff7hpPKEZ+B8VHs2uJkR+w=;
        b=mAdWr8PwRfoESIoDnQb0IFmy+XdseK4bobyUxqhtaGc4mTxFZiykQYV6Yqw90fpVCP
         pYGqw+FMnCL5Zgf2ShvjY01fhE4yjb2XHmLBJusXmAd8uprreBg3oscyFh4xnuMhElsS
         PyxaWS0UQ43DxT12xNpR3SMxdk2ZFBpen9aRUezN5X95Vvus9XWXyGXOVTAMitP/yKuU
         d2bXSqJo4SWrqtwJCtniVUdKAQcutffhK4c3lp0TLlp6vqxCEmFJ+J4kyC7U0sKTxAYK
         snDTWjk74KhFXojzKNVAL1H/QaDXsijeT5jXjfMUbpDfmu6UVTvLVFR5yVBYLhu1oTl4
         7sUQ==
X-Gm-Message-State: AFqh2kpWKGXCjU8FBCzn6mLcHlqbhXECIU+FdpgZM52Lu6IsIFrSEon9
        MVgJg1F/+wwXPZp4gcwMe97Pix6a44j83N4s
X-Google-Smtp-Source: AMrXdXv+7A9LkJCz8hBYplxN02lr9pWgA7TXhelJH2oX4KHqIaP0jqrpEgKUj060wIvjCUHFTudk5w==
X-Received: by 2002:a17:902:ea02:b0:194:8f3c:6fc6 with SMTP id s2-20020a170902ea0200b001948f3c6fc6mr11573013plg.58.1674073516510;
        Wed, 18 Jan 2023 12:25:16 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id l6-20020a170903244600b0019467381dd6sm11523541pls.33.2023.01.18.12.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 12:25:16 -0800 (PST)
Date:   Wed, 18 Jan 2023 12:25:16 -0800 (PST)
X-Google-Original-Date: Wed, 18 Jan 2023 12:24:47 PST (-0800)
Subject:     Re: [PATCH] gcc-plugins: Reorganize gimple includes for GCC 13
In-Reply-To: <20230118202355.never.520-kees@kernel.org>
CC:     linux-hardening@vger.kernel.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     keescook@chromium.org
Message-ID: <mhng-8bc81919-3023-4d72-bd44-2443606b4fd7@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 18 Jan 2023 12:24:02 PST (-0800), keescook@chromium.org wrote:
> The gimple-iterator.h header must be included before gimple-fold.h
> starting with GCC 13. Reorganize gimple headers to work for all GCC
> versions.
>
> Reported-by: Palmer Dabbelt <palmer@rivosinc.com>
> Link: https://lore.kernel.org/all/20230113173033.4380-1-palmer@rivosinc.com/
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  scripts/gcc-plugins/gcc-common.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
> index 9a1895747b15..84c730da36dd 100644
> --- a/scripts/gcc-plugins/gcc-common.h
> +++ b/scripts/gcc-plugins/gcc-common.h
> @@ -71,7 +71,9 @@
>  #include "varasm.h"
>  #include "stor-layout.h"
>  #include "internal-fn.h"
> +#include "gimple.h"
>  #include "gimple-expr.h"
> +#include "gimple-iterator.h"
>  #include "gimple-fold.h"
>  #include "context.h"
>  #include "tree-ssa-alias.h"
> @@ -85,10 +87,8 @@
>  #include "tree-eh.h"
>  #include "stmt.h"
>  #include "gimplify.h"
> -#include "gimple.h"
>  #include "tree-phinodes.h"
>  #include "tree-cfg.h"
> -#include "gimple-iterator.h"
>  #include "gimple-ssa.h"
>  #include "ssa-iterators.h"

Thanks, not sure how I missed it the first round.  My testing box is 
tied up, but I'v egot the same diff lying around somewhere so

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
