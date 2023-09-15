Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D6EEE3F01
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 05:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjIOFbR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 01:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjIOFbR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 01:31:17 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AE02707
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 22:31:12 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bf11b1c7d0so21183755ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 22:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694755871; x=1695360671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gABgaFjBhZw5TskJOpVAxOP6v/0aRMLwh4GccF5gC38=;
        b=hD8NeGFlbPHn9wKu9MmrgTvXb8isbAQMaz5VJJtYAH26aLsc2OXxF0y+IeErw+Dfee
         V3xx3Jh+ZWBS2sNM4Mukyl7iC810GgTaFDf782gW2hdJO6NeaiH4QSxTE6BBH2Pe8ChX
         2xffsbh4Qm+iZ8R/v0A5TBuVTDUd2FkNlloLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694755871; x=1695360671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gABgaFjBhZw5TskJOpVAxOP6v/0aRMLwh4GccF5gC38=;
        b=IhNmxQt4MIFmjBK5hAjRJ4qAZH14FV7IBWjn/OUKc4sg4ksjugWTJ8qMPhjjwPCF01
         /PLQbIyVsYhdyFskiwEUyJWi8gZnwFWwKHYIsfMEtXjyOKf0tKuaLy21ojQSLQgN2pgd
         P7+Xh80O5BIzFby+/L4ZGCT3b1GO24FhFWoK0BTo/5JyCeHyDT0GXJebkQ2BYHbw8Ppl
         EDK6a6HGZf6coGcWm8NyDytygyiA2gQps1sf9w5vPGi9qZ/3quVaUp7DJ45PyLtF2r41
         61fi5eF6rwPijtogFi6IZfsc4pCX2S0c5BZMEhYqNoBeyEkqP1Wk8GPGoVayxoV3Ofg6
         Uvew==
X-Gm-Message-State: AOJu0Yy3g/DZHBDbX+pdqcCAvG2HCxWeOeesfeidJxeI/PZh157Ksa/Y
        nVjQX6GNfjACbOoBdOP1XhSHZtYbo4cheqp+nsI=
X-Google-Smtp-Source: AGHT+IHpVgWK/GmH1DICoQbxiecZxWXuSxkFKfmb21BW9q/zQk8/UqPup0v4SVD2yLhi2zjN0IDhow==
X-Received: by 2002:a17:902:e5cd:b0:1c4:5a9:a45e with SMTP id u13-20020a170902e5cd00b001c405a9a45emr1032547plf.27.1694755871472;
        Thu, 14 Sep 2023 22:31:11 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q11-20020a170902dacb00b001bde12178b4sm2524463plx.33.2023.09.14.22.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 22:31:10 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH] init/version.c: Replace strlcpy with strscpy
Date:   Thu, 14 Sep 2023 22:31:04 -0700
Message-Id: <169475586230.4081099.16940913088355099799.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830160806.3821893-1-azeemshaikh38@gmail.com>
References: <20230830160806.3821893-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 30 Aug 2023 16:08:06 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] init/version.c: Replace strlcpy with strscpy
      https://git.kernel.org/kees/c/ec23bc09c1c0

Take care,

-- 
Kees Cook

