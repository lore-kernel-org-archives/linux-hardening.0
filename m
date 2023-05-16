Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E57C77B75
	for <linux-hardening@archiver.kernel.org>; Tue, 16 May 2023 18:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjEPSP2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 16 May 2023 14:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjEPSP2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 16 May 2023 14:15:28 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95540420A
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 11:15:27 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-25332b3915bso507920a91.2
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 11:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684260927; x=1686852927;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=byFT3vV2qfPS05ZcRtgBidf32OEFCTYrPqr4duaWLfA=;
        b=T4NuXoRHSsrJ0z7tw3wP6OdPIZlXuLO6oQ+ktPT5x/lj7U0l20o8ZsJ0yhEDHrQsu6
         Y7O9qCu5gFJbF4Rla1iWSPuwnj74RLPDS4RRpzVHAE3SZQc6koODaAetNXqh4lfsnc16
         J95oEnLsQuv8TD5LNarluxzBcaFCX9yfmZErY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684260927; x=1686852927;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=byFT3vV2qfPS05ZcRtgBidf32OEFCTYrPqr4duaWLfA=;
        b=P4tc95jPBhwK5EY7A8b69uYL7j0vqDxPZs/vZJU6T7z+jlbZJe/MGT/oBN9Ft0wmNF
         jR0IzwvzT4LsrrKOsxCU9oxRdQDBwKI+xBNelNU5VlVYrgHe3sq1jLy9ZNJMNz3s613l
         gqQs+sOcEFdzKdcdOimlrzRXFAXz4A1ChNSioePVt8sNQxDnPx3n3lCLmV/n7pIpKkuj
         PRSQHmirF7mZAZVYJMryQviArLuJlGYzEXQqkwB+h030VG9odBT6bvjiFwl6mF4dyBgM
         342bgZHrBvZwWBOyMg2KGnQ4WYKZpqoI2jnNqHFj/cjqn4vYJ1loVPWf3/IJ0sYszcWH
         KLFQ==
X-Gm-Message-State: AC+VfDzguX5lrAFQj0Ytn5iSprS8cFOsqA5ZYWirC/vzPf08r2ckPdJp
        raIkifyrU776ZnlME2xupbuP5Q==
X-Google-Smtp-Source: ACHHUZ7CKbbi4Bbdft7vLEfnIr5e/SMAQZFeaBzDdw4hFH5TRaYWg3Zsqc1N+lLJS37u5UW7BAjMnw==
X-Received: by 2002:a17:90a:3485:b0:247:2d9d:4722 with SMTP id p5-20020a17090a348500b002472d9d4722mr38324941pjb.0.1684260927115;
        Tue, 16 May 2023 11:15:27 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m6-20020a17090a3f8600b00246be20e216sm1902219pjc.34.2023.05.16.11.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 11:15:26 -0700 (PDT)
Date:   Tue, 16 May 2023 11:15:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: bfa: Replace all non-returning strlcpy with strscpy
Message-ID: <202305161115.75DCAE2@keescook>
References: <20230516013345.723623-1-azeemshaikh38@gmail.com>
 <CADmuW3U_tGb+2E5DZVBjMKGTezsTFh5pTjDhJfQ_mNcMvk5GPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADmuW3U_tGb+2E5DZVBjMKGTezsTFh5pTjDhJfQ_mNcMvk5GPQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

> On Mon, May 15, 2023 at 9:35 PM Azeem Shaikh <azeemshaikh38@gmail.com> wrote:
> >
> > strlcpy() reads the entire source buffer first.
> > This read may exceed the destination size limit.
> > This is both inefficient and can lead to linear read
> > overflows if a source string is not NUL-terminated [1].
> > In an effort to remove strlcpy() completely [2], replace
> > strlcpy() here with strscpy().
> > No return values were used, so direct replacement is safe.
> >
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> > [2] https://github.com/KSPP/linux/issues/89
> >
> > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
