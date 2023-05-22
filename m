Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66DFC77B75
	for <linux-hardening@archiver.kernel.org>; Mon, 22 May 2023 19:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbjEVTkH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 22 May 2023 15:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbjEVTjv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 22 May 2023 15:39:51 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FB013E
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 12:39:48 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d30ab1ef2so2844003b3a.2
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 12:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684784387; x=1687376387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CeBiZJ+mkcROTMwzny6Jscg8KAQZlqaxY7QZOK6st8o=;
        b=hPch3qB9RpnmdPFVirVd2RAwofPWHGA9pXFsd2Y98GlpOd3JYNhShIQSeeWZcB+WMs
         Vd2MDXHOuc1aKVfPRk2Sded3e+d6LWrqnTxDKr8zuE8b66EPEOqgmrXBsirm7sYH5aKV
         yuq4KN+/g5NIAOWCKmx2ilvGRMDwokn6BgXpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684784387; x=1687376387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CeBiZJ+mkcROTMwzny6Jscg8KAQZlqaxY7QZOK6st8o=;
        b=NQO5RM1LCc71ygt3XNpK2G0CyiHiBMLDFuKQyT7isVe31jqJOSD6l/VpulzofwPvbA
         t1KDjdaAAIXZxGvn1rd59NNGcw4sgd/tWTSqAzcHkqA5TOqXJTRb0G//pBsXit0tnuuj
         CH8sQYFl1lt1VM4sn3/+nLRU/t1CmPqCCqNCE20nzGLik4Nxjo/m/snmgGdubU3NShnD
         5lFpfjNaQazFW/NSdiNTV8bi9DzuD3H648gXPC1sKPiRKA7bPWHyZ9YZB94Q7OcM+i3i
         k3w4OyuFpv9A13muRWFr5iX0zs2RfZ93Yt0Hv3O0LlzK3+ZvxFmtdFndzjwqwPA0eTEq
         Apew==
X-Gm-Message-State: AC+VfDwxelL9yXwjRz9w0HzZz/cL44BOUv4Fe1CAIFSw8gDw5JIamoKQ
        6lzlpXLSdksBySMf61R9qAR89A==
X-Google-Smtp-Source: ACHHUZ54dSWFhkpL4abI2tgoRFctOL2MElc8Bh2F9GR8ydE32Kjge5WqUJ4f4wGFGOUH03A5KIDV0g==
X-Received: by 2002:a05:6a00:804:b0:647:d698:56d2 with SMTP id m4-20020a056a00080400b00647d69856d2mr15842120pfk.27.1684784387602;
        Mon, 22 May 2023 12:39:47 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u24-20020aa78498000000b0064dbf805ff7sm1504699pfn.72.2023.05.22.12.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 12:39:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     aacraid@microsemi.com, azeemshaikh38@gmail.com
Cc:     Kees Cook <keescook@chromium.org>, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        jejb@linux.ibm.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: aacraid: Replace all non-returning strlcpy with strscpy
Date:   Mon, 22 May 2023 12:39:38 -0700
Message-Id: <168478437625.244538.2849240506920412730.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517143049.1519806-1-azeemshaikh38@gmail.com>
References: <20230517143049.1519806-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 17 May 2023 14:30:49 +0000, Azeem Shaikh wrote:
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

[1/1] scsi: aacraid: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/d966a54946cc

-- 
Kees Cook

