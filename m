Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E02CC77B7A
	for <linux-hardening@archiver.kernel.org>; Tue, 16 May 2023 20:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjEPUHm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 16 May 2023 16:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEPUHl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 16 May 2023 16:07:41 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686626EB5
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 13:07:40 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ae4e264e03so792525ad.2
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 13:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684267660; x=1686859660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5yK4aZqvfgO0WJ8XP2YQsUwZXdAoZzrxUjN80rlLt4Q=;
        b=n+n0N1x1kTOQTXTYpkicsApchyuKJU6rIqOVr/nfeik1SxnFwCdYu5J+Ma2kGNR592
         GmeMv+aGpBEWPX5873vshFxa6mCp2oj/97to3/3iWUtqRKhDbg7Z+FErMibpYj5M7orE
         WEN8nXBaRrWCplSX+wTveuOU4SzH9b4zVDJwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684267660; x=1686859660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yK4aZqvfgO0WJ8XP2YQsUwZXdAoZzrxUjN80rlLt4Q=;
        b=ONtD7K9x4kS/NB34AZpPVUp8yBRYCkZW0PHlhifH9uxS3VYZA8uLLKogTRgY0Gq58/
         3qszJqtKl/77HooDA8Fl4J39hiCUTUUqKQj7CD8kUwuiGEFwCNUhQV28h7kcMqFDg3Yw
         kX+F7kuigL3CSDJUonPYsSIpwvTuV3E0CBSB4oxdYFydkXDtuYDAV3y5EA0xdpz4wedI
         k6jPzn85dWwoqlWoHwPv3+Up38vNZT6utWd3iqD4eUvXXAhkn55CCPDjfXwO/VFmxT6U
         gKKVWAPIN6BhYP94+lb3iBeYE8hSg60vcDR1tNGqxWgNI8vSoIZSxRa25xOoMkRoYwC+
         GrXw==
X-Gm-Message-State: AC+VfDwEX95qguwcvKXihWNuqZMsevsFrtJZ/RFx3neAfYUUmRfhvXeh
        qRZRApSQMzokiwkGiZjwuzjuQA==
X-Google-Smtp-Source: ACHHUZ7u3rq8Nf3VNgH0qCDY5XXjRFg4nCnp6SRHMGYOyrcJwgfTQx+Kt2i9J0Ln1vx5tmCauEmMxQ==
X-Received: by 2002:a17:902:cec8:b0:1ad:c736:2090 with SMTP id d8-20020a170902cec800b001adc7362090mr24149254plg.3.1684267659998;
        Tue, 16 May 2023 13:07:39 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g7-20020a170902868700b001a64c4023aesm15911708plo.36.2023.05.16.13.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 13:07:39 -0700 (PDT)
Date:   Tue, 16 May 2023 13:07:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     jeffxu@chromium.org
Cc:     dave.hansen@intel.com, luto@kernel.org, jorgelo@chromium.org,
        groeck@chromium.org, jannh@google.com, sroettger@google.com,
        akpm@linux-foundation.org, jeffxu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/6] PKEY: Apply PKEY_ENFORCE_API to mprotect
Message-ID: <202305161307.77B29D261@keescook>
References: <20230515130553.2311248-1-jeffxu@chromium.org>
 <20230515130553.2311248-4-jeffxu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515130553.2311248-4-jeffxu@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 15, 2023 at 01:05:49PM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@google.com>
> 
> This patch enables PKEY_ENFORCE_API for the mprotect and
> mprotect_pkey syscalls.

All callers are from userspace -- this change looks like a no-op?

-Kees

-- 
Kees Cook
