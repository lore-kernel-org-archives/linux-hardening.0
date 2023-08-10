Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F37C001E0
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Aug 2023 19:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbjHJTFG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 10 Aug 2023 15:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjHJTFF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 10 Aug 2023 15:05:05 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128E51AB
        for <linux-hardening@vger.kernel.org>; Thu, 10 Aug 2023 12:05:05 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bb84194bf3so9222175ad.3
        for <linux-hardening@vger.kernel.org>; Thu, 10 Aug 2023 12:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691694304; x=1692299104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=860PWC8FTmmxEiDUGxT48Wa5iNqeUxA9TN3Utilr4kI=;
        b=LSIsvcicRp1TsKNMDQdPJBWvLb2GfgqtEswz/i6nTSQdUdvBzEIwY/W7B2Y1v5Uhxg
         ZCmZzgBRaztX0P+sW2P/XnEHlCWxOrckk5v6DF6qBY1Wz5Jxt9byx+iKzfiNluXatS1s
         qlUZN1NTP9tllyAzKgQJmZUaJ7PzF8tURqBXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691694304; x=1692299104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=860PWC8FTmmxEiDUGxT48Wa5iNqeUxA9TN3Utilr4kI=;
        b=dkEczyDzm6L8PYvWNUqymF01eBjEEYdS3JXCiiEAEEuLtGSYiE9WjPLyGR2gUBZJLr
         0xzAJBnBb0/71dKgoNzT1BaIoMdVe9oMUGfLsprAvBZvJ2bMXrf4fS9OnQz8K+QNv1Oi
         MJcS6u2HtdtkIfY1KKHREofVbZ88N6qPMhNLHp3SOOXOPQACL3p0Dh9VhFBYs9h/KRW+
         ekpTCoHCGGK/bi9PvgYZctRko+4bjWHU1bbfRum/6Esi7Ibf2E2PnGjnBNE5T7APPHvA
         ZUZKnIwI7OwFFPrgI8CzLto+7XEjJ1++1ZvpBPYPeT6cidU++uFC2seaUVhVAsGURAc/
         J17w==
X-Gm-Message-State: AOJu0Yy6abXUjwZOFNZagr8z9RxySJFfaTnHXIFZiayPwjWclImXXzvK
        nlr3OGQVM7zQ+04MOSFMSD3l4A==
X-Google-Smtp-Source: AGHT+IFZ70Z8bWdGaTakkvT4U9Nu4x3xJoLxtXsK6ixM+o35icuoD5Qtp4zihOOd3zdu/f4Iwv0JFg==
X-Received: by 2002:a17:903:120c:b0:1b8:b3f0:3d57 with SMTP id l12-20020a170903120c00b001b8b3f03d57mr3468147plh.31.1691694304549;
        Thu, 10 Aug 2023 12:05:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902d34d00b001bda42a216bsm1859975plk.100.2023.08.10.12.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 12:05:03 -0700 (PDT)
Date:   Thu, 10 Aug 2023 12:05:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-hardening@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] um: refactor deprecated strncpy to memcpy
Message-ID: <202308101204.BF36493304@keescook>
References: <20230809-arch-um-v3-1-f63e1122d77e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809-arch-um-v3-1-f63e1122d77e@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 09, 2023 at 06:19:32PM +0000, Justin Stitt wrote:
> Use `memcpy` since `console_buf` is not expected to be NUL-terminated
> and it more accurately describes what is happening with the buffers
> `console_buf` and `string` as per Kees' analysis [1].
> 
> Also mark char buffer as `__nonstring` as per Kees' suggestion [2].
> 
> This change now makes it more clear what this code does and that
> `console_buf` is not expected to be NUL-terminated.
> 
> Link: https://lore.kernel.org/all/202308081708.D5ADC80F@keescook/ [1]
> Link: https://github.com/KSPP/linux/issues/90 [2]
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
> Cc: linux-hardening@vger.kernel.org
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks for digging through this!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
