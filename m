Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB3CEB64DA
	for <linux-hardening@archiver.kernel.org>; Wed, 19 Jul 2023 15:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjGSPek (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 19 Jul 2023 11:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjGSPej (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 19 Jul 2023 11:34:39 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32792B7
        for <linux-hardening@vger.kernel.org>; Wed, 19 Jul 2023 08:34:39 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2637ab3d8efso4251158a91.3
        for <linux-hardening@vger.kernel.org>; Wed, 19 Jul 2023 08:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689780878; x=1690385678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MPV1Re/rd+Z6hMWojzSFE+4Xhg9XuKRfthuNZEOiK90=;
        b=TGbv0QD5+whT+mL5B2Nq0B4wjifL4ohScRMftR/EWRiiSJgbBwxiti7XaE9aaTnRQh
         VFvPNZejyBYo/tl0a9HSpS8mriI4Qyv1IJCWhqcUbDqwp3EDTYmk6BS3Xxc1UrZ9tb7n
         tyYAMeU5jH5PtX99eGTpSddN8cOnzFd6K5M1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689780878; x=1690385678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPV1Re/rd+Z6hMWojzSFE+4Xhg9XuKRfthuNZEOiK90=;
        b=IUYXchRNKkOHw9k7w64+CLqqFqf674b3BJV2gN+wpYNTNyo2JdDsUtnZoXwyukoQ27
         14xueOJj7EpiH9zbwKvPVJc3uWXFUKZkkbYUBGiOudtXYvD9LeVWVZYmy5ZQZIVM/Ugc
         rT1I2rW5FJXYcbQPgNm3kE4Dfx2kbrHKwN6MaYVTBTtx/2iSL2ThGX9jO9WugYCwbqG6
         LkwZCBQ0s/0wyoiuAJwCwl8Uq68DmtMvzFSPzAVHjGcMVTB1z5HddcRUSDlgE1IkjgQ9
         wjK7L/o8ue55goqyB1uGuWV9mG8PtQS7lKNEcjCcL6EIY0ju88qwrSdNng1S/fH4OPj7
         iBdg==
X-Gm-Message-State: ABy/qLa9Edc6DAGoOK6wm7mVHmzjO7dKUfHaQfBKzKfNB4+n8ECZjsnU
        NSe563Knt/7yTRkCJxw0q0bO5w==
X-Google-Smtp-Source: APBJJlFicfLDTRxX6ghLisFBMbLwtjTFYkuzm3r762d83vl48bjh0KRW/3bGg7458XSr7TcQHvyzaA==
X-Received: by 2002:a17:90a:fa85:b0:267:a31b:d9dc with SMTP id cu5-20020a17090afa8500b00267a31bd9dcmr3865315pjb.35.1689780878535;
        Wed, 19 Jul 2023 08:34:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x1-20020a17090aa38100b00263f5ac814esm1289522pjp.38.2023.07.19.08.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 08:34:38 -0700 (PDT)
Date:   Wed, 19 Jul 2023 08:34:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: Crash in VirtualBox virtual machines running kernel 6.5
Message-ID: <202307190834.A7189ED0@keescook>
References: <ab3a70e9-60ed-0f13-e3d4-8866eaccc8c1@lwfinger.net>
 <202307190823.086EFD42D9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202307190823.086EFD42D9@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jul 19, 2023 at 08:31:08AM -0700, Kees Cook wrote:
> diff --git a/fs/vboxsf/shfl_hostintf.h b/fs/vboxsf/shfl_hostintf.h
> index aca829062c12..243d1b91bb45 100644
> --- a/fs/vboxsf/shfl_hostintf.h
> +++ b/fs/vboxsf/shfl_hostintf.h
> @@ -68,9 +68,8 @@ struct shfl_string {
>  
>  	/** UTF-8 or UTF-16 string. Nul terminated. */
>  	union {
> -		u8 utf8[2];
> -		u16 utf16[1];
> -		u16 ucs2[1]; /* misnomer, use utf16. */
> +		DECLARE_FLEX_ARRAY(u8, utf8);
> +		DECLARE_FLEX_ARRAY(u16, utf16);
>  	} string;
>  };
>  VMMDEV_ASSERT_SIZE(shfl_string, 6);

Oops, this doesn't even compile. Let me get that fixed...

-- 
Kees Cook
