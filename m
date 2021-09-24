Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103AAC433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Sep 2021 11:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8FAB600D4
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Sep 2021 11:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245747AbhIXLXN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 24 Sep 2021 07:23:13 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:24037 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245440AbhIXLXK (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 24 Sep 2021 07:23:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632482498; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=gShVZAV951WQk1ddVvwaNuu/xkmgZ6qfMXYq5Lm7Zb8=;
 b=wULtDU6ezcaAQMZO09K2jdrQYoniq/OFaTZteIjzfczvXV6ve8ed1pDIDm0Th29Pr3JkY3I0
 CvTr3rH+6JgS4U1rLjs0EpBRV6TCRdP8t2BVYzsRQEq+usLsMwwkOYC6KYEN5HwrLjPohnia
 UA8yXw9qD3YltSqesqrTn81fssY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyIyNzljNCIsICJsaW51eC1oYXJkZW5pbmdAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 614db49cbd9e12ebc5293417 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 24 Sep 2021 11:21:00
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 72C03C4338F; Fri, 24 Sep 2021 11:20:59 +0000 (UTC)
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 19ACEC4338F;
        Fri, 24 Sep 2021 11:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 19ACEC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] brcmfmac: Replace zero-length array with flexible array
 member
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210904092217.2848-1-len.baker@gmx.com>
References: <20210904092217.2848-1-len.baker@gmx.com>
To:     Len Baker <len.baker@gmx.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210924112059.72C03C4338F@smtp.codeaurora.org>
Date:   Fri, 24 Sep 2021 11:20:59 +0000 (UTC)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Len Baker <len.baker@gmx.com> wrote:

> There is a regular need in the kernel to provide a way to declare
> having a dynamically sized set of trailing elements in a structure.
> Kernel code should always use "flexible array members"[1] for these
> cases. The older style of one-element or zero-length arrays should
> no longer be used[2].
> 
> Also, make use of the struct_size() helper in devm_kzalloc().
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.14/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Signed-off-by: Len Baker <len.baker@gmx.com>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Patch applied to wireless-drivers-next.git, thanks.

3fd445a4d49f brcmfmac: Replace zero-length array with flexible array member

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210904092217.2848-1-len.baker@gmx.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

