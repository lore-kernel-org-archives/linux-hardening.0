Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EF1C433E6
	for <linux-hardening@archiver.kernel.org>; Fri, 12 Mar 2021 02:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAFAE64F8E
	for <linux-hardening@archiver.kernel.org>; Fri, 12 Mar 2021 02:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhCLCpc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 11 Mar 2021 21:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhCLCpM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 11 Mar 2021 21:45:12 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9258C061763
        for <linux-hardening@vger.kernel.org>; Thu, 11 Mar 2021 18:45:11 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so10351210pjb.2
        for <linux-hardening@vger.kernel.org>; Thu, 11 Mar 2021 18:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RwJ0npvlf94WoHHNghlKh7pfAsSY3kaD5+gAJapol+w=;
        b=bpZBKNh/QL9GElmYyMVWjg0TXLHOvRLf/AJusUpMp5M9GhAoX1vyXiQO5qjooDTLBU
         JzoyxgAy+jtXqTW2nhjU+NFbBjWEh9Cnaiik7yl7LEJVvRol9EJH9gFiWziYFuLK0mlG
         LfGHNNjlBiC2I2x4tgijzQUT7YRqmnmrZhpM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RwJ0npvlf94WoHHNghlKh7pfAsSY3kaD5+gAJapol+w=;
        b=Ef0n1ejiw8A0vf1TCK1PwaIy47mTSocvR5WHQVLfYDklW8q1kSGh1tyJHl7D1Li/5q
         ypUxdhoHp8Nddu0U4nLd/nI7Gsf+/wYzCXyNrMo5nTiGsPHz7zXrxHCMk3CnJKShE8Ry
         iTot5HqA1dSibpKykKACb236sCNaz0CdbL9l0QBBrdQTQKFTtYncDmn6GQPtSXoUywC4
         UfIga4PTGy+kxvHdh0pwVPQwi46GnBx4apWa1uPN7/ks85RqCP6t2wtu7GYG0FYR9QJq
         i1a3RzP4bo8k8fwoI0Bu8eoGlBJI6kVw2obULhRpbmjYM5Uj1qrTxmDXeQD9tIKIr10J
         RWCw==
X-Gm-Message-State: AOAM531+mIdW4RnEhzvmhAHSABR/+/xU5UQ++Wb15veVuE1yFlbTjSlW
        cPUjDiJlV6sqpE6LRkfX03wZbw==
X-Google-Smtp-Source: ABdhPJx0aXaKeloHsr9QGNEEDau0lh32ZHQZJQ1m7oA0GayR5TMfTM/IufYD/dXI5ahtsSEzPZ6Xow==
X-Received: by 2002:a17:902:6b43:b029:e6:3d73:e9fb with SMTP id g3-20020a1709026b43b02900e63d73e9fbmr11384932plt.37.1615517111244;
        Thu, 11 Mar 2021 18:45:11 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h5sm3498426pgv.87.2021.03.11.18.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:45:10 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:45:09 -0800
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
Subject: Re: [PATCH 07/17] kallsyms: cfi: strip hashes from static functions
Message-ID: <202103111843.008B935F8@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-8-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-8-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:09PM -0800, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG and ThinLTO, Clang appends a hash to the names
> of all static functions not marked __used. This can break userspace
> tools that don't expect the function name to change, so strip out the
> hash from the output.
> 
> Suggested-by: Jack Pham <jackp@codeaurora.org>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

(Is it possible we could end up with symbol name collisions? ... though
I guess we would have had collisions before?)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
