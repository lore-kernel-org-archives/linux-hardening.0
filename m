Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95277C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 29 Nov 2021 10:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351932AbhK2Kuq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 29 Nov 2021 05:50:46 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:33601 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351995AbhK2Ksq (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 29 Nov 2021 05:48:46 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638182728; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=M0d4Zf9rLLIPq9EZ9XZQ8e0fDOvwL9WXvTMDoOP2CO4=;
 b=vmWyyGH6Tz+sWiWFE1G1cuPDylma7XUgnglSocMkslnoHTX2FsgSOzByzAuqGv8JOZJNi8lV
 vZde+nIWGy0SVsH++O87XdgdXlNJpXserc/d8Et0kw5/F9i+uzzy6Krz9rUMgY/+3jQtLNmP
 KwilVQzG1JRHlq+oMhLmSf90ac8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyIyNzljNCIsICJsaW51eC1oYXJkZW5pbmdAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 61a4af31465c4a723bb0c9e0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 29 Nov 2021 10:45:05
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8A763C43619; Mon, 29 Nov 2021 10:45:05 +0000 (UTC)
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5DE16C4338F;
        Mon, 29 Nov 2021 10:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 5DE16C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] libertas_tf: Use struct_group() for memcpy() region
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211118184121.1283821-1-keescook@chromium.org>
References: <20211118184121.1283821-1-keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163818270049.17830.12070115902776828737.kvalo@codeaurora.org>
Date:   Mon, 29 Nov 2021 10:45:05 +0000 (UTC)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Kees Cook <keescook@chromium.org> wrote:

> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field array bounds checking for memcpy(), memmove(), and memset(),
> avoid intentionally writing across neighboring fields.
> 
> Use struct_group() in struct txpd around members tx_dest_addr_high
> and tx_dest_addr_low so they can be referenced together. This will
> allow memcpy() and sizeof() to more easily reason about sizes, improve
> readability, and avoid future warnings about writing beyond the end
> of tx_dest_addr_high.
> 
> "pahole" shows no size nor member offset changes to struct txpd.
> "objdump -d" shows no object code changes.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Patch applied to wireless-drivers-next.git, thanks.

642a57475b30 libertas_tf: Use struct_group() for memcpy() region

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211118184121.1283821-1-keescook@chromium.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

