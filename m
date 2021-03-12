Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B00C43331
	for <linux-hardening@archiver.kernel.org>; Fri, 12 Mar 2021 02:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B170064FA0
	for <linux-hardening@archiver.kernel.org>; Fri, 12 Mar 2021 02:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhCLCpd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 11 Mar 2021 21:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbhCLCpT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 11 Mar 2021 21:45:19 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B70AC061762
        for <linux-hardening@vger.kernel.org>; Thu, 11 Mar 2021 18:45:19 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 16so869428pfn.5
        for <linux-hardening@vger.kernel.org>; Thu, 11 Mar 2021 18:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AssdNLgVnE+ciH4+zO5lxL3YhHsnzigu9rKdFnlTKlk=;
        b=hIQlmeCWP7pIGfJ5QNK11xJD01Ah5yhUwvyA2ww7yhNm+fTC+X7nXsvxCf/cfPJkw8
         nkcI9fivFzWEt/maVUeYndiFDn25FO8B7W04AYR/UDOt3gRYjRZzQNUCnbTnncwE0cZP
         XqXc4TvxtdB2n7+7RQIxaEFd3VdXAy+vdwy6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AssdNLgVnE+ciH4+zO5lxL3YhHsnzigu9rKdFnlTKlk=;
        b=bwf6lB6gVXsgBykG7/TNgPW0twy5g1n7nwDWKPLohp8wqacKXNseRNBDoJHQOEy7L9
         YYVlpUIfpqTK5dwWoyyt1i6klWKxYSKV9EGJmbVw2RYJg+czu/20WCkGP5dE3iDsgQZC
         G6LVBLzBgMMtFN6EfvcCM502+mLPLIXG+wu6BE+5d9P1QlyIcP/77VdTSh/IKKMYOo3W
         9So8JC8fXRCxfjKAJo0LvoO5IDWrzY3/oEBdkU12aGGYil7fDM0oC63lQTnnKT+N16vH
         yzbhHt3JtLkYMGIqp17cwHey1lTujbFA1fK8VtaiGWI9ElcDmOk2UCJBKbEy3x0LUozn
         G+Cg==
X-Gm-Message-State: AOAM531fqrjeBl1MW8hixY27oFJ89GC/3MEgMQrXWZeV4lsw5iRMtPs7
        0/LhZ+tA8/437jnAaKBonRDz/Q==
X-Google-Smtp-Source: ABdhPJxI0qWCdvIWD0Iv1exumtIeT9fGoJnsI5bP8+qNI3aaTbYLPtnoi/Tg5jl4840YLUIassNTiw==
X-Received: by 2002:a63:1e0a:: with SMTP id e10mr9855197pge.3.1615517118872;
        Thu, 11 Mar 2021 18:45:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 14sm3673048pfo.141.2021.03.11.18.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:45:18 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:45:17 -0800
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
Subject: Re: [PATCH 08/17] bpf: disable CFI in dispatcher functions
Message-ID: <202103111845.3A6EEB3E43@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-9-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-9-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:10PM -0800, Sami Tolvanen wrote:
> BPF dispatcher functions are patched at runtime to perform direct
> instead of indirect calls. Disable CFI for the dispatcher functions to
> avoid conflicts.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
