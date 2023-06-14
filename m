Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F286EB64D8
	for <linux-hardening@archiver.kernel.org>; Wed, 14 Jun 2023 17:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjFNRtJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 14 Jun 2023 13:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236438AbjFNRtC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 14 Jun 2023 13:49:02 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028E01FCE
        for <linux-hardening@vger.kernel.org>; Wed, 14 Jun 2023 10:48:59 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6668950b6c0so115030b3a.1
        for <linux-hardening@vger.kernel.org>; Wed, 14 Jun 2023 10:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686764938; x=1689356938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rjrKab4vfGxL0dLn3LMbtzN7OEg/16CgMG49/q/se/g=;
        b=eCzeoU8LezyUAvJVYQgqiFYeiiMn3HN0d1MFvlfoQcOtsyJGayKkkfvin8rgYYT0Bt
         VTZZOHWzvvj9xL8WycutB9Jeggr8qAprVQaAIU3ZW8LODkJWI3m7vBx5wSR/27xhbNrw
         9NrPMzZ9s3xIoU7SPD4pN2wH8igILNyC1g9R0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686764938; x=1689356938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjrKab4vfGxL0dLn3LMbtzN7OEg/16CgMG49/q/se/g=;
        b=lvT5Zb74HhOFgFDGnm4mlhPks022noES4bW0ioBhIpJGloNNle5dMxJawu+YNCM5JJ
         PIC2igYV1Noo1/LqAA67b73811czUbvZ0EYgNW13XpKxaZH4FA005Vx7F93BNU7q4Ya4
         YMegA15emKfnJz6XY/lamL6sWVokoCb0uEzL3l2cBWIeVjDpJ8E8dX9tqEonAIxB28R3
         DBYSaDA9yTv7pjg06dP9Aa91ObfkaQW1BZCYRmjEDVNbYsIn4Nn3FJaNni6XFVwI597g
         sBryMON4XQyjzbODBaaPn2BFHayjzMC00G/eIG2dDt0MtTgsDwrJ901YRsFSBj6sAa7c
         dWzg==
X-Gm-Message-State: AC+VfDy8opfgAC5OrMhSXE7490YdCYdNisJuxfk0fnh631/IVZx7Qsk/
        hJD+8uPvlOV7vEXSZlvWS2AAi3FDJuyKLKr7wbg=
X-Google-Smtp-Source: ACHHUZ6/py/DK99QfyP54m1+xWT2yTOI77wGCJA7udeTtjICND/fJZsxj4XWok3Kr4uiaXYP0dhCeA==
X-Received: by 2002:aa7:8892:0:b0:657:e9ae:e022 with SMTP id z18-20020aa78892000000b00657e9aee022mr3031205pfe.5.1686764938500;
        Wed, 14 Jun 2023 10:48:58 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t14-20020a63444e000000b00528da88275bsm11301568pgk.47.2023.06.14.10.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 10:48:57 -0700 (PDT)
Date:   Wed, 14 Jun 2023 10:48:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-hardening@vger.kernel.org, Hongren Zheng <i@zenithal.me>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usbip: usbip_host: Replace strlcpy with strscpy
Message-ID: <202306141048.27FC4B7F3D@keescook>
References: <20230614141026.2113749-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614141026.2113749-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jun 14, 2023 at 02:10:26PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since return value of -errno
> is used to check for truncation instead of sizeof(dest).
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
