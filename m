Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF02C433E6
	for <linux-hardening@archiver.kernel.org>; Fri, 12 Mar 2021 02:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC67A64F87
	for <linux-hardening@archiver.kernel.org>; Fri, 12 Mar 2021 02:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhCLCuy (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 11 Mar 2021 21:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbhCLCud (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 11 Mar 2021 21:50:33 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2B1C061764
        for <linux-hardening@vger.kernel.org>; Thu, 11 Mar 2021 18:50:33 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id j6so11221991plx.6
        for <linux-hardening@vger.kernel.org>; Thu, 11 Mar 2021 18:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KIk3Qle+BUsBeCAQycfR+lWVDkST8GkFi9wSAJ/kiAg=;
        b=gaAUqBZl7VidujMHHgtZeA9Q5o5T4yTMa+Mfcm1wWfqy1OpliQkGvD/DCYzfxEeSLL
         mDO9Kkp+4pfOQRwDcV0GOLSdFkIdBuELW21sTwrdxjOLa06icoLqesEfjuRfSfkbNz/7
         TyqTR6nQkuhk2OjDCpKT9lbxEDST5JhduvaJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KIk3Qle+BUsBeCAQycfR+lWVDkST8GkFi9wSAJ/kiAg=;
        b=rddOm/7HLIA/s97s9iRJtljYz3tAor0IXcmSIjvk3/2RKDbrNCeKEZmU3ZH3SB1Xbx
         y6EExcrCa7hlMEOGIP0IG05zATwBDayfVBPNWtfU9ygpADet5gsb9n+3sJb5d9Oyti1a
         JEDj/NvrzqTjp7ks7IVpC+RhZFBeCUNt72B3fJ8+aDhnlMfw3bJrGOO+Xt+/U3RXGMhr
         fsL1JL3P2LRIHWwLeSv38hUz3LTFrAjj2AKRCBtpczDs5Thws1VCgHoOh4oXOQjJyM+k
         vHdDbi66AVT8JDyoSd7Ph7sqdwbQRGaInpo0/aY4Yq/RabG2+cj4H1FNhA2ac7aM6Flo
         95Tg==
X-Gm-Message-State: AOAM530c15zJGfSDncsS0PkcExgetqJy/4zuNhaTuhJWX/6jlh1Y8pTk
        tIrNLslIoiS3tlsGZsXmR/VnhQ==
X-Google-Smtp-Source: ABdhPJw0xZuePYZII/VnCaft+tZdrW5vwu4SWxI9nYaEkp6DHSxNhqBlAcK8pKbEPNeLsU/yPQL/MQ==
X-Received: by 2002:a17:903:2301:b029:e4:9026:4c7b with SMTP id d1-20020a1709032301b02900e490264c7bmr11209369plh.76.1615517432925;
        Thu, 11 Mar 2021 18:50:32 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fr23sm403194pjb.22.2021.03.11.18.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:50:32 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:50:31 -0800
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
Subject: Re: [PATCH 15/17] arm64: add __nocfi to __apply_alternatives
Message-ID: <202103111850.4C29C4C47@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-16-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-16-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:17PM -0800, Sami Tolvanen wrote:
> __apply_alternatives makes indirect calls to functions whose address
> is taken in assembly code using the alternative_cb macro. With
> non-canonical CFI, the compiler won't replace these function
> references with the jump table addresses, which trips CFI. Disable CFI
> checking in the function to work around the issue.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
