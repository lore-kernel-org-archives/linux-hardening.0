Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956C6C433EF
	for <linux-hardening@archiver.kernel.org>; Sat, 14 May 2022 21:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbiENVyF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 14 May 2022 17:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbiENVyE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 14 May 2022 17:54:04 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8892C134
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 14:54:03 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x23so10739986pff.9
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 14:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gDVhI2zku2qZKvaq49DPvnyS72Uf7FU9KhCkFrjajU8=;
        b=S1011jnyYAkqBEEDMxT9syvIhh2zSvV8Zkh+bBVbAiJUkWvxnx5G4QQmkCufpwGOcQ
         /VZM22i7sKGtdqrpwsp9Ytbo3kro9y+f2Y0MIR5yMMRIu0uPZUtRoPywyBZYtRbMJDcu
         uQQpImYc+cjK3PovHb0YXltkeyKprRSzXdKAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gDVhI2zku2qZKvaq49DPvnyS72Uf7FU9KhCkFrjajU8=;
        b=uqvFbypEcIVr32HwfRjr/Z+RRWw7dERGnnyU+PdaoUtjdlvoRdzU9ujxb3Bw/IqwEE
         1dvktihTppVfUfMYwcNu7xPummON91QTNjFhiXZBTUk+wrpytH+Dd0hojl7e92QPrZ66
         ABvcrn8IHO5qWfjpNn8pUIvlTe+XYZky2pM5lnEGeUJ6UqKwzBHnat1nHZ56iYHQI34f
         WITfTcOzDYdPjzdjVX8I90xTzfHXPWzdH9x8/4y55d68/ZaNY+VwPDrKXp//1UOuoGB7
         jNeyzeHzZup82dwaBkteKpwH/+OTD+O1oJD4h1Jjc+nidT38z+RkFwJ5hW44FsYNHBsv
         uKCA==
X-Gm-Message-State: AOAM5320Qdjc1yWx5fqmQyaVlnUbTHyNQCPfunTfZVnMI2kEe+YCU5xJ
        CP1nABYMIZTLN3PEdTMMjTkBFQ==
X-Google-Smtp-Source: ABdhPJy8U7RbEud+2dU/6vQphGcmECzPHMeX+WfFdiNBbxRS9BySOYWWpcCZo0DnGxsttLazJB4nAg==
X-Received: by 2002:a63:f046:0:b0:3c6:a37b:1613 with SMTP id s6-20020a63f046000000b003c6a37b1613mr9503013pgj.168.1652565242585;
        Sat, 14 May 2022 14:54:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b7-20020a170903228700b0015e8d4eb1f8sm4186116plh.66.2022.05.14.14.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:54:02 -0700 (PDT)
Date:   Sat, 14 May 2022 14:54:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH v2 11/21] arm64: Drop unneeded __nocfi attributes
Message-ID: <202205141453.44171359E3@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-12-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-12-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 13, 2022 at 01:21:49PM -0700, Sami Tolvanen wrote:
> With -fsanitize=kcfi, CONFIG_CFI_CLANG no longer has issues
> with address space confusion in functions that switch to linear
> mapping. Now that the indirectly called assembly functions have
> type annotations, drop the __nocfi attributes.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

It looks like there are still other cases that continue to require
__nocfi, yes? It looks like after this series, it's still BPF?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
