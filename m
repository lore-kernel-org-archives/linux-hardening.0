Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A21C4338F
	for <linux-hardening@archiver.kernel.org>; Tue, 17 Aug 2021 23:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97A7E61008
	for <linux-hardening@archiver.kernel.org>; Tue, 17 Aug 2021 23:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229466AbhHQXh5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 17 Aug 2021 19:37:57 -0400
Received: from gateway20.websitewelcome.com ([192.185.49.40]:34936 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236442AbhHQXh5 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 17 Aug 2021 19:37:57 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 532C8400D27EB
        for <linux-hardening@vger.kernel.org>; Tue, 17 Aug 2021 18:20:16 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id G8e2mpL1FMGeEG8e2mpgC0; Tue, 17 Aug 2021 18:37:22 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AzVDzK8a1EEVePdeojHw8a1gJ0hcdK6QJHkvzwsDxKQ=; b=cFdaytldjPLnPidWap/zvaUh+s
        DQNHq3Mbh59DJZ32pXWxDEQtjJ7Av/iwnObHqrh+HvSXI+MeUryFg5UkkmXc9FDllFn5dXs0npLlG
        GY2vE/itqS/iFQQeCSnLc7wtbNoybTIP1mYCVCJOpHhItLyx2NPhXjTvURMvxY8a6/lA00odCJNx3
        xHj39mxLjVvj0+2Wwr2pAIIXpbpKiOcQcpC/9OumnuSaZGfQAzb8ZTmolHLWIWCKOUCGneXOx91BV
        YDTsr+J38QeY0KUkvTBMJuMg1ptKc3DVWNQy5HopKjt+TaHbNZXmD9Ii3gqKv5eRCY6at1rSiZArv
        0aLDxiQQ==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:44668 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1mG8e2-001l7W-2S; Tue, 17 Aug 2021 18:37:22 -0500
Subject: Re: [PATCH] kbuild: Enable -Wimplicit-fallthrough for clang 14.0.0+
To:     Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Philip Li <philip.li@intel.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-hardening@vger.kernel.org
References: <20210817005624.1455428-1-nathan@kernel.org>
 <80fa539a-b767-76ed-dafa-4d8d1a6b063e@kernel.org>
 <CAHk-=wgFXOf9OUh3+vmWjhp1PC47RVsUkL0NszBxSWhbGzx4tw@mail.gmail.com>
 <5c856f36-69a7-e274-f72a-c3aef195adeb@kernel.org>
 <202108171056.EDCE562@keescook>
 <3f28b45e-e725-8b75-042a-d34d90c56361@kernel.org>
 <CAK7LNAQFgYgavTP2ZG9Y16XBVdPuJ98J_Ty1OrQy1GXHq6JjQQ@mail.gmail.com>
 <71d76c41-7f9b-6d60-ba4f-0cd84596b457@embeddedor.com>
 <202108171602.159EB2C7EA@keescook>
 <72ae69b4-6069-ade5-a12b-8ee0435f803a@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <1f05cd38-c576-0ded-81b6-fe0b49a5059e@embeddedor.com>
Date:   Tue, 17 Aug 2021 18:40:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <72ae69b4-6069-ade5-a12b-8ee0435f803a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1mG8e2-001l7W-2S
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:44668
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 8/17/21 18:23, Nathan Chancellor wrote:
>>>> # Warn about unmarked fall-throughs in switch statement.
>>>> # Clang prior to 14.0.0 warned on unreachable fallthroughs with
>>>> # -Wimplicit-fallthrough, which is unacceptable due to IS_ENABLED().
>>>> # https://bugs.llvm.org/show_bug.cgi?id=51094
>>>> ifeq ($(firstword $(sort $(CONFIG_CLANG_VERSION) 140000)),140000)
>>>> KBUILD_CFLAGS += -Wimplicit-fallthrough
>>>> endif
> 
> Very clever and nifty trick! I have verified that it works for clang 13 and 14 along with a theoretical clang 15. Gustavo, feel free to stick a
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> 
> if you so desire.

Yep; I just tested it locally with clang 13 and 14, too.

Thanks
--
Gustavo


