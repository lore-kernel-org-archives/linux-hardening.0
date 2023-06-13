Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87A7EB64DA
	for <linux-hardening@archiver.kernel.org>; Tue, 13 Jun 2023 19:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjFMTZP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 13 Jun 2023 15:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjFMTZO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 13 Jun 2023 15:25:14 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66341A5
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jun 2023 12:25:12 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b4f8523197so737945ad.1
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jun 2023 12:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686684312; x=1689276312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pF2h1PhbUZCakO9HzT4Rd+vAXkEtKn6aAJnn/Olzk7Y=;
        b=ZU3MjfCE6Bh7fjFg1BjEDJSesHastV05YBYNgqy41DzneH7oHeJm0hjPHEGpA+EXOf
         SG0w/KdxLi/052dMX5jl+FhfITGRS8mugUn3zKE3/eLMipX8oltrWHNWBmc0cN1ljQZj
         mHbEmFHWq7dz7xcNdDtR8r5WSwa8L+3oVanTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686684312; x=1689276312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pF2h1PhbUZCakO9HzT4Rd+vAXkEtKn6aAJnn/Olzk7Y=;
        b=jyOjHKKmzZf0JJowwlm3XTKFepKyNc/KfuSYUwLu41GQfiCqLfjqc6cZcQ0d5Et9oq
         W7RkriqlJqp4pRcqwzMLcw9CYblt+idYH5n24MXfLgtcZ6dV+1nQ6dZPGMi7PWMJ9mIl
         kJ3YPmWpD7577dU+aRY9OaQoizBImxmLyo24cFJUD8QLMHt5hF5VsGSdkz6BKBiMH76w
         bgkAe6LgqiMtTkwacb0beVEqhpYzl/HaFd3Y4FQGXQL/45SUUn3oTa750jDG++Nogxx1
         barR6us/6fuMZE4wHlLSqp4vj8UaK8O+eZuOw4vxZzV5WXKGYDLgzo0SeYtkOWYW0Ahs
         g3IQ==
X-Gm-Message-State: AC+VfDxOW0xH1JaAk1RnuTWafOm2Ml+CPXML54gwi5bQkO/OkHZ/+ys6
        oJP0nSxE7hlINykajTVQqryPtA==
X-Google-Smtp-Source: ACHHUZ5PcTot62BlDuw88kgBfTRj1f+G5oPoENpd58CdgZFu8Kh7kup0ho97mveBi1GFUbg3BuXnpA==
X-Received: by 2002:a17:90a:d252:b0:25c:2a59:fb2d with SMTP id o18-20020a17090ad25200b0025c2a59fb2dmr1703066pjw.8.1686684312104;
        Tue, 13 Jun 2023 12:25:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a194300b00253305f36c4sm12184899pjh.18.2023.06.13.12.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 12:25:11 -0700 (PDT)
Date:   Tue, 13 Jun 2023 12:25:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-hardening@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] mac80211: Replace strlcpy with strscpy
Message-ID: <202306131225.1480125B66@keescook>
References: <20230613003404.3538524-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613003404.3538524-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jun 13, 2023 at 12:34:04AM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since LOCAL_ASSIGN is only used by
> TRACE macros and the return values are ignored.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
