Return-Path: <SRS0=ZjEk=IE=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8332C433E0
	for <linux-hardening@archiver.kernel.org>; Sat,  6 Mar 2021 03:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA57765014
	for <linux-hardening@archiver.kernel.org>; Sat,  6 Mar 2021 03:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhCFDTK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 5 Mar 2021 22:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhCFDTB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 5 Mar 2021 22:19:01 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903ADC06175F;
        Fri,  5 Mar 2021 19:18:50 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id w65so4791794oie.7;
        Fri, 05 Mar 2021 19:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JCDq+uiwLZuYstNdKdn+4e8HqRfAw2eH/rMEXDRybbE=;
        b=JTRFyxLsRecAMj8Q435NNZB4GoPigS+YpFm9a2PBges//gsP/f/x8nallCT8n3J9wb
         IH9KAT1MrDZhjyYgPpyEQDLRIx7K8zm35o9viInXvt95WZn8/NWx5OVUHRnbQ3wiPY5Z
         W/aV+RrGVU9JYhf4QNnJuW3kblSF5XYYPdpIyyWrlfiAhCvNGkxq1URo/+SMx75dSuDA
         NEmAJORGFfz2Xi5yY1a/nYEvdzoQXc7LnAHaGlpuHBlTYSO5aCLk24xWiJEWN43CZvqr
         /TQCMJpAWAIfttc7FtMgJSjLnD1FYiNnvZAJe8pZD9vz3jyOgIoTX2vZ5f2xJryHQ71Q
         A6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JCDq+uiwLZuYstNdKdn+4e8HqRfAw2eH/rMEXDRybbE=;
        b=NbfM4NsuRQGLTP9vanVUNPJ55eu7Dmb9idX7//IzUYG5/IFIgQPSIzJWgA4jeryoSQ
         zSDphyH43XI86apVI2zdgJkWC6ombQiXdCbTFNA75T2wj5BL3WI86RDqOCieViHUs1gz
         aWUjeZEkyNQdJbqOkzrHCLVoRh8kr4pvS47w4AV2VWs/+Y46p+E4sCllY/rQCrOrIukd
         mYzw6sODCskVtqCym4IN2V+1AYK6YstQaBrfx0AGO9JQAbOvmefYB5vrxzddU8dq9D5o
         xhRTqEzrbU+R1XksyyxwMaSK9rkgg9iYBe5ecKHmqMSGuPcnKj/QLfJxRyjTxOaCR0tl
         GDgw==
X-Gm-Message-State: AOAM530N0BaWgJeli4IP6BSleptpoDfFDUIVDcFf7NrOBLIFnKDfHwhA
        iUC+cK4E2/rhhkROb3V5hu9scu3BZyA=
X-Google-Smtp-Source: ABdhPJy2uT+T8viNA0/5UJKBmZXkZdseYpUtXPUB0A1kEe+oXR+fJnvMJooG55/tsHvWBekNBpCCxg==
X-Received: by 2002:a05:6808:128e:: with SMTP id a14mr9706357oiw.71.1615000729991;
        Fri, 05 Mar 2021 19:18:49 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a6sm819970otq.79.2021.03.05.19.18.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Mar 2021 19:18:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 5 Mar 2021 19:18:47 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH RESEND][next] hwmon: (max6621) Fix fall-through warnings
 for Clang
Message-ID: <20210306031847.GA192807@roeck-us.net>
References: <20210305095258.GA141583@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305095258.GA141583@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Mar 05, 2021 at 03:52:58AM -0600, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---

I Acked those, thus assuming that they would be applied through some
other tree. If that is not the case, you'll need to let me know. The
resend only means to me that whatever tree was supposed to pick it up
did not do it, but it doesn't result in any action from my side.

Guenter

>  drivers/hwmon/max6621.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/max6621.c b/drivers/hwmon/max6621.c
> index 367855d5edae..7821132e17fa 100644
> --- a/drivers/hwmon/max6621.c
> +++ b/drivers/hwmon/max6621.c
> @@ -156,7 +156,7 @@ max6621_is_visible(const void *data, enum hwmon_sensor_types type, u32 attr,
>  		default:
>  			break;
>  		}
> -
> +		break;
>  	default:
>  		break;
>  	}
> -- 
> 2.27.0
> 
