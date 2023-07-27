Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73955C04FDF
	for <linux-hardening@archiver.kernel.org>; Thu, 27 Jul 2023 15:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbjG0PxF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 27 Jul 2023 11:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbjG0PxE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 27 Jul 2023 11:53:04 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373E1271D
        for <linux-hardening@vger.kernel.org>; Thu, 27 Jul 2023 08:53:03 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso8987835ad.2
        for <linux-hardening@vger.kernel.org>; Thu, 27 Jul 2023 08:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690473182; x=1691077982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyEHfmIdAZusP8ylrb9Uotw6HIeOEzJpt2mwB5LGftM=;
        b=AOyRBPlBLg4rTDHqthA9iVzyVTwriLxd/DarITiFHMvZRcJcqlOaf83rJ1gKgUvBFq
         ABNQBLedkj0i3qEgBP2Z7LwfAW2FwQXoFQyFGtjxhWSC3YIdUj74dt52jL5+xhdYF9gd
         q9GUWb224uuvXfAFienpmqsp7ibLIrC6Z5ER4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690473183; x=1691077983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyEHfmIdAZusP8ylrb9Uotw6HIeOEzJpt2mwB5LGftM=;
        b=PFDNRSB7YmrEXWcV5ko37nDGCYW7EtueZiL8hPTAf+RMAkoZOi/7IM45FeI4w2AKN/
         B8vbisqLyRp7sr3EoM73yKd2FvdcdV45vs9EvRiXiDT40CzpgO6wvtOkgPaNXLlnh/ka
         4UAm9fXnC6nWfJcJ90+IV0pXR2Hyxp99trr9g44hJ1asQym4d/iP/uDTiEhO/HJ6eUbp
         yaz86MFp5rEL8r9u2aI4uttoNAmj4zdEj7Iu/wd1r/9eoLzuSDYlna6GBKIjAYJZgWi/
         wZBfB6n8vZCyByC2XKsLZKiMqhD7jqvDBB0wOSTiXCdLQLPUFc8Xsah+/HMKrzuXIziD
         pV6w==
X-Gm-Message-State: ABy/qLZIZasLcZ28jILTBEIDP9OkjGyi+yGa0xwDIIFvg7gK3hzTFhK0
        85IDriqrWKfu5r2mLKy723OO5w==
X-Google-Smtp-Source: APBJJlFoqyR2BKZ04r1FIOAJFPAZ8Ovm5FIqBgpxC7jWT4bd8oyWfIY99FOQVec6GXJfK47I2TYYGw==
X-Received: by 2002:a17:902:dac4:b0:1bb:cd10:8209 with SMTP id q4-20020a170902dac400b001bbcd108209mr5450270plx.50.1690473182764;
        Thu, 27 Jul 2023 08:53:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b001b89c313185sm1807914plx.205.2023.07.27.08.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 08:52:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH] wifi: mwifiex: Replace strlcpy with strscpy
Date:   Thu, 27 Jul 2023 08:52:56 -0700
Message-Id: <169047317161.2400214.15246406234885315012.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710030625.812707-1-azeemshaikh38@gmail.com>
References: <20230710030625.812707-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


On Mon, 10 Jul 2023 03:06:25 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> [...]

Applied, thanks!

[1/1] wifi: mwifiex: Replace strlcpy with strscpy
      https://git.kernel.org/kees/c/5469fb73e96d

Best regards,
-- 
Kees Cook

