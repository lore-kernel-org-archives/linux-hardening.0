Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22671C7EE24
	for <linux-hardening@archiver.kernel.org>; Tue, 30 May 2023 23:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbjE3XRu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 May 2023 19:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbjE3XRq (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 May 2023 19:17:46 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7CB13D
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:17:38 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b0314f057cso23844525ad.1
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488658; x=1688080658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=htQvHyRPKywmvqgggGcNa8SuYARR+iKblgi3Lk2cgcQ=;
        b=SPiemOvN4l+hQOe10jQ/zlIUyFw1b3j7k7vKZjbaMYFU5hG16QEMZyUm2RjdLpU0Sl
         aQgfaqyLPUPdGIn6fPlWo+fLuJ/7/R4MXrUM929ffA5uvTEdYATepCa59cWdcXw7EpEz
         Mhts2ZAEipA6VoK17Ol0KlxTcHxglhPMsx8zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488658; x=1688080658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htQvHyRPKywmvqgggGcNa8SuYARR+iKblgi3Lk2cgcQ=;
        b=MF7l+rnN1miF/a5uhAQigaIyDPG0xdCeqwb5SiG0UVpvWfmYSEXC7N/QK+KCkyb7vc
         2veJzlXEBffgn4pqtGCkKdlV2IJkQIoLrUPIZ9QUBW0PIWob3Vgn6plqmyx20j4R8wNX
         thmz1wKk3i2MlXSLe75hg3tDwzM3E+5Q1BcEzz/HV7zqrBHr87XUo7rglwNJ+4LvCi3N
         tnUiusWYB81y+gyzH9Cvnmw7/RjAq1Y6W4FsvM7eDG+Q4C7s8kvduWzHYdCa12cDdUfQ
         JWCy6d10IrRurbhqhDBuDsDQOt8BsQNAAGImpBUlzbPZZehb0/Obm9IhWmsjEyD6hMb7
         1ILg==
X-Gm-Message-State: AC+VfDyLROFQ1WqBWfAD4sBJ0ULA4g5/Sk2fbpEjMGuZjSHr8cB6g8Ly
        3+sOWgE1OW5ajEO2jyHAnKG2ng==
X-Google-Smtp-Source: ACHHUZ7MnshdhHQU3GZ7AJ/pNk3+u3JS+QrXTvcqHGBBAbZSHFA2SuLvk6HrJbIf6Rh+UrsRpchscg==
X-Received: by 2002:a17:902:ba84:b0:1b0:5814:d8d4 with SMTP id k4-20020a170902ba8400b001b05814d8d4mr3731454pls.53.1685488658304;
        Tue, 30 May 2023 16:17:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a22-20020a170902b59600b001ae2b94701fsm10777113pls.21.2023.05.30.16.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:17:37 -0700 (PDT)
Date:   Tue, 30 May 2023 16:17:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-hardening@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: libfcoe: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305301617.FD9EAC9@keescook>
References: <20230530155818.368562-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530155818.368562-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 30, 2023 at 03:58:18PM +0000, Azeem Shaikh wrote:
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
