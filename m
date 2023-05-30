Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103AEC77B73
	for <linux-hardening@archiver.kernel.org>; Tue, 30 May 2023 23:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbjE3XU6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 May 2023 19:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbjE3XU5 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 May 2023 19:20:57 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31190102
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:20:51 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b011cffef2so44654665ad.3
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488850; x=1688080850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ddypSZo0pvZj3CCocZxOELdl+DEZnsNHTPXNYsUXA+U=;
        b=fOMdV6bV4zFWMAEfPk/QN3zM+edy6/AD1CsjZLT8PblcO/ut+cRCpK8KxeGMNB0syn
         opcmuwL4i+1Wl/PevrFmRdnTBv5gRGHMyH027oMB3BoiaPTaMlpqyJNWaDoPQR6jrY+s
         iAL/AmtGZeh+OLxcaQxGlX0Q9weQoHgPZSNZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488850; x=1688080850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddypSZo0pvZj3CCocZxOELdl+DEZnsNHTPXNYsUXA+U=;
        b=jM+9L6VkuRpZOckNXiv2kpR/VgC4sUQOBOCR8zfakllnPmwlGzymG358OTHHzsLnWJ
         YoIME8arBVm3JIgxIlvT69hnNj9oluMGsZbE2yVsIc0TLHMSgM1yNs2lSIg1dSXgbhhi
         q/WDlHWGlG6nKxlSZy8Q5PRJ74AlrUg8PrFzPeqG4OL6hUy90VNehIf8MJwExnMJ2RtM
         3ah2Tf0COb9G/Hh2dtopLJ7gJInhQIjFsc7DIGTqHBpJPoUu3dwuDCA5Vh16xQe9KvEn
         b7Egl/PfI8D0PWzba42B46HVcO09/SYGA1Yt99Sz6/Z8zmxeStnoWw3n4rKTAP219nlK
         ICZQ==
X-Gm-Message-State: AC+VfDyL3o5J4YyiJw1NN+8IlaC1Vc+mkgSyWZz8ZMputigcJDnec50K
        2xYRk5B4zP2weZSljYq6lz6tCQ==
X-Google-Smtp-Source: ACHHUZ5rzUACM1i508I2O0D5Ud9Tu42v2WmVDme8hyjAXpZFBjMT8MeFfihGvE1PSb330BeZX303gw==
X-Received: by 2002:a17:903:2442:b0:1b0:41fb:4ad5 with SMTP id l2-20020a170903244200b001b041fb4ad5mr4303960pls.46.1685488850466;
        Tue, 30 May 2023 16:20:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l13-20020a170903244d00b001aaec7a2a62sm8685754pls.188.2023.05.30.16.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:20:49 -0700 (PDT)
Date:   Tue, 30 May 2023 16:20:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Don Brace <don.brace@microchip.com>,
        linux-hardening@vger.kernel.org, storagedev@microchip.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: smartpqi: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305301620.75F9B609@keescook>
References: <20230530162321.984035-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530162321.984035-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 30, 2023 at 04:23:21PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
