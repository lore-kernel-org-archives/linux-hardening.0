Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0922C433DB
	for <linux-hardening@archiver.kernel.org>; Mon, 15 Mar 2021 10:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A525764E0F
	for <linux-hardening@archiver.kernel.org>; Mon, 15 Mar 2021 10:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhCOK1i (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 15 Mar 2021 06:27:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229900AbhCOK1T (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 15 Mar 2021 06:27:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 725CA64E0F;
        Mon, 15 Mar 2021 10:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615804039;
        bh=AGwamD92u5AG9ynbGg86ThSmL6JsKPrR25OjmZjqN/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sPq4qge3eoNxFFbYzw2zwdMkpY0+38CyOVqwY20gs7l3aMMi2aVu/wvdkTOcpFiZI
         GEY1Xv2TvR5EtmzUB+mZivU640D3VBwD932VP59u1eQbsxP+ljiKQji7JJJ9dd/cGm
         FGo8wHVxapOXjlLLGmR61BP1H7P4j7y7sASEAbYxzHyfOgQCmOP4nsILzmLeBNizMn
         boUWWiJ3Thedjq54PSg4t21QAPzoZg5LspnTrGgdQuImuoiRSb+hQ9RMeoej2gXK6p
         fugjLIltFvyLqb9sG97jY53C06jsONfyfKku8BftC+Cx0RAYgB9efGaPz28T28PxDK
         KFj9y9a9SYKDA==
Date:   Mon, 15 Mar 2021 15:57:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH RESEND][next] phy: qcom-usb-hs: Fix fall-through warnings
 for Clang
Message-ID: <YE82g5+07IOwRDzl@vkoul-mobl>
References: <20210305100219.GA142595@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305100219.GA142595@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 05-03-21, 04:02, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.

Applied, thanks

-- 
~Vinod
