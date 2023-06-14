Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97576EB64D8
	for <linux-hardening@archiver.kernel.org>; Wed, 14 Jun 2023 18:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjFNSrd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 14 Jun 2023 14:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjFNSrc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 14 Jun 2023 14:47:32 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CE11BF9
        for <linux-hardening@vger.kernel.org>; Wed, 14 Jun 2023 11:47:31 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b3af7e3925so31681985ad.3
        for <linux-hardening@vger.kernel.org>; Wed, 14 Jun 2023 11:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686768450; x=1689360450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmBNzHd4xcyc4CdrIRgzISzFmerz/N2gTUpIsAvhNYs=;
        b=Kd+j18HppH8gb5RMgj9jyZh6NO1kvl4NlxbxLHiQnWnF3B4mJB0wCVyOAuKUsfc60Z
         xveiHdxE0ZwLjOmOEa26Jg2ysPu/ROd5o7j9DeVaIo9qx4I3RkyG7pFb/VI6iH4BMvBt
         5FKgMJlyrf/Z/22xhetwswkshcgz8HVrA4lCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686768450; x=1689360450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmBNzHd4xcyc4CdrIRgzISzFmerz/N2gTUpIsAvhNYs=;
        b=ekgQT8WUe4PM3rJFXbOageMjBlPnZ1YmrGPV8bwLmPok/6QA0J/hHaehQlj76vqvAE
         1Op2sIn9o2g5x9WEGp6fbENTAzKzBt5a2tkDf7VZcmWkDqtEKCdQy9vbEb8R9Hh1cqFE
         NqSd65Kho1IRZ4/yXkCDXUn61uiMIX3hFr9QHbRMExLWYwk7c20zek3q1PRJYW8YTmFR
         5bf+Fy5LM6eP6GGm+WoHtIjUIDBE6zSqMXdyO+sD6mFRY1XjvRdorS/cz2FAlUM/3sIn
         +x62hTpM52Uu6C4eIoVHwESTzIiymV92FQiduvTZLPhtAo/SiUO/07FqoRmdaJpv7sLj
         R7zg==
X-Gm-Message-State: AC+VfDxtBeoAKXV7PnhrbniJrqXFZU7b/15kJfEY0wypeMR5SHINQZRA
        G0Z2FchZfPmf2O4BTy0NrZTfPQ==
X-Google-Smtp-Source: ACHHUZ7zlhsSV5d4jOAU/rlQfVLCforWzQ+oqs5bRKQb6jc0WqHMV/kuHLcIOdeZ6dHSdFIzRhYBuA==
X-Received: by 2002:a17:902:ecc4:b0:1b2:665:d251 with SMTP id a4-20020a170902ecc400b001b20665d251mr14227281plh.47.1686768450634;
        Wed, 14 Jun 2023 11:47:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ja1-20020a170902efc100b0019a6cce2060sm5905193plb.57.2023.06.14.11.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 11:47:30 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     azeemshaikh38@gmail.com
Cc:     Kees Cook <keescook@chromium.org>, mbenes@suse.cz,
        bpf@vger.kernel.org, maninder1.s@samsung.com,
        alan.maguire@oracle.com, peterz@infradead.org,
        thunder.leizhen@huawei.com, linux@weissschuh.net,
        christian.koenig@amd.com, mcgrof@kernel.org,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, gregkh@linuxfoundation.org,
        christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH] kallsyms: Replace all non-returning strlcpy with strscpy
Date:   Wed, 14 Jun 2023 11:47:28 -0700
Message-Id: <168676844721.1964221.12024901543377074461.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230614010354.1026096-1-azeemshaikh38@gmail.com>
References: <20230614010354.1026096-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 14 Jun 2023 01:03:54 +0000, Azeem Shaikh wrote:
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

[1/1] kallsyms: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/5a5d3a09dd76

-- 
Kees Cook

