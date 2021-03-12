Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCC9C433E6
	for <linux-hardening@archiver.kernel.org>; Fri, 12 Mar 2021 02:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B991A64F90
	for <linux-hardening@archiver.kernel.org>; Fri, 12 Mar 2021 02:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhCLCqg (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 11 Mar 2021 21:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbhCLCqW (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 11 Mar 2021 21:46:22 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E896C061765
        for <linux-hardening@vger.kernel.org>; Thu, 11 Mar 2021 18:46:22 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id lr10-20020a17090b4b8ab02900dd61b95c5eso7798284pjb.4
        for <linux-hardening@vger.kernel.org>; Thu, 11 Mar 2021 18:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3x8wPNWDF/9lMYXSZwL36CZQWnEVZfdICW0j1WUI2Xc=;
        b=Cl5fNZZq/SgrZczxCy+a2QRKYJuXT+6kXJ+VmO2lDHQ7ubzS7ZwXipGTDBJ4dO8rK/
         IeOOI9GOEttF1QSmu0XAOk0Gloj2MZ0Ib6Qz9r+zuLKSHXUz3Xu43XFBqEkBvEB1loN3
         RRkip/PZ0afw6skqKgq8ZCRwgY8XWK2/a3rkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3x8wPNWDF/9lMYXSZwL36CZQWnEVZfdICW0j1WUI2Xc=;
        b=jpO5maOVIbUwRYnn+Efn2Zbwy5okOf9CMBRdGXcYlLaMdfYyZguUaDOVIgRgEY/vck
         D99Swg9SohKO8zFZJ7AoALbATJhsiC/GgAfmB9vRrV8/Dm/SYXJkikjECM07Y/Jz+RCy
         QUgzoFTtdjAuIQcp9J0BWowTos2A7+Anywe3wMtgbo/n8+pQoziPoj5E1xE1ruOtX9aL
         uKaQDbqvDDHVHzxbddAo9BAW5PGe7A5tXAHUVTUkdxAQ3pCEjSV5W5cDZqWEzT4omNw+
         1Y2fITHQ28ioCeImzUK9Pk3qfL+4he/oLPBHSKwkgZzmj9s9KeuSALunSDbaYR11CE9d
         NEfg==
X-Gm-Message-State: AOAM531KEe0VH5ygUKX0dBA8KoRBm7Ibv4AaFaJnY5xd7MksNYbTQOND
        kqwkbXVhQoH4Q0mIbFh2gW2m+g==
X-Google-Smtp-Source: ABdhPJwfiqpEB0ZCSX1blMYrqv2l+v2mx712W/a/L5gcEq6rFAAUBWmeBThCqeCPc6yu/0eVJaAdiQ==
X-Received: by 2002:a17:902:e8c4:b029:e2:b7d3:4fd7 with SMTP id v4-20020a170902e8c4b02900e2b7d34fd7mr10797062plg.73.1615517182025;
        Thu, 11 Mar 2021 18:46:22 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ms21sm409762pjb.5.2021.03.11.18.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:46:21 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:46:20 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/17] arm64: implement __va_function
Message-ID: <202103111846.A6B653A434@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-13-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-13-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:14PM -0800, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, the compiler replaces function addresses in
> instrumented C code with jump table addresses. This change implements
> the __va_function() macro, which returns the actual function address
> instead.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
