Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D54C433EF
	for <linux-hardening@archiver.kernel.org>; Sat,  2 Jul 2022 01:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiGBBCu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 1 Jul 2022 21:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiGBBCt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 1 Jul 2022 21:02:49 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A247A5A448
        for <linux-hardening@vger.kernel.org>; Fri,  1 Jul 2022 18:02:48 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c13so84713pla.6
        for <linux-hardening@vger.kernel.org>; Fri, 01 Jul 2022 18:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+QLbq0w+CZfYo6/BgLDLv123MX+VJmesqUpPeKC97pk=;
        b=WOVRwA7HSikldTi++/cqjLgkGyx1K0hCf5nuW4OrFlAXhnRTSF+Y/yNNej6ML6yzcE
         V6nLGsFv65rOYWATYTvQBSr/zmmYpBIMTmmdr5IW1yWU/C9qqD6ZjH2/SBxE8T2AFOnb
         kI4fj3fTeYBB7YR2SCUhm9s0bMSGtNGi6k09c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+QLbq0w+CZfYo6/BgLDLv123MX+VJmesqUpPeKC97pk=;
        b=KPq5AwLpAbghyfgEEHWSjQUTawvw4LlgVM3x/x75M5mcZk5EsYzXdtRUHneVxF1Am8
         qkJJPPZYren4F+EzSDLewhER8tzM4qaTnQYAAQY9BLeZUeUEiRDW1cYHZOI71U9z/xTa
         Iwp0nY9vHw3/ELaSZwBceO+7Vkvguz+XHVCPaRqmCDIJ06BVwreIsE5EOw8FT5P+lzDv
         bRgsKxqLOdoRCqsT0wff4XUh8YjQHhB4n4BWKuOXASFxlVI3xL17uea+aFL/yAv4OGWx
         kUyvW+QDvo4Sh/g7I37S3vMd5fZEM4pp8H8f6wt+LVIivLcCnD03hobgV8oGJ8ZElxSh
         AQMw==
X-Gm-Message-State: AJIora8Z73WrxWTF4pHJteGyVc9jlPzDV4K3VvczXl4t1ips4fsDD1vp
        gne4agb2jY+LdRyZBatS0vAy8w==
X-Google-Smtp-Source: AGRyM1vr8gIh5aKj2l7LLWkGGNi1HXOfn7r3prwi2OEXDiHlxyrQv2BZHDG3gbMUAKS+m12eq68kNQ==
X-Received: by 2002:a17:902:ea07:b0:16a:2833:3207 with SMTP id s7-20020a170902ea0700b0016a28333207mr23231909plg.86.1656723768114;
        Fri, 01 Jul 2022 18:02:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g10-20020a170902934a00b0016a11b9aeaasm16113169plp.225.2022.07.01.18.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 18:02:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     gongruiqi1@huawei.com, elver@google.com
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, christophe.leroy@csgroup.eu,
        xiujianfeng@huawei.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] stack: Declare {randomize_,}kstack_offset to fix Sparse warnings
Date:   Fri,  1 Jul 2022 18:02:43 -0700
Message-Id: <165672376092.2486882.1451446093485208376.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220629060423.2515693-1-gongruiqi1@huawei.com>
References: <20220629060423.2515693-1-gongruiqi1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 29 Jun 2022 14:04:23 +0800, GONG, Ruiqi wrote:
> Fix the following Sparse warnings that got noticed when the PPC-dev
> patchwork was checking another patch (see the link below):
> 
> init/main.c:862:1: warning: symbol 'randomize_kstack_offset' was not declared. Should it be static?
> init/main.c:864:1: warning: symbol 'kstack_offset' was not declared. Should it be static?
> 
> Which in fact are triggered on all architectures that have
> HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET support (for instances x86, arm64
> etc).
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] stack: Declare {randomize_,}kstack_offset to fix Sparse warnings
      https://git.kernel.org/kees/c/375561bd6195

-- 
Kees Cook

