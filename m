Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93F2C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Feb 2022 20:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbiBPUfC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Feb 2022 15:35:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbiBPUfB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Feb 2022 15:35:01 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA592A4A02
        for <linux-hardening@vger.kernel.org>; Wed, 16 Feb 2022 12:34:46 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id q11-20020a17090a304b00b001b94d25eaecso3466204pjl.4
        for <linux-hardening@vger.kernel.org>; Wed, 16 Feb 2022 12:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Pdsfe0gyEmDKM5R6mqr1jUT1ZdiKllfIVbOCvrOVopY=;
        b=GqO3BGtvS7W0omx157sqs6ni6O3amemk/DItS/LHtrqA4L13kV5lyQ7j6RIiUaNOhw
         y29Ks3MP3wxKHWL6hgE1e7JTiWVe7ZwqdhO23Bqcxll4rswcr9rzkypRIQC70LMjVedU
         926c/yyIwb2MXUtVMMunPN59htdYvKUKDXdw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Pdsfe0gyEmDKM5R6mqr1jUT1ZdiKllfIVbOCvrOVopY=;
        b=StH4hrfn6cdP2KurQqOogKGRFhYOlZiAHURMm70NS4Wv8q/as+kyqdmy8bsQ/Wlx7n
         /WzkD0QuRWGi+urx9jtBpycDJRhwi5T+KAcQ+8/4RUl6xwfxFVYGEBmXBArAa0B0Mwv1
         IDazouMN6cFVox19SHUTBOdsvOD2nah8UCpjmUwe2/dB3jqcZYn5SENYmEFWhn0ARCUF
         GAksOoR0i21ouVWgg2p6RTBNcfWKfDso8Y017qyKpj1VfDzApLYpGnvNRKvpbisCDyjB
         /sesciYtYgiwpBPk1CNuS4A8ZGseFmSJWXqE9Lo1C2lJJU2ujCQ0H9SGWHF3NoJDNhnu
         qnjg==
X-Gm-Message-State: AOAM533oiufsChbUz33Tunrn4bWtiWuakulzY0nRlo9dgJRtSOdKahG8
        gPTLRpcmNZ7G4dNlS/MH2bAvNQ==
X-Google-Smtp-Source: ABdhPJwdgVBQz/qyf2UdTRXGoq4ewW/DaZkx7WmJn3WoZHGknxkEs553N90vxJHp1bw1lio6Ff29gg==
X-Received: by 2002:a17:902:9007:b0:14f:3680:66d1 with SMTP id a7-20020a170902900700b0014f368066d1mr570949plp.91.1645043685753;
        Wed, 16 Feb 2022 12:34:45 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a15sm5814755pgd.11.2022.02.16.12.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 12:34:45 -0800 (PST)
Date:   Wed, 16 Feb 2022 12:34:44 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] brcmfmac: Replace zero-length arrays with
 flexible-array members
Message-ID: <202202161234.3BCDC5D2@keescook>
References: <20220216194935.GA904103@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216194935.GA904103@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Feb 16, 2022 at 01:49:35PM -0600, Gustavo A. R. Silva wrote:
> There is a regular need in the kernel to provide a way to declare
> having a dynamically sized set of trailing elements in a structure.
> Kernel code should always use “flexible array members”[1] for these
> cases. The older style of one-element or zero-length arrays should
> no longer be used[2].
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Link: https://github.com/KSPP/linux/issues/78
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
