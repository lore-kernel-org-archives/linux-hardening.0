Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E24C7EE30
	for <linux-hardening@archiver.kernel.org>; Mon, 22 May 2023 19:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbjEVTkJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 22 May 2023 15:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbjEVTjw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 22 May 2023 15:39:52 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27CC10C
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 12:39:48 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d3bc502ddso4048067b3a.0
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 12:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684784388; x=1687376388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15lSZRZhXLomY0U2NRYU9uW0smeWq7pcEslVONXUi3w=;
        b=lultQqiUKak9FMfr0vvzZAvgIXLahXbv5eD+ktyGdatLnupmEkRIwq1R7iynCFDvLF
         d4V/iTwrrsjmy80BI5rWes1qfOx6WerIwlALEf6vtMklt0JtxgI6EkCX/c9fLAGYnUg4
         FOpegxkkgYbK2Fg7VNn3VDHsWLoR8IeuaLj4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684784388; x=1687376388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15lSZRZhXLomY0U2NRYU9uW0smeWq7pcEslVONXUi3w=;
        b=Kpp/H1KZk46JJpD3E15ufLRo5yLVoIEERNM8VKc+yyBp1H3j65d6ldvlXThV03NPI4
         ZQK+aKYsG58ClQdIN7ntNEKIvw1KRV6UHW1UGw3Zd2ffqeKGaPOMezRfYbTKSmTzMt7R
         G4+0XfwL7DHEiaCN/PUFdLUz3UQA5k3+Ppy/lwtfGMncroPgVn6qQairIMB3UonlNknA
         ImiMG9CwoPLgHRMQWyeE/raJkVMMj1N7dQJXYa8c8XxVsgkvTShBI7UO/7Oq1U4X3Uyp
         WZ5KJ31qx26Y1HGGIW6tndIthbsB0hpdBZKoSJWjzwcpHjvNCqL2I4G+GKiiYZLlPm9m
         5gMA==
X-Gm-Message-State: AC+VfDyMkq9gfSitZu61x3RGDQdmyEu5dKdkEQ4gdy9U7CQwE05pVcZR
        nZw0bxsuGrdOApcVbTq+f7zv8w==
X-Google-Smtp-Source: ACHHUZ4kzfOePZUuovzfabT8AgRib6y/nHwVGmMvBg8fdTKcPNszB02HKZi7Ot66DeoLW/DPcx7wKw==
X-Received: by 2002:a05:6a20:549d:b0:10b:bf0e:3bda with SMTP id i29-20020a056a20549d00b0010bbf0e3bdamr3899463pzk.2.1684784387947;
        Mon, 22 May 2023 12:39:47 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i24-20020aa787d8000000b0064d3e4c7658sm4602374pfo.96.2023.05.22.12.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 12:39:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     azeemshaikh38@gmail.com, teigland@redhat.com, ccaulfie@redhat.com
Cc:     Kees Cook <keescook@chromium.org>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] dlm: Replace all non-returning strlcpy with strscpy
Date:   Mon, 22 May 2023 12:39:34 -0700
Message-Id: <168478437619.244538.1491421946258356417.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230510221237.3509484-1-azeemshaikh38@gmail.com>
References: <20230510221237.3509484-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 10 May 2023 22:12:37 +0000, Azeem Shaikh wrote:
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

[1/1] dlm: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/30ad0627f169

-- 
Kees Cook

