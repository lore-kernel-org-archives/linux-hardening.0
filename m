Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8842DC433ED
	for <linux-hardening@archiver.kernel.org>; Wed, 14 Apr 2021 06:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 615296101B
	for <linux-hardening@archiver.kernel.org>; Wed, 14 Apr 2021 06:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349406AbhDNGvw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 14 Apr 2021 02:51:52 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:34830 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349403AbhDNGvv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 14 Apr 2021 02:51:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618383091; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=5wK5vTUbxT5hBJSwMo0gsKaPxssxWSI60OoU8FmvnCE=; b=AvVkcxP6+p/Vk64lsSyuFntExCUXVkK0bPivKjZy7+n+7p+qdfTJzRoUmJNDFyDXdvILwwAd
 iMx14FHjIqsfZWQIr/vlyuRMHvH5szHQ4opXuEm5lHY+3HSUZppcbtNTfWUTfn3lxWfx8yVm
 uANJxVJCo5x5bMma3cL2Uj7Fib8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyIyNzljNCIsICJsaW51eC1oYXJkZW5pbmdAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 607690ef87ce1fbb560c36f1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 14 Apr 2021 06:51:27
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CF557C43463; Wed, 14 Apr 2021 06:51:26 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E29F0C433C6;
        Wed, 14 Apr 2021 06:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E29F0C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 0/2][next] wl3501_cs: Fix out-of-bounds warnings
References: <cover.1617226663.git.gustavoars@kernel.org>
        <9e0972ef-4d42-3896-d92b-01113c445775@embeddedor.com>
Date:   Wed, 14 Apr 2021 09:51:21 +0300
In-Reply-To: <9e0972ef-4d42-3896-d92b-01113c445775@embeddedor.com> (Gustavo A.
        R. Silva's message of "Tue, 13 Apr 2021 16:27:49 -0500")
Message-ID: <87eefdl5p2.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

"Gustavo A. R. Silva" <gustavo@embeddedor.com> writes:

> Friendly ping: could somebody give us some feedback or take
> this series, please?

First patch 2 comment needs to be resolved.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
