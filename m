Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734BEC433FE
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Feb 2022 20:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiBPUfd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Feb 2022 15:35:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiBPUfc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Feb 2022 15:35:32 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD092A414C
        for <linux-hardening@vger.kernel.org>; Wed, 16 Feb 2022 12:35:17 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d187so3089208pfa.10
        for <linux-hardening@vger.kernel.org>; Wed, 16 Feb 2022 12:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KtRcf8spwupfWXx3ppHGUao3iJAoVb7Xdyi2Swh8EQg=;
        b=QRbl0vlrkn+en8seDm6Fp7XKxcRlzQrFbbDLDGp7jPj9U+ZaXloFtJ9mNDe2ngzggR
         ZmjoG4A1HmJX1NLSMOkwsZ++Rl342st+uklMLse0z2L7j6XCBx39yCBlSNjSQGJOLEjL
         mDeMAo7zcUsGgHCZEg11xdguXIu8HBF9fP+QY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KtRcf8spwupfWXx3ppHGUao3iJAoVb7Xdyi2Swh8EQg=;
        b=ECUNo4dbjgeCWFdtnUCs+XgRSJUmyyXskr3OUPZp68KT/O1mUjzhIWIf+GSZagAiX4
         FHeDE2xrJmmeyF8s0GFfW66R+Mb/CHD/1onSBjKtrTR1bdJXbaKdssFG89eQ9YMIlQ29
         cgRgNM9pi827Wt0YnM7oPZA8n8vcKh/D1FKDQxtg6vaPbCbh9JjxV6HvO+xNPulcD+0j
         Y/dNDr8093AeLW+6l8YPLwQ18JfvFBL/cQGrnMM4QI01fjNMofIRkI7GP8B7zQwPvp7a
         tOKYCUP760gYLiQJ1m3L0kbnw6lK7DASWzzfP5n0xGywDT2RgL4uyf9jZj1kgB2llxaH
         Hy6Q==
X-Gm-Message-State: AOAM533e54exHUgZ1QroxTcro66Ht/GFMf8hbtoDnJWAK85dZFnwSV61
        /8LIp5/F/VQres7RF3KINuAt2g==
X-Google-Smtp-Source: ABdhPJzpUqye00ePhdV10IGfo3yDMvRuXibACTdpct9tBS2QY1o/hcdO5DvGhO1nkGq1iwWh41N3Ag==
X-Received: by 2002:a05:6a00:1a04:b0:4e1:786c:cce3 with SMTP id g4-20020a056a001a0400b004e1786ccce3mr4876730pfv.81.1645043716908;
        Wed, 16 Feb 2022 12:35:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x5sm20603941pjr.37.2022.02.16.12.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 12:35:15 -0800 (PST)
Date:   Wed, 16 Feb 2022 12:35:14 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] iwlwifi: fw: Replace zero-length arrays with
 flexible-array members
Message-ID: <202202161235.2FB20E6A5@keescook>
References: <20220216195015.GA904148@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216195015.GA904148@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Feb 16, 2022 at 01:50:15PM -0600, Gustavo A. R. Silva wrote:
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
