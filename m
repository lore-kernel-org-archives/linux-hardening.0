Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B41C41513
	for <linux-hardening@archiver.kernel.org>; Tue, 25 Jul 2023 09:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbjGYJBN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 25 Jul 2023 05:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjGYJBG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 25 Jul 2023 05:01:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCBEE5A
        for <linux-hardening@vger.kernel.org>; Tue, 25 Jul 2023 02:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690275607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=10mn6aaFkPn0YdbwxtxpcKgA3YVJpkmRIrntoqjJVBU=;
        b=LkmgIj/FtCdgmkwQ48vRnOw9E9gLRfNt1nYr6M1/yHFBF/BeO1wYfFkPPD2bv0zXuHmqc6
        M+X7w6QfzoYUkT9ZCv0UUdMtZFPiOOTRGXX+OGZgeqDGb/xAv/pKkS4p36JCYcObQfDpCC
        HTVKZrvRyvijDEyqNpV2JdVW2VhsrMw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-qHWOfW3jM8ONEAFu_ceGSA-1; Tue, 25 Jul 2023 05:00:04 -0400
X-MC-Unique: qHWOfW3jM8ONEAFu_ceGSA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94a35b0d4ceso362153166b.3
        for <linux-hardening@vger.kernel.org>; Tue, 25 Jul 2023 02:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690275603; x=1690880403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10mn6aaFkPn0YdbwxtxpcKgA3YVJpkmRIrntoqjJVBU=;
        b=Fys7FfpQfjhLCWfZ9YD4VLXlkVuA5UDRgwQO/MBHMp7q4s7ey9T2d5HEcTty6m84dj
         HhcWRrj4zWXwYysLlG+RLsJOlRVNUouwk1QqM9mvsfXcrQQQRHs9Vjk5zJ1j6L2rIpa0
         1twblxCnYmn8B+jVviepRS7Gcb4LOhLIfjV0TzEoiU5BYmbuX9OjFPI7+bG0nout1QNH
         xcEUGyKMnyQXx68IB5t6ogpYraEHUFlja7I/y/KEBsV28DnDCb3TzcbcD8nQhrU/OfeO
         lR486wJrM0TN+UOetZqN57owdBO40WtIzA9dyZUch3+zqStHyD5i/M7o6yOcZHQ0QPKH
         ROsA==
X-Gm-Message-State: ABy/qLYK21jtFh6tIPEtfeFm1Op2Q6dMW9kp9RDu4QlG7iMHGivqqc6B
        AOhLpuEhdeQ/wfOccGBAcXj16FgoLuTIjOY+q3n4iMtU4LW+iW2rv4JMOIEv9786JUOPDqxpjGa
        rL0vBFwzSLlo4WgTRn1V0Cf3ro11S
X-Received: by 2002:a17:906:2d6:b0:992:d337:6e3e with SMTP id 22-20020a17090602d600b00992d3376e3emr11466733ejk.66.1690275603509;
        Tue, 25 Jul 2023 02:00:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGGRHa9OiYuLHkVAuKWwNap43VGDDNMYXat3TofzdFkTyTvlG7SdRfm1oxv0Yahopi3C2MBNw==
X-Received: by 2002:a17:906:2d6:b0:992:d337:6e3e with SMTP id 22-20020a17090602d600b00992d3376e3emr11466719ejk.66.1690275603183;
        Tue, 25 Jul 2023 02:00:03 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id dk14-20020a170906f0ce00b009930308425csm7931335ejb.31.2023.07.25.02.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 02:00:02 -0700 (PDT)
Message-ID: <e0c859de-ff1a-5975-081d-cdb9e4fbcb3b@redhat.com>
Date:   Tue, 25 Jul 2023 11:00:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] vboxsf: Use flexible arrays for trailing string member
To:     Kees Cook <keescook@chromium.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20230720151458.never.673-kees@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230720151458.never.673-kees@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Kees, Larry,

On 7/20/23 17:15, Kees Cook wrote:
> The declaration of struct shfl_string used trailing fake flexible arrays
> for the string member. This was tripping FORTIFY_SOURCE since commit
> df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3"). Replace the
> utf8 and utf16 members with actual flexible arrays, drop the unused ucs2
> member, and retriain a 2 byte padding to keep the structure size the same.
> 
> Reported-by: Larry Finger <Larry.Finger@lwfinger.net>
> Closes: https://lore.kernel.org/lkml/ab3a70e9-60ed-0f13-e3d4-8866eaccc8c1@lwfinger.net/
> Tested-by: Larry Finger <Larry.Finger@lwfinger.net>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Kees, Larry thank you for fixing this while I was on vacation.

The patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Kees, I'm the vboxsf maintainer and it would be easiest for
me if you can include this in a future 6.5 fixes pull-request
to Linus if that is possible ?

Regards,

Hans



> ---
>  fs/vboxsf/shfl_hostintf.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/vboxsf/shfl_hostintf.h b/fs/vboxsf/shfl_hostintf.h
> index aca829062c12..069a019c9247 100644
> --- a/fs/vboxsf/shfl_hostintf.h
> +++ b/fs/vboxsf/shfl_hostintf.h
> @@ -68,9 +68,9 @@ struct shfl_string {
>  
>  	/** UTF-8 or UTF-16 string. Nul terminated. */
>  	union {
> -		u8 utf8[2];
> -		u16 utf16[1];
> -		u16 ucs2[1]; /* misnomer, use utf16. */
> +		u8 legacy_padding[2];
> +		DECLARE_FLEX_ARRAY(u8, utf8);
> +		DECLARE_FLEX_ARRAY(u16, utf16);
>  	} string;
>  };
>  VMMDEV_ASSERT_SIZE(shfl_string, 6);

