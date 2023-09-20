Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD09C00523
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Sep 2023 15:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbjITPX0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Sep 2023 11:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbjITPXY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Sep 2023 11:23:24 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB076CE
        for <linux-hardening@vger.kernel.org>; Wed, 20 Sep 2023 08:23:17 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c46b30a1ceso34759525ad.3
        for <linux-hardening@vger.kernel.org>; Wed, 20 Sep 2023 08:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695223397; x=1695828197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TkhkA2wta3b3NnYgpjyzB6TnKV7qIEnsiYZxlZsQF+0=;
        b=MBdva0ezy4aH5hxL1+DeYTAUe3ISol840sUrBUofMMQKIdLvYFAC5Un/VEDjht7Si+
         zJvRYYRG/9XGGGO36A78OwUoHuUHiYuuEi/7PuVznt0Kxw6bmEdcEPpElwwkG0M5gq7w
         f3I+ry/f75MNL8IuoHJnNta5pU420+/ZZdP7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695223397; x=1695828197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkhkA2wta3b3NnYgpjyzB6TnKV7qIEnsiYZxlZsQF+0=;
        b=AS/+MXnsQ2+Sg327z/E+ck3yqw1Onc5mtq17yZ5MsbwNs9rWyVI2KZ4AzvUNFqGhPG
         cIZFwG2JHeZDrq+oZ1tYtMpDebEwErE2X0B83vCP0wzwsLGXB2BZEjnL5HqPQEHMobxe
         5LkVo3ceFAUmOlzAffof7bb0XllVqg1Dv8wzfg16o7Yq7nJDFK3GBYQCyp70EVao6apM
         RBH8dqbJWhFhO/NO7e56r4l8nlwwodPDnLzc+BAl/HFHsigGAmQiUkP8d1KrP14ZkDeg
         INVqUF1etIvhV3cj0GXSRn7uRazsxPDlSnvXhyZfmsDPVkAnOh02I4vx22FddI/1cdra
         bQAg==
X-Gm-Message-State: AOJu0Yx7EuWVkxv2RSSdKwgx3uol+FQCCwxmunUkotks/IH7nALm/XyN
        WRo/IiH+j2IfZIfn9195b012BA==
X-Google-Smtp-Source: AGHT+IFkoVeBrAYW9kDPx/eSuBBIV9Z60OhCxMdcWJPZ8x/3m5ZPdDQ6YrHAXpAAtVgrL1if+0Xfnw==
X-Received: by 2002:a17:902:ea04:b0:1bf:4a1f:2b57 with SMTP id s4-20020a170902ea0400b001bf4a1f2b57mr3039215plg.13.1695223397249;
        Wed, 20 Sep 2023 08:23:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iz17-20020a170902ef9100b001bbf7fd354csm998170plb.213.2023.09.20.08.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:23:16 -0700 (PDT)
Date:   Wed, 20 Sep 2023 08:23:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Bence =?iso-8859-1?B?Q3Pza+Fz?= <bence98@sch.bme.hu>,
        Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] i2c: cp2615: replace deprecated strncpy with strscpy
Message-ID: <202309200822.67A5B4B61@keescook>
References: <20230920-strncpy-drivers-i2c-busses-i2c-cp2615-c-v1-1-11406a996794@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920-strncpy-drivers-i2c-busses-i2c-cp2615-c-v1-1-11406a996794@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Sep 20, 2023 at 08:08:52AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> We expect name to be NUL-terminated based on its numerous uses with
> functions that expect NUL-terminated strings.
> 
> For example in i2c-core-base.c +1533:
> | dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);
> 
> NUL-padding is not required as `adap` is already zero-alloacted with:
> | adap = devm_kzalloc(&usbif->dev, sizeof(struct i2c_adapter), GFP_KERNEL);
> 
> With the above in mind, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks for the clear commit log! Looks good to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
