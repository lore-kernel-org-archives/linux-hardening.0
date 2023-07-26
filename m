Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10910C0015E
	for <linux-hardening@archiver.kernel.org>; Wed, 26 Jul 2023 21:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjGZV4T (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 26 Jul 2023 17:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjGZV4S (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 26 Jul 2023 17:56:18 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944331985
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jul 2023 14:56:17 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b8ad9eede0so2260965ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jul 2023 14:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690408577; x=1691013377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTnTPyUChx0sAwZF2MNrXaeFAkRzkrBXS0aTBLLDPZk=;
        b=IWcOTkAilfjO30aVduyx1ux6dmmPLPp6fYwqMlinVp/BNgslgirUI3K6QQoyv1r6DD
         sHjD3GPv76lR4SgFTkxqc7vxAWWLlkH+eiK+gDlw64nGIIYAI9Y1qvparPJGxBIDBb7D
         VGvlXJjMWhOa7FOFji6IA3pwQ77ikVyyRsGew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690408577; x=1691013377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTnTPyUChx0sAwZF2MNrXaeFAkRzkrBXS0aTBLLDPZk=;
        b=a2XQTl7417JJ6wm+dZ+e9xKQqsvYMoWcRyESI9cC0BhnzyDQJF8XFpLWyfabq0LEEZ
         80cRL5VlVs/nMwcJ6PO0Y5kGM6gyuOOZIjFYQENGSWklk/slvGIxnsX0Q6Kku45hkeid
         Qfe3eSIyzjHoyIWr/ai5aQeVR5WF4dDlRGoJHVVnqfOepk2bCncPasFj0WiBXUSY7VdI
         1z3XEqwU9nadO6bTlVod/+cN2Dj9bC/oKOVCDZKwl1dslZqMWghMZb5nFNCiCrExFnCS
         7fJNzfNXZHO+lkV4ZT++iovw1drvVB91laUbekJ4Xyu+vEYqP3k+sgM/T+Kh/VdhkROD
         +gpQ==
X-Gm-Message-State: ABy/qLYUHm6JB6/K3ua4i0erXeao5PUDoZXoRSHYkNKs0+Iiq8xcHUnq
        K7sEhdIf/10EaSbQIvoZf2kTCw==
X-Google-Smtp-Source: APBJJlGTizBLly85YS0wuAFV+YY0tSPJ/d7SY5Zcm8qrRSfPM+8K7M05ND9D80PgFvhVWNLiI5TmsQ==
X-Received: by 2002:a17:903:1cd:b0:1bb:7d2f:7c19 with SMTP id e13-20020a17090301cd00b001bb7d2f7c19mr3117909plh.64.1690408577108;
        Wed, 26 Jul 2023 14:56:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v5-20020a170902b7c500b001b5247cac3dsm32637plz.110.2023.07.26.14.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 14:56:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] vboxsf: Use flexible arrays for trailing string member
Date:   Wed, 26 Jul 2023 14:55:48 -0700
Message-Id: <169040854617.1782642.4557415464507636357.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720151458.never.673-kees@kernel.org>
References: <20230720151458.never.673-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


On Thu, 20 Jul 2023 08:15:06 -0700, Kees Cook wrote:
> The declaration of struct shfl_string used trailing fake flexible arrays
> for the string member. This was tripping FORTIFY_SOURCE since commit
> df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3"). Replace the
> utf8 and utf16 members with actual flexible arrays, drop the unused ucs2
> member, and retriain a 2 byte padding to keep the structure size the same.
> 
> 
> [...]

Applied to for-linus/hardening, thanks!

[1/1] vboxsf: Use flexible arrays for trailing string member
      https://git.kernel.org/kees/c/a8f014ec6a21

Best regards,
-- 
Kees Cook

