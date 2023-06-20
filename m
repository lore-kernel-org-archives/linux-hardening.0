Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEF9EB64DB
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Jun 2023 20:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjFTU3R (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Jun 2023 16:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjFTU3P (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Jun 2023 16:29:15 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DE71728
        for <linux-hardening@vger.kernel.org>; Tue, 20 Jun 2023 13:29:08 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b53b8465daso22367965ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 20 Jun 2023 13:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687292948; x=1689884948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZA9dgza1t316m8G0sWpsNY6BE+ynDTHmP6tBl5tH3qA=;
        b=CMn9j5Qr0xGH6DPGZmJc+8hF5CS7hFNW/AUBWIcKDkQBdJ5uF/Iv6grWO3k2zaFj5R
         Pcqdzrq3VhdcrvlV/2cztlPSb2r9XJBRdRkJ8sH2KLckg9WUwzrqJmnuo9T18h65CsPj
         Q/sTtqBKU0QjMuls8JQTtSdsBjlIdAXmJUbvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687292948; x=1689884948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZA9dgza1t316m8G0sWpsNY6BE+ynDTHmP6tBl5tH3qA=;
        b=Z64pNDME+n2yslflaFNLYdEhdgjVhInu+aLqFBrQbD55bcOjBj3738gdHgDFU5bS8J
         bvO7v7Kxflf+FvlbQmLFD8S1p9rZFl5mYxxQKHcNOBuEvQF/9CzrSrkwTDkFCeMYUMmb
         iFHM0nP/p5YacO5uQzzfvrpO2USZkADnR7yKqXf77qtHsN0sRQLk0st0FkIs1NOsyC+n
         jkolGeNhDmK7Ec5zw5j7KLQjEOk+f/HdDodHl4xc/VgjZHHUIukI3eT0sLqgjjU+bwl1
         31Qaqg8ZVMC77coOqZ5q9UuIU4W3JiWbWm5yoUSgVgjXmh1sZewkf5ibgGquhkChi1ms
         mP4g==
X-Gm-Message-State: AC+VfDzDhL2KguHASWdHRoSso1r2oDw1OzsJnHG0cXpiZB4Pv/EJIcHq
        w0mimodkl3jEyzwoXbxzKLeoXg==
X-Google-Smtp-Source: ACHHUZ6LzhHQEkbmov28C9WgtfEbYhAG2m29rvQZ0Ua4ICR8aQDGRoXYdt43oeJZee8pqeivB1cpJg==
X-Received: by 2002:a17:903:2311:b0:1b6:6b18:94ff with SMTP id d17-20020a170903231100b001b66b1894ffmr5114043plh.34.1687292948154;
        Tue, 20 Jun 2023 13:29:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c2-20020a170903234200b001b6740207d2sm1990746plh.215.2023.06.20.13.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:29:07 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     fw@strlen.de, pablo@netfilter.org, azeemshaikh38@gmail.com,
        kadlec@netfilter.org
Cc:     Kees Cook <keescook@chromium.org>, netfilter-devel@vger.kernel.org,
        kuba@kernel.org, pabeni@redhat.com, coreteam@netfilter.org,
        linux-hardening@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: ipset: Replace strlcpy with strscpy
Date:   Tue, 20 Jun 2023 13:28:24 -0700
Message-Id: <168729290242.455922.9357942903753232037.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613003437.3538694-1-azeemshaikh38@gmail.com>
References: <20230613003437.3538694-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, 13 Jun 2023 00:34:37 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> [...]

Since this got Acked and it's a trivial change, I'll take this via the
hardening tree. Thanks!

Applied to for-next/hardening, thanks!

[1/1] netfilter: ipset: Replace strlcpy with strscpy
      https://git.kernel.org/kees/c/0b2fa86361f4

-- 
Kees Cook

