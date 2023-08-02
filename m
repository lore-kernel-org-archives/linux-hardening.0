Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E32C001E0
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Aug 2023 20:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjHBUgM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 2 Aug 2023 16:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjHBUgL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 2 Aug 2023 16:36:11 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA8E2703
        for <linux-hardening@vger.kernel.org>; Wed,  2 Aug 2023 13:36:05 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bba54f7eefso9324375ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 02 Aug 2023 13:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691008564; x=1691613364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bWr3jcRSEU+gA9r0PBD80WJbMi+ArPrQmYYMKJHmB6U=;
        b=nzPAChC03qv+JjeCfHD3Xsgh7kOt1lPa9r4xyzDxMcstE90i2vukMw/8sXH/02aje3
         2otS1qRbhNkAjWyhIbAU++WUZ6yCQqFvvwE0SM4I+99qUJEqDvwnleDRCjb4+gIWskpm
         kT/uFCmzfT6YzJ6Qh64mXRXv8r01SRYwdq9n8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691008564; x=1691613364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWr3jcRSEU+gA9r0PBD80WJbMi+ArPrQmYYMKJHmB6U=;
        b=bO4VcJDnP6fJFoza4WzuItnaFYQtLMXah1QtVopUbDzuqERtd8RIdmBclPzqbjDcsm
         a5p2aJD5ZzQzYWY2sg0ivGSFudKM6LYvC44/x7islbrZaSMrzxe0VSgiBFDhzkOwR6Y6
         0P4/OBTjpNyDOgIFknW8DsL/RU6JjYG+hAuNemtjQ5s1TJgad4yddQCAyxCSCJGsu4bF
         wtjLQjZ/GHgK8KhIhthEoYCv1rZkGeEIkvGUCEKEHSuyja4KLhxqvgN7iSEWMV+tsxGS
         T/hgcK3KMJyZBUsCRoUGJEd2P0sW1hToEnR1pVlUDKpyW+fUpN1BtvcnTl3SZ+JHw49l
         O5sQ==
X-Gm-Message-State: ABy/qLbly3qoOAaFmiJgNP4Y6sxHc4jrtP+MR/r8R63VcfPJc/6/qc9H
        OXzW77sFzUYIGIGuq3lhuUchBA==
X-Google-Smtp-Source: APBJJlHH8aWxfFwHQY80htCurxfVMh/0WroGpPj2sjy9e7ql/D3TXKv/ojhEZ6OgabqItgbTCA1eOA==
X-Received: by 2002:a17:902:c404:b0:1b9:c61c:4c01 with SMTP id k4-20020a170902c40400b001b9c61c4c01mr23391628plk.9.1691008564550;
        Wed, 02 Aug 2023 13:36:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jn13-20020a170903050d00b001b895a18472sm12772104plb.117.2023.08.02.13.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 13:36:04 -0700 (PDT)
Date:   Wed, 2 Aug 2023 13:36:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] RISC-V: cpu: refactor deprecated strncpy
Message-ID: <202308021335.8010D08B@keescook>
References: <20230802-arch-riscv-kernel-v2-1-24266e85bc96@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802-arch-riscv-kernel-v2-1-24266e85bc96@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 02, 2023 at 12:21:58AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> Favor not copying strings onto stack and instead use strings directly.
> This avoids hard-coding sizes and buffer lengths all together.
> 
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

I like it! ;)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
