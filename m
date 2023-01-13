Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A32C6379F
	for <linux-hardening@archiver.kernel.org>; Fri, 13 Jan 2023 23:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjAMXRT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 13 Jan 2023 18:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjAMXRN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 13 Jan 2023 18:17:13 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76FA8BA85
        for <linux-hardening@vger.kernel.org>; Fri, 13 Jan 2023 15:17:12 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o13so20357754pjg.2
        for <linux-hardening@vger.kernel.org>; Fri, 13 Jan 2023 15:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdsIIIWmnrAMixIISBlpoonATCB8KyPznTYLn8925xQ=;
        b=mGBAczYsAJy+adnMAbHNwiVeIccSgtfej3hYXu4t8vQ5cWwvI+KY4cabHxROgQCJF8
         /Tv507b65r8jcUIdMQG2W/X0ixqBcO18jVkVskcAHN269V3viF5D4/IogE/F44xFkb/5
         w27pIKt0QRZPNLsnhhipTjrNF+7HKtD7SbWMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdsIIIWmnrAMixIISBlpoonATCB8KyPznTYLn8925xQ=;
        b=mwbCla36rdJmUzMuz/j1a+CtVbzLTYUWg70T5UNiVFbcSJul/iZNFYy3w7dJSpYRu9
         SaMpDEOKTtbJ9tpktM3S75TWMBXOF+DxG8s01T0x5NPw6ynqmWxzQkbhrWN4DQmfdNU8
         +xvqdr/FfC/vfvWj48Nuj0pgSxwgNYB5D4Zwn5UFJWOp6LSuPrrP118djY5Yd0VUsSrS
         smxiYpOFCNwAVymjKTwxNp4ILMldQLcn4d1wxA0R90QuubnzDYawsIScnpH2jx5M/NnH
         jnpAwNnoscHIlzuLX1J43Ee2gyIOvmIIBQxYBXnfybGgVoxcYM1862cQd+3HYUuowd+M
         Oowg==
X-Gm-Message-State: AFqh2koNdfANeO369dfL3ijVy/wvP7ITfBbjaKjGdcqiq4mwJ3FXoorw
        4395wjV7Szr5HjAwDnyYSiymo3TystZx7jNB
X-Google-Smtp-Source: AMrXdXtPUWlNOIlj3oFIw0xfjxn2p+cM+dcDInfA4JSp4huBKlOyhN6ncFOKTB5hYLOeV0bGVtSSFg==
X-Received: by 2002:a17:902:bcc5:b0:192:ce7c:dc40 with SMTP id o5-20020a170902bcc500b00192ce7cdc40mr43176867pls.4.1673651832393;
        Fri, 13 Jan 2023 15:17:12 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id jj13-20020a170903048d00b001928d49bf84sm14616620plb.191.2023.01.13.15.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 15:17:11 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     palmer@rivosinc.com
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux@rivosinc.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins: Fix build for upcoming GCC release
Date:   Fri, 13 Jan 2023 15:17:08 -0800
Message-Id: <167365182646.590977.1702710920825091992.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113173033.4380-1-palmer@rivosinc.com>
References: <20230113173033.4380-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, 13 Jan 2023 09:30:33 -0800, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> The upcoming GCC release has refactored the gimple plugin interface a
> bit and unless gimple-iterator.h is included before gimple-fold.h I end
> up with a bunch of missing declarations when building the stack
> protector plugin.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] gcc-plugins: Fix build for upcoming GCC release
      https://git.kernel.org/kees/c/6d778f2045c7

-- 
Kees Cook

