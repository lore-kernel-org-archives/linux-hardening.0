Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C1FC433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 11 Oct 2021 06:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D325760EE7
	for <linux-hardening@archiver.kernel.org>; Mon, 11 Oct 2021 06:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbhJKG1n (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 11 Oct 2021 02:27:43 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:53903 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234121AbhJKG1n (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 11 Oct 2021 02:27:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633933543; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=vqRerw6jepTKl0s7qcA0sRoOaWNZI36gX/8yJK4zDK0=;
 b=UKYSLZuOPQdgzcGdOVFcHQlQO7uIe4Cq/ItO5HiT9B4cq7Tcel1+8ZIs68fQvUYfLPOnYEGa
 fNyoC4WAhwdwygehdC+LGHhDaYUsCadJXuvLdrBUdoojeSBJvIuIuvG7ZId061Xm8AGGEof3
 KTxFYgR0lYx12A3wU7iyJsqCAkY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyIyNzljNCIsICJsaW51eC1oYXJkZW5pbmdAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 6163d8ce060523968994a01f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 06:25:18
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 92C0BC43616; Mon, 11 Oct 2021 06:25:17 +0000 (UTC)
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2691BC43460;
        Mon, 11 Oct 2021 06:25:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 2691BC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH][next] ath11k: Use kcalloc() instead of kzalloc()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211006181204.GA913553@embeddedor>
References: <20211006181204.GA913553@embeddedor>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163393351300.20318.18394119881469164997.kvalo@codeaurora.org>
Date:   Mon, 11 Oct 2021 06:25:17 +0000 (UTC)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> Use 2-factor multiplication argument form kcalloc() instead
> of kzalloc().
> 
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

ec4363384c3f ath11k: Use kcalloc() instead of kzalloc()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211006181204.GA913553@embeddedor/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

