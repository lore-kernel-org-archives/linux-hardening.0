Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4E2C54EE9
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Sep 2022 14:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiIPOm7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Sep 2022 10:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiIPOm6 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Sep 2022 10:42:58 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645414E607
        for <linux-hardening@vger.kernel.org>; Fri, 16 Sep 2022 07:42:57 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w13so5992342plp.1
        for <linux-hardening@vger.kernel.org>; Fri, 16 Sep 2022 07:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=CczDj0L6fyErXarjYUw/nJButDiDyt2jg/VsMlHD9x0=;
        b=OulnIc0PtMHK6HBr/Ps6pXumK5u3z46zD9qTpwgCt3YZ9WlxymyQYofzW2uXiYqD68
         l+1dCUz9ozdNUjkvCBpAKBX7kXamXafBqAitnxJWe/mgSPrKxR+LqZz1ASr2cVF+MT0i
         FqQW0UwdPP0m9XW+ODPsEEuMnSXwGDAiQYCCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=CczDj0L6fyErXarjYUw/nJButDiDyt2jg/VsMlHD9x0=;
        b=MGRMB4z0+lcCpjNJTXC/yPtWsZo7X5nuK4RLVdu6D1PNsjIIzw3u3LDRRxDWT9Q6DZ
         NQ1+cQ4HHM0PbwzGJMZpV+pjzLBzRco8DHGoezKkb/Y0A4ZjuPXDEHk+0NpbgvWxKFi3
         jsD3wE+qnMxs3JnaGFmuNWomE0V3N+3D6naNWEvHwwRFAio7fGfTQoqfOwGTmFuvR+Ln
         y5119m4vxX4HHVTULry8dzWRkk9I2Otm3tiiLR9s1mNlaZP7bjGNIH9nkJ2WAgPEY4RX
         Yb0gYKwKvlqh3zG5SzNhxv4HCSNqQtSKvN7BCp85coZFXlrInFkoLi1Uz2bTXIYoNC1K
         BQTQ==
X-Gm-Message-State: ACrzQf1K9gdZkBJm0V7ewLfQNW8URxq13F+SWk5bO96X6MASHXX0rckr
        kEitzjDXmTDbrT+oTpYXL3amCg==
X-Google-Smtp-Source: AMsMyM6fN+pgEnc/ncnyOHdVfzsAk03A4QioD6WtmLqIzn6JzDwi9BxnF+gf8QmMz6pDubaM926hUw==
X-Received: by 2002:a17:902:b693:b0:178:5fa6:4b3 with SMTP id c19-20020a170902b69300b001785fa604b3mr170800pls.63.1663339376925;
        Fri, 16 Sep 2022 07:42:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m17-20020a637d51000000b0042ff6b0cf4dsm13491251pgn.58.2022.09.16.07.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 07:42:56 -0700 (PDT)
Date:   Fri, 16 Sep 2022 07:42:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] powerpc/xmon: Fix -Wswitch-unreachable warning in
 bpt_cmds
Message-ID: <202209160742.81BE54E@keescook>
References: <YySE6FHiOcbWWR+9@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YySE6FHiOcbWWR+9@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Sep 16, 2022 at 03:15:04PM +0100, Gustavo A. R. Silva wrote:
> When building with automatic stack variable initialization, GCC 12
> complains about variables defined outside of switch case statements.
> Move the variable into the case that uses it, which silences the warning:
> 
> arch/powerpc/xmon/xmon.c: In function ‘bpt_cmds’:
> arch/powerpc/xmon/xmon.c:1529:13: warning: statement will never be executed [-Wswitch-unreachable]
>  1529 |         int mode;
>       |             ^~~~
> 
> Fixes: 09b6c1129f89 ("powerpc/xmon: Fix compile error with PPC_8xx=y")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
