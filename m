Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B36FC77B7A
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Jun 2023 16:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjFAQ6m (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Jun 2023 12:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjFAQ6l (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Jun 2023 12:58:41 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2796FE54
        for <linux-hardening@vger.kernel.org>; Thu,  1 Jun 2023 09:58:19 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-650bacd6250so521747b3a.2
        for <linux-hardening@vger.kernel.org>; Thu, 01 Jun 2023 09:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685638693; x=1688230693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKhobPWnbnSn8CDc9kRmjr1ySZ7qWKXo8uFk6p1fSNc=;
        b=Ip4GuH7fzRSkg92E6MBt8yERcsjSIl6SBEW0a6W0BjK4GL0EYHnxVSKP5ft6N1od5b
         lyHo4TZvcaxB5l6uE/2KI1t3v9PNKA0leWBjb0XnBuYyNdBbZM7WdB5K2eoco9pQ6ra8
         Y+kpQcwoPCCWQTIA80IwkReDeWu2zdurcwcVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685638693; x=1688230693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKhobPWnbnSn8CDc9kRmjr1ySZ7qWKXo8uFk6p1fSNc=;
        b=Ll00xhrT4EoNd21cv4xDTB6qKw+WumHm9DOE5YKsaUu/fZcm66vATpnRYMVT7f+YW/
         FwJDEs50rtTiC2DG/uARCuYMLCbx2Rb7InlD6oMqjRTahRbJtzPO2nZbQl6FR7txqvui
         aKK+VuUA9QerdnwC9wsqWPEQOq7HE2dHB59/d9JRRwe+UA2mrsTmkACQzkokOEq7q0Qg
         FhKfldt7Z4gNzBaYJ3HVGZemxaqAk59XRtJSdQTIXJr0V+6f9FiwcSgEqEvOfBzFa1oE
         FKpKHN1GkQ29g+pEs9zhbmBnaHMDYc8NRMxs29EnzzN4UpphWEL3Nz8OXpBVIdYmpqQv
         Izzg==
X-Gm-Message-State: AC+VfDx1KRYZ4j8ZM7MP0he1GUKoB18OQ4Owyj8hs02a1owxPBwEpiKb
        TvPWsH10wY07dVuRbX02OJpvaw==
X-Google-Smtp-Source: ACHHUZ4ocg0kDCSGY6dDEOBfTbyf8G1qcPcG5mE1VEZzsqR4n0GkRXskDTI+ucZpVS7d3MneJ/xEYA==
X-Received: by 2002:a05:6a00:2286:b0:646:8a8:9334 with SMTP id f6-20020a056a00228600b0064608a89334mr8620845pfe.20.1685638692984;
        Thu, 01 Jun 2023 09:58:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n22-20020a62e516000000b006501b37e5e1sm2080978pff.194.2023.06.01.09.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 09:58:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     keescook@chromium.org, hca@linux.ibm.com
Cc:     svens@linux.ibm.com, gustavoars@kernel.org, agordeev@linux.ibm.com,
        linux@leemhuis.info, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        linux-s390@vger.kernel.org, nathan@kernel.org,
        linux-hardening@vger.kernel.org, masahiroy@kernel.org,
        lkft@linaro.org, joanbrugueram@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/purgatory: Do not use fortified string functions
Date:   Thu,  1 Jun 2023 09:58:11 -0700
Message-Id: <168563869054.2890249.18018278036948799346.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531003414.never.050-kees@kernel.org>
References: <20230531003414.never.050-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, 30 May 2023 17:34:15 -0700, Kees Cook wrote:
> With the addition of -fstrict-flex-arrays=3, struct sha256_state's
> trailing array is no longer ignored by CONFIG_FORTIFY_SOURCE:
> 
> struct sha256_state {
>         u32 state[SHA256_DIGEST_SIZE / 4];
>         u64 count;
>         u8 buf[SHA256_BLOCK_SIZE];
> };
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] s390/purgatory: Do not use fortified string functions
      https://git.kernel.org/kees/c/d11f44513655

-- 
Kees Cook

