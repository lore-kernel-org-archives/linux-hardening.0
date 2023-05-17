Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609EEC77B7A
	for <linux-hardening@archiver.kernel.org>; Wed, 17 May 2023 19:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjEQTNo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 17 May 2023 15:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjEQTNk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 17 May 2023 15:13:40 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB042AD2A
        for <linux-hardening@vger.kernel.org>; Wed, 17 May 2023 12:13:34 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ae4e264e03so12755605ad.2
        for <linux-hardening@vger.kernel.org>; Wed, 17 May 2023 12:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684350814; x=1686942814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/1LoPTJbncGj0zRlQjVQv3mXnAMywvSaO6mLN0ylsDA=;
        b=lzIhsYITQfnlvkxnxaTLqpMZDUwTS8G8kKF8F549pn5Veo9fN0ljeVbZH/2hili2zP
         VDCZgc0qG1i7EHVLCRzwIlpFEX6MKfZ4glGslTOLBrY/R7scFgR4yxgzAtgxv3PZx36I
         UQJb9eVcN6zf+G6ZnK4le7uqSGLx+KvUGEJqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684350814; x=1686942814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1LoPTJbncGj0zRlQjVQv3mXnAMywvSaO6mLN0ylsDA=;
        b=OOTlhaR5md2hCRjFBhJvOk+ZUUOjoktsTRXD6fQIC7DFrZQieaIgnoZxWGxZfDcfcx
         SQgiFxsnlyRtU9WlFVm05Ntc2SeS4NiBtHNTil1JQ3z9KGEsBoSA2JNAQgzsWwtSdPuW
         7MXP5Q1diUFyyNqEe0eMvfLTHcVdujJI1qa7izzKfH8uI5hrAJ6MPXuK1GxA9SfE7pT8
         Fevj4BVhLln7JJ6H9v+mcckRYOlvwD43WsiWdHtYS5TSlecNwPYRDWibq6jYNwAQNsK7
         EKuzNkJsBCy58M+y0LBqwtqVFwWp2Fa/PWnO4AHRJ/klStsx3OYo3+BsnfqsN/qnRih2
         CIhQ==
X-Gm-Message-State: AC+VfDwCI6TgWais9Du7S9ykp+ruAeblpuVsm6fOZw7bm/Ngi4YX08Xx
        +PbojdF96KRZc3gWljA5lR3S7A==
X-Google-Smtp-Source: ACHHUZ4JPsHm4F2JyvSlEeT7wms9HdBEUFjbBD3IpAsMfcJwtkQsjelIUPjNuG827RbZkDbKc67HDQ==
X-Received: by 2002:a17:903:41ca:b0:1aa:d545:462e with SMTP id u10-20020a17090341ca00b001aad545462emr56626362ple.13.1684350814555;
        Wed, 17 May 2023 12:13:34 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iz3-20020a170902ef8300b001ac444fd07fsm14196116plb.100.2023.05.17.12.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:13:34 -0700 (PDT)
Date:   Wed, 17 May 2023 12:13:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: aacraid: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305171213.4BE193E@keescook>
References: <20230517143049.1519806-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517143049.1519806-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, May 17, 2023 at 02:30:49PM +0000, Azeem Shaikh wrote:
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
