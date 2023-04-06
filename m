Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ADBC7618D
	for <linux-hardening@archiver.kernel.org>; Thu,  6 Apr 2023 15:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238976AbjDFP5q (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 6 Apr 2023 11:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236912AbjDFP5p (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 6 Apr 2023 11:57:45 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E58A3
        for <linux-hardening@vger.kernel.org>; Thu,  6 Apr 2023 08:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VegnkIbo9CmAOPKfow/CiCxE7gUBCGZc9DURwdLTrs8=; b=rvAqwWrXXwUi9e7Q5mdiDqjCvs
        gV4kSu7VgHSgSxTTWJtOUVYvkUpW4/OJyYmxoRU/9XQJ7ZunwYPnqkloGlRWTznTOxcWAV7EWYH02
        njXiwbi+D+WHsc4S3B3ks/5CB9uKMDGTmkT63gY/wkmlj9BMOErIUi7hEC28iO5slQ7OOL880LfjG
        JsGubzpixMASSxR8wL2m0rQ1nO8s8qYc+qnwzCuMUxkKhPoLzsE7vi3BpXpH5fv4CGVJxoUiRzUH8
        V2PM2jschHOQvhaZaOdAITtXVFRX8021dgr6PZr6/PYZ/2XT2KS2n6xXM8YULUXvUBN5/NrTs//Vw
        bprEoZ1A==;
Received: from 201-1-127-46.dsl.telesp.net.br ([201.1.127.46] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1pkRzT-008Ccr-4Y; Thu, 06 Apr 2023 17:57:35 +0200
Message-ID: <ee6bcb45-765b-30b8-fa38-a634b58391db@igalia.com>
Date:   Thu, 6 Apr 2023 12:57:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] pstore/ram: Convert to platform remove callback returning
 void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        linux-hardening@vger.kernel.org, kernel@pengutronix.de
References: <20230401120000.2487153-1-u.kleine-koenig@pengutronix.de>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230401120000.2487153-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 01/04/2023 09:00, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks, it makes sense for me! Code-wise, it looks fine.

What would be interesting it to mention a mail thread discussing this or
maybe the patch itself that added the .remove_new() idea
[https://git.kernel.org/linus/5c5a7680e67b right?].

BTW, nice idea - converting all at once would be a terrible sync effort,
I guess this way things will go smoothly.
Feel free to add my:

Reviewed-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Cheers,


Guilherme
