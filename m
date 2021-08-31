Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0017DC432BE
	for <linux-hardening@archiver.kernel.org>; Tue, 31 Aug 2021 20:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBDD560F23
	for <linux-hardening@archiver.kernel.org>; Tue, 31 Aug 2021 20:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhHaUTo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236197AbhHaUTm (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 31 Aug 2021 16:19:42 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEC9C0613D9
        for <linux-hardening@vger.kernel.org>; Tue, 31 Aug 2021 13:18:46 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 18so244942pfh.9
        for <linux-hardening@vger.kernel.org>; Tue, 31 Aug 2021 13:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r9GlhdKOosTzO8LRW6O4s9OUHVsB4FP+bxUhxdd1GR0=;
        b=aC14HTofppYVFRnQldibqoCSawNZyB3QTtPZsQ5Xl2i/syvuj8VfSSNcb7EJP3CXRx
         OWe5enRZUx9hRSbnxOUDwbKWt8w41283gOFBdZR8lZjPp/eh622bK2yTcNMuhLmnl9iH
         H6eQlQOAb54RKUtP5lPFn0G3Pa04FZSehFVA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r9GlhdKOosTzO8LRW6O4s9OUHVsB4FP+bxUhxdd1GR0=;
        b=um8Sa/P71xN/kkQesMWhsr+NeihfpYVbc3eUxafDmisihHpfRlKZIwUHAlUJtIT8ca
         CMzZfsofmmoo21KJUw/3bgSXxKo2gbIaf7L8tbOpXhZXGdGSSplC3Z9b1Sv1zP+a+teX
         QTZHiOb+XIECrPaWpe3e36wCLzgfZDFwruK5C9CTvffZGqxQeRNih8ImaY7z1i5sJaBM
         Nmk3hrd1XzhgnuadVOnwd3rKd4/2SDX/lYZm/YqyHxyNv2T0RLqWj0RscVTIH6+KEYcZ
         gxfIoAvsBl/C7htZionH56jhakevaIen0LwfcR/1eIhvXdPLPw3RE2pI8OzRHKMYsijP
         LVrg==
X-Gm-Message-State: AOAM530Ojlg/uZukom/3w5/75+CQVS2rP6qiQ4+2BnMwtFnuOB+3rcu6
        XABjU1jizQf6gDovJvBhf8uFGw==
X-Google-Smtp-Source: ABdhPJxUlk5jlKKeD4jMzypYtqK2meJMhtPOJBqKR+4e1VA7wvJwaaCFKtaKWS7ohBKeuH3xgQxHZA==
X-Received: by 2002:a62:ab04:0:b0:405:c1c0:543c with SMTP id p4-20020a62ab04000000b00405c1c0543cmr4085848pff.36.1630441126251;
        Tue, 31 Aug 2021 13:18:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d7sm22416029pgu.78.2021.08.31.13.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:18:45 -0700 (PDT)
Date:   Tue, 31 Aug 2021 13:18:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Keith Packard <keithp@keithp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 4/5] Makefile: Enable -Warray-bounds
Message-ID: <202108311317.DFFFCFC74@keescook>
References: <20210827163015.3141722-1-keescook@chromium.org>
 <20210827163015.3141722-5-keescook@chromium.org>
 <20210831043128.GA2749311@roeck-us.net>
 <202108311042.FFE1818D@keescook>
 <3ab153ec-2798-da4c-f7b1-81b0ac8b0c5b@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ab153ec-2798-da4c-f7b1-81b0ac8b0c5b@roeck-us.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Aug 31, 2021 at 12:40:53PM -0700, Guenter Roeck wrote:
> The configuration doesn't matter; it fails for me for all configurations,
> including defconfig, alllnoconfig, and allmodconfig.
> Key is to use gcc 11.2. The image builds just fine with gcc 9.4 and 10.3.

Ah! Yes, heh. That would be my problem; I've got 10.3 for my builders.
Thanks! I will give 11.2 a spin.

-- 
Kees Cook
