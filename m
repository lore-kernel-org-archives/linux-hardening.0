Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C35C001B2
	for <linux-hardening@archiver.kernel.org>; Thu, 15 Dec 2022 00:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiLOANB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 14 Dec 2022 19:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLOAMe (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 14 Dec 2022 19:12:34 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7304A21882
        for <linux-hardening@vger.kernel.org>; Wed, 14 Dec 2022 16:06:46 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id g10so5094690plo.11
        for <linux-hardening@vger.kernel.org>; Wed, 14 Dec 2022 16:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Io4os3gTaCz4PVaBpjHUj2dUPT6iCaDC19vKypF5Q6s=;
        b=i/gqh+ULBL84l7W+HaI+YPVA3abaIfQIMOgVOnljOmr/KVA68zwjp++CaIKotf3jQg
         ZUOzQKPjmqqy4B/7LyynthiKp6gDWwdZ0BWj+GzLXpD3URXB/Z683HOwIBXxeh93b6GF
         S1iZx+2M8h1CY+bK9AdVvDyvmaaHb+Ig46C2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Io4os3gTaCz4PVaBpjHUj2dUPT6iCaDC19vKypF5Q6s=;
        b=G20HOayUtmO3MKMiCNSrDKtSINMw2zRk+tpGo6MluTKS4qFlq8YU6s4fXYj3+Ul0KT
         ixyyBLLhVWhgSQgE48PsWl18MkivG4RtNTC8CVXygFxNYpaE95Sz9E6i368ZY1oFvFEx
         35mFGGu9XBxQL+w7YSqyE9hGcVCP7UiG9F8DWfUN79fNiJ53RggiLXq//LWdfwlXvmJV
         DZhp7bKRS0BkpCkg1SR8I2A/sEYiYAACRf0SM3emGIan2yc49H5VuctxxYnrsiTXuEEb
         CaZisnbvfCNR7NXVivTz9zul44OnxHO2EA3T5hW1pz2GUUPFVuHSTeAoReGUj7ofDPWx
         W7Rg==
X-Gm-Message-State: ANoB5plvq1V4dGmuXSHKWfddLWBsYgf0ym79/7T7K7inp5H2lbVrwQma
        Hwy4uIfGEjeuiNOC1JQIBVdHiQ==
X-Google-Smtp-Source: AA0mqf7K90bP3UUUfX9ygJAAX4zTnSIy4/T4H3TdPQBfKafxMyTh8efvMuJMEGl3HGTGWDSfjK9dew==
X-Received: by 2002:a17:90a:b908:b0:21a:8c6:c89e with SMTP id p8-20020a17090ab90800b0021a08c6c89emr27261520pjr.2.1671062806002;
        Wed, 14 Dec 2022 16:06:46 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gj1-20020a17090b108100b002086ac07041sm1910624pjb.44.2022.12.14.16.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 16:06:45 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     ndesaulniers@google.com, nathan@kernel.org
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        trix@redhat.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, patches@lists.linux.dev,
        llvm@lists.linux.dev
Subject: Re: [PATCH] security: Restrict CONFIG_ZERO_CALL_USED_REGS to gcc or clang > 15.0.6
Date:   Wed, 14 Dec 2022 16:06:19 -0800
Message-Id: <167106277582.3571286.12639413013649335692.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221214232602.4118147-1-nathan@kernel.org>
References: <20221214232602.4118147-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 14 Dec 2022 16:26:03 -0700, Nathan Chancellor wrote:
> A bad bug in clang's implementation of -fzero-call-used-regs can result
> in NULL pointer dereferences (see the links above the check for more
> information). Restrict CONFIG_CC_HAS_ZERO_CALL_USED_REGS to either a
> supported GCC version or a clang newer than 15.0.6, which will catch
> both a theoretical 15.0.7 and the upcoming 16.0.0, which will both have
> the bug fixed.
> 
> [...]

Applied to for-next/hardening, thanks! (And I'll send it for v6.2-rc1 too.)

[1/1] security: Restrict CONFIG_ZERO_CALL_USED_REGS to gcc or clang > 15.0.6
      https://git.kernel.org/kees/c/d6a9fb87e9d1

-- 
Kees Cook

