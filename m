Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97384C25B7F
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Aug 2023 20:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbjHPUvG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Aug 2023 16:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346346AbjHPUuz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Aug 2023 16:50:55 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CB0E69
        for <linux-hardening@vger.kernel.org>; Wed, 16 Aug 2023 13:50:54 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-53482b44007so4248265a12.2
        for <linux-hardening@vger.kernel.org>; Wed, 16 Aug 2023 13:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692219054; x=1692823854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=650OmwVxQhOnYGaICLWTUamQxUV0K9BjBoiNw6Mvi7s=;
        b=AAhdz9azJ1oAOOf7r6f4aE3P1aLiAOHPnMq4+DxUb4yM5ajY/ucvivDufZJOxlboY7
         c3viPCAOkJ3YCxz2Vo8bORzF3++etXaHLM3oRt+Iqff9ZdAjX7OomlQdqVXASfnCjCDv
         suv0aqwPc6Snw44IkYnm91dUUOMnppOT8gbp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692219054; x=1692823854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=650OmwVxQhOnYGaICLWTUamQxUV0K9BjBoiNw6Mvi7s=;
        b=lovxggpql5qeQIJQypLUwerlry6MgAWUAa8Wp+zRz8uZaja0ge4Wt6cbu1a1NamSlF
         79fuGbreCSd7GANNK0I+sCw0ZMWDH6rWu3wOhXKqNYvrl+ITmp2tATPQxwo7aBsXpIaP
         Lq1Ds54sEdJDghGfhyM9GhUGQmBhVzEM5RHjsN+vY0GQtKg1hwYaxdXg5MquYKGAVAZu
         ckRAUZICVMQYa7KlOrbCzkCOCUxpABqtaZrN8bC06WwOH8rMSolA/JSknhSIJcd71mnS
         cqa6/RmBqA0SVU19GamNDpGucykaHkSSor5rLwI3NQnRl6fNHCzAR6jH8ISa/QpeV+3i
         oDyw==
X-Gm-Message-State: AOJu0YySpGE7VJN8bzrmQWySZUZFQjQLCFPo/UR8+JON1Yj09Mkikw0a
        WmwNAllwXyxQQyxzGU67z8dWbw==
X-Google-Smtp-Source: AGHT+IEqIC8uFB+T2j6STILQqPVJdg+D16nCj/MBp4iSoxLRvdmCGlOHHpk8KX1MHi22npP0pNJQgg==
X-Received: by 2002:a05:6a20:a10e:b0:10f:52e2:49ec with SMTP id q14-20020a056a20a10e00b0010f52e249ecmr3698160pzk.53.1692219054128;
        Wed, 16 Aug 2023 13:50:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x7-20020a63b207000000b0055386b1415dsm12394737pge.51.2023.08.16.13.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 13:50:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] um: vector: refactor deprecated strncpy
Date:   Wed, 16 Aug 2023 13:50:50 -0700
Message-Id: <169221904769.1235632.10910494392812070923.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807-arch-um-drivers-v1-1-10d602c5577a@google.com>
References: <20230807-arch-um-drivers-v1-1-10d602c5577a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, 07 Aug 2023 18:22:30 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on its destination buffer argument which is
> _not_ the case for `strncpy`!
> 
> In this case, we are able to drop the now superfluous `... - 1`
> instances because `strscpy` will automatically truncate the last byte by
> setting it to a NUL byte if the source size exceeds the destination size
> or if the source string is not NUL-terminated.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] um: vector: refactor deprecated strncpy
      https://git.kernel.org/kees/c/30bed99e0c63

Take care,

-- 
Kees Cook

