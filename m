Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D452C001DC
	for <linux-hardening@archiver.kernel.org>; Thu, 27 Jul 2023 15:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjG0PxC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 27 Jul 2023 11:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjG0PxB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 27 Jul 2023 11:53:01 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC8D2719
        for <linux-hardening@vger.kernel.org>; Thu, 27 Jul 2023 08:53:00 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bb119be881so8967525ad.3
        for <linux-hardening@vger.kernel.org>; Thu, 27 Jul 2023 08:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690473180; x=1691077980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7byZLLYnwmmWu9vINkUL47woFRKOyjYp5fOTgP+wEo=;
        b=igS0GQcrQIveAPQFzyQwhP4qE9bKKyyOHUNPTtX8kf0mYPpW5hcxXhyoW6aFVLRAGK
         PnIJFSi7wAS7PKPxFW52a9A+h3cJAwD9Y3T+/L4Y4HCiSpT38oVotAX+twD/kWsslIts
         U4ldXwQ68/ypzcQdIQzU0lWkdo+eBC28AXxMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690473180; x=1691077980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7byZLLYnwmmWu9vINkUL47woFRKOyjYp5fOTgP+wEo=;
        b=UZdqhiLP2Mgok7ihctwcvjzYspRTdJiRhLsvuSDb6SDd8/yNlmXCdLEZR4YP0xmspq
         StkqIKKUxJSQRRWuACQrPlUV5qWMehEco8z/GvYdjW6MI4+00ZoV1JLTJsf1U3oUmqh1
         0yl/UKDpNN+88/UFnSwh7K5joH3fcED4j7YdKrVxQufHFPIuauPV0Xqn0jRsnjUj6ttm
         SNSiVlPqS43eM05U9nSrtAzZCJ8AjKeR262he8PcTb0lPt8tzYLSGr832tnxBudvApiL
         PD3BUlenv/IoV7arO8GqmaHzHPsaIcw91KQbM8yE75h65MjqrcI+CwGSBQA47eoL5soH
         hXPg==
X-Gm-Message-State: ABy/qLYbFKwVl8oSZh8dnD4VliETeTx7xHIFEcpn55U9IN/k3KqSn9QT
        C93XAN0a19yc/mcajhp1Ht06bkMEewpYJv8tfmE=
X-Google-Smtp-Source: APBJJlFUaN7BXHfPCVb/0lPtSKuhDsKAgK0qZmTjLK5grvf3IvKfatUQ9D7onj/9Lo5gYiBXKBRSgQ==
X-Received: by 2002:a17:902:d2c4:b0:1bb:14e7:4fdf with SMTP id n4-20020a170902d2c400b001bb14e74fdfmr6994875plc.22.1690473179794;
        Thu, 27 Jul 2023 08:52:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903121000b001bb54b6c4e4sm1803002plh.147.2023.07.27.08.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 08:52:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] EISA: Replace all non-returning strlcpy with strscpy
Date:   Thu, 27 Jul 2023 08:52:52 -0700
Message-Id: <169047317160.2400214.17169594909094600573.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706175804.2249018-1-azeemshaikh38@gmail.com>
References: <20230706175804.2249018-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


On Thu, 06 Jul 2023 17:58:04 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Applied, thanks!

[1/1] EISA: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/f2ccf8d13625

Best regards,
-- 
Kees Cook

