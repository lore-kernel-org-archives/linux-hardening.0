Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B809C433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 23 Jun 2022 16:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiFWQ33 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 23 Jun 2022 12:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiFWQ32 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 23 Jun 2022 12:29:28 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7315046B3E
        for <linux-hardening@vger.kernel.org>; Thu, 23 Jun 2022 09:29:27 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t3-20020a17090a510300b001ea87ef9a3dso71089pjh.4
        for <linux-hardening@vger.kernel.org>; Thu, 23 Jun 2022 09:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2/BbUVh0cfAq2g3sTTEh1dhxjM0IAKM6s6X7XzEKPTg=;
        b=VWllvdwMR3kg3Ed9OEhiULEzlVtdbGFjCVqY5hxwaSsPeVO0C4FtOn6i/ejhUxwhK7
         5BaqtUspFCu1Oo+6JYQP9uzzM5huJBJSyWEXE1dg8jQ+FPKzN9E9Uf9zgpf+iuEHwhay
         uQAGtCBiZz5u2eJnCGRK72yS3LfhQ+LwphT6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2/BbUVh0cfAq2g3sTTEh1dhxjM0IAKM6s6X7XzEKPTg=;
        b=fL13N/0uVe7kiw6u9HcXc9v/09azGXfFP2hQL1ZYYhfYuxsTN2XSXi5B0YZBtLDT+J
         8BCSLH9cIxsgsz9dDyowQ+omp48fIvJd8MHUYm5wTsin+cXgZXcHaiJStePA1CNF6L54
         EgqvqSAYlmqGjsP6L0t0fnioARjQe+u5MhlNU9UnFxkQVGLlXNDE8vxSoMbg0vJ7Pe0n
         BIle14q6kMbYOtN7TUDWgzY1RTKvgjRtKIFFilDhlIG29UgIMCxHNLxStwkFToB7na/H
         IxwYqbevf+cQdXHpT0nVxacv5EMExMPm0Vz+qi22UpsbOcpCRSn3VtQbYbK4rlyR0qlq
         v22Q==
X-Gm-Message-State: AJIora9j8JJvBngXC/6zsMzqsx3xZN0FhFTg+I8exIm8TCDjaIl6R5PU
        yzaGmX7tOp6PU7Ez8HPOiNdnEQ==
X-Google-Smtp-Source: AGRyM1sDLE9y8/LYsf2Bs4AoD2epoxqcEYkWHYEs7FdrsqvUm6zri1tArpRTJRcLpuvSTzkiIQvqdg==
X-Received: by 2002:a17:90a:bb91:b0:1ec:7062:32cc with SMTP id v17-20020a17090abb9100b001ec706232ccmr4827208pjr.231.1656001766975;
        Thu, 23 Jun 2022 09:29:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t66-20020a637845000000b004088f213f68sm15702091pgc.56.2022.06.23.09.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 09:29:26 -0700 (PDT)
Date:   Thu, 23 Jun 2022 09:29:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 8/8][next] scsi: aacraid: Replace one-element array with
 flexible-array member in struct aac_aifcmd
Message-ID: <202206230926.8C76CFCC@keescook>
References: <cover.1645513670.git.gustavoars@kernel.org>
 <7d0571ef5dc87904008c325a942cfed24dbbf42e.1645513670.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d0571ef5dc87904008c325a942cfed24dbbf42e.1645513670.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Feb 22, 2022 at 01:31:07AM -0600, Gustavo A. R. Silva wrote:
> Replace one-element array with flexible-array member in struct
> aac_aifcmd.
> 
> This issue was found with the help of Coccinelle and audited and fixed,
> manually.
> 
> Link: https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
> Link: https://github.com/KSPP/linux/issues/79
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/scsi/aacraid/aacraid.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
> index 97948cd5f13c..447feabf5360 100644
> --- a/drivers/scsi/aacraid/aacraid.h
> +++ b/drivers/scsi/aacraid/aacraid.h
> @@ -2616,7 +2616,7 @@ struct aac_hba_info {
>  struct aac_aifcmd {
>  	__le32 command;		/* Tell host what type of notify this is */
>  	__le32 seqnum;		/* To allow ordering of reports (if necessary) */
> -	u8 data[1];		/* Undefined length (from kernel viewpoint) */
> +	u8 data[];		/* Undefined length (from kernel viewpoint) */
>  };
>  
>  /**
> -- 
> 2.27.0
> 

FWIW, this patch solves an -Warray-bounds warning that is seen under
-fstrict-flex-arrays=3 (coming soon[1]):

../drivers/scsi/aacraid/commsup.c:1166:17: warning: array index 1 is past the end of the array (which contains 1 element) [-Warray-bounds]
                                (((__le32 *)aifcmd->data)[1] == cpu_to_le32(3));
                                            ^             ~
../drivers/scsi/aacraid/aacraid.h:2620:2: note: array 'data' declared here
        u8 data[1];             /* Undefined length (from kernel viewpoint) */
        ^
../drivers/scsi/aacraid/commsup.c:1286:20: warning: array index 3 is past the end of the array (which contains 1 element) [-Warray-bounds]
                                  ((((__le32 *)aifcmd->data)[3]
                                               ^             ~
../drivers/scsi/aacraid/aacraid.h:2620:2: note: array 'data' declared here
        u8 data[1];             /* Undefined length (from kernel viewpoint) */
        ^

[1] new flag in GCC and Clang:
    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836
    https://reviews.llvm.org/D126864


-- 
Kees Cook
