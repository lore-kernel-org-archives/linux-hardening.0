Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF08C6FA8F
	for <linux-hardening@archiver.kernel.org>; Wed, 30 Aug 2023 20:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjH3UCQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 30 Aug 2023 16:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjH3UBz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 30 Aug 2023 16:01:55 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8773A83EA
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 12:39:27 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6bca66e6c44so150009a34.0
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 12:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693424308; x=1694029108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YZMBO3cq35PjwKKIG6m42W7fw7Uuq0v6gb0qcGM7SrQ=;
        b=kis29l2Was+G6178u/jq1kWxzBrTaifsgvANFvXAu4W4VB2k+iH66qnwpNhVr/xhCv
         eHlcIXiQIr5p+xJIe4O5inQj1f9rxbr+7GhBhOZ+wAckjyycvKF0MgheY59BZExfJVka
         4Qvr8MzJdSZQNpJ3fjVxEkvY4JI1KW0mN+wvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693424308; x=1694029108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZMBO3cq35PjwKKIG6m42W7fw7Uuq0v6gb0qcGM7SrQ=;
        b=GTMWqYtXPcyE2FClLbdSIVXsuBS2QOc7s8/sy5f4Yy4njPwXspprPtNRNboAPAAoky
         onvnkImYmo4QeffaJWYgJZ9KUak4yfja5iYPiqBZXsOoh/fQvo7+uRdOK9uEIDa2HN4I
         SBB5D5AWB7Ey3ezl5Zzl/1E/omawsIl+ASjoaQ389A2YhDPnBPlojdXjzdtQhBrCJB3Q
         BNwd/VQSjAjLwRXPfSYAbdkEQCqXK5otflffc6Ejl+S2ob1MIycvpQXsqMLHkN49/P5I
         2DCr+mM7Hcyo5EZShF40uW61pXTTWIsiDOsEvsqf7EAiBMLKdF3h8PxzRRS6nP4x2apf
         vazQ==
X-Gm-Message-State: AOJu0YwIW6/+2rN0j4bxzYSz7xY0Q9RduR8vBicAERreo/Dte9LoFkQZ
        uIiYwPqXl8vKz7cFtm8jmwnAbkdMvfHpQH2zCUw=
X-Google-Smtp-Source: AGHT+IGykiElXISO5VTbxBJsqAwOC0C4+ZKKK6xBNTjZEalBwc53bWlt/bicp+NzrhLj4nYHS0HvIg==
X-Received: by 2002:a05:6a00:1ace:b0:68b:dfef:de8f with SMTP id f14-20020a056a001ace00b0068bdfefde8fmr3255663pfv.12.1693423625426;
        Wed, 30 Aug 2023 12:27:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g10-20020a62e30a000000b00688965c5227sm10324255pfh.120.2023.08.30.12.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 12:27:04 -0700 (PDT)
Date:   Wed, 30 Aug 2023 12:27:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] vt: Fix potential read overflow of kernel memory
Message-ID: <202308301222.3BD87A6@keescook>
References: <20230830160410.3820390-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830160410.3820390-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 30, 2023 at 04:04:10PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.

Perhaps add:
"... and returns the size of the source string, not the destination
string, which can be accidentally misused."

> This read may exceed the destination size limit if
> a source string is not NUL-terminated [1].
> 
> The copy_to_user() call uses @len returned from strlcpy() directly
> without checking its value. This could potentially lead to read
> overflow.

Since the code as written today is "accidentally correct", it's worth
clarifying this: there is no existing bug, but as written it is very
fragile and specifically uses a strlcpy() result without sanity checking
and using it to copy to userspace. (This is the exact anti-pattern for
strlcpy(), and only because the source strings are known good is this
safe.)

> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
>  drivers/tty/vt/keyboard.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index 358f216c6cd6..15359c328a23 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -2079,12 +2079,15 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
>  			return -ENOMEM;
> 
>  		spin_lock_irqsave(&func_buf_lock, flags);
> -		len = strlcpy(kbs, func_table[kb_func] ? : "", len);
> +		len = strscpy(kbs, func_table[kb_func] ? : "", len);
>  		spin_unlock_irqrestore(&func_buf_lock, flags);
> 
> +		if (len < 0) {
> +			ret = -EFAULT;

I think this should be -ENOSPC as EFAULT implies an actual memory fault.

> +			break;
> +		}
>  		ret = copy_to_user(user_kdgkb->kb_string, kbs, len + 1) ?
>  			-EFAULT : 0;
> -
>  		break;
>  	}
>  	case KDSKBSENT:
> --
> 2.42.0.rc2.253.gd59a3bf2b4-goog
> 
> 

Thanks for sticking with these refactorings; we're almost free from
strlcpy. :)

-Kees

-- 
Kees Cook
