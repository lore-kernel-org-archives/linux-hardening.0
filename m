Return-Path: <SRS0=ZjEk=IE=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611FDC433DB
	for <linux-hardening@archiver.kernel.org>; Sat,  6 Mar 2021 11:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ABB464FEE
	for <linux-hardening@archiver.kernel.org>; Sat,  6 Mar 2021 11:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhCFLm2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 6 Mar 2021 06:42:28 -0500
Received: from ms-10.1blu.de ([178.254.4.101]:40518 "EHLO ms-10.1blu.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230390AbhCFLmZ (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 6 Mar 2021 06:42:25 -0500
X-Greylist: delayed 3763 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Mar 2021 06:42:24 EST
Received: from [37.209.98.109] (helo=marius.localnet)
        by ms-10.1blu.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <mail@mariuszachmann.de>)
        id 1lIULQ-0004nW-5d; Sat, 06 Mar 2021 11:39:36 +0100
From:   Marius Zachmann <mail@mariuszachmann.de>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH RESEND][next] hwmon: (corsair-cpro) Fix fall-through warnings for Clang
Date:   Sat, 06 Mar 2021 11:39:35 +0100
Message-ID: <107682713.BXpLqza3Di@marius>
In-Reply-To: <20210305095359.GA141682@embeddedor>
References: <20210305095359.GA141682@embeddedor>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Con-Id: 241080
X-Con-U: 0-mail
X-Originating-IP: 37.209.98.109
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 06.03.21 at 10:53:59 CET, Gustavo A. R. Silva wrote
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Acked-by: Marius Zachmann <mail@mariuszachmann.de>

> ---
>  drivers/hwmon/corsair-cpro.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
> index 591929ec217a..fa6aa4fc8b52 100644
> --- a/drivers/hwmon/corsair-cpro.c
> +++ b/drivers/hwmon/corsair-cpro.c
> @@ -310,6 +310,7 @@ static int ccp_write(struct device *dev, enum hwmon_sensor_types type,
>  		default:
>  			break;
>  		}
> +		break;
>  	default:
>  		break;
>  	}
> 




