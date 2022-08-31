Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BE5C0502A
	for <linux-hardening@archiver.kernel.org>; Wed, 31 Aug 2022 18:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbiHaS2i (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 31 Aug 2022 14:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbiHaS2Q (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 31 Aug 2022 14:28:16 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13009F
        for <linux-hardening@vger.kernel.org>; Wed, 31 Aug 2022 11:24:01 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso66651pjh.5
        for <linux-hardening@vger.kernel.org>; Wed, 31 Aug 2022 11:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=QOzTr0839E3H9tR0wkETuj4b9U9VUvaitz4KI9/r73I=;
        b=EWOrlKJU+LjqRQ/uV9Xua9LvEAnJThp75klKQawBXR3MM0Z+lCfQZzsPiCp50MfMKn
         RrB3LHxP6lWHR8RQlk9SL2/wueb5grQcMqwigHiPfW8os7zYwv5SeTLb6G+whxDTtkF/
         RiTcqxJYXg7XbnnSYwkrDgauuEFFak+11Xl2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=QOzTr0839E3H9tR0wkETuj4b9U9VUvaitz4KI9/r73I=;
        b=0k4unKeOZSqoTrApPGGY+/NbJd6MpZOaH3PjPsFvyLd6ZLALU1OFvdkY4awVlQ6gUV
         BnVKh/f5K/tTnWT6fNqtz8Amqtx3M+nMQwMhFjUMhRYBhPrdNYIe0zf9Ww4bw2bAYveN
         pZY0XuXjcIFwsZIYNdiqH4amn7nVQZ2C9GtHBldemOwulRkXg0EYPaUYv0uexrMSUzMN
         4okV9+l4/4yiq4sQ1MQT+Om9desazMPMTgwsQ/CDyLSvnUdlLXv6uTGHYEnkdWhErKUu
         BiRrUygQYgqJG1lIdhsvwtef5RK+e51piWwiQmhAqR+v95GwWU64poPnThEBvEdDPEr3
         ovGw==
X-Gm-Message-State: ACgBeo3vjTZ/cH5DizLLLj3G74WNZR9hAjl5cNYuCTTn4R/Om33Yw3MO
        2Aia1qrEFAn+UWEg/q0uOj4XgQ==
X-Google-Smtp-Source: AA6agR7ryAbaJQVqp1mJEckyrIip9baCtObI7dR5faSXw3AEvsfrQpKGzAcIiDq8Eww2LkxtypaSAQ==
X-Received: by 2002:a17:902:b68d:b0:172:e973:82b9 with SMTP id c13-20020a170902b68d00b00172e97382b9mr27132898pls.120.1661970241179;
        Wed, 31 Aug 2022 11:24:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z24-20020aa79f98000000b00537f9e32b00sm9156524pfr.37.2022.08.31.11.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 11:24:00 -0700 (PDT)
Date:   Wed, 31 Aug 2022 11:23:59 -0700
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
Subject: Re: [PATCH v4 17/21] kallsyms: Drop CONFIG_CFI_CLANG workarounds
Message-ID: <202208311123.B3B651E@keescook>
References: <20220830233129.30610-1-samitolvanen@google.com>
 <20220830233129.30610-18-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830233129.30610-18-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Aug 30, 2022 at 04:31:25PM -0700, Sami Tolvanen wrote:
> With -fsanitize=kcfi, the compiler no longer renames static
> functions with CONFIG_CFI_CLANG + ThinLTO. Drop the code that cleans
> up the ThinLTO hash from the function names.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
