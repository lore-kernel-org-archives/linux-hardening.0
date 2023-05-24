Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5537FC7EE2E
	for <linux-hardening@archiver.kernel.org>; Wed, 24 May 2023 10:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjEXKkE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 24 May 2023 06:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjEXKkD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 24 May 2023 06:40:03 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FEB131
        for <linux-hardening@vger.kernel.org>; Wed, 24 May 2023 03:40:01 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-510e90d785fso1537531a12.2
        for <linux-hardening@vger.kernel.org>; Wed, 24 May 2023 03:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684924800; x=1687516800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38iJHpKlIiWZbh1WDjxxGN+0tLET1s1ACGv1lr82oHc=;
        b=Rz6wHr67S1cULfAOj1lT79Lh3G+fcFkDyCZnpmiyp0QRutIFDCh87U8llVuL6KrsIP
         5+FrH0DrH8tWcSoiJ01musD/yKnK5UpEbk8NIm3A+pa75pB8XItq+/TpZaZwAj/CL0LR
         vi2PJd5KJimgYUEpDO68Z+07waFH4+YjdadJBhE8JoxBEFhoVSLVK12/wIF0UIGmoKcy
         afrnF7oI3RjLtZcmAsom2yxImNuJT4vQBz4i2wl8gJnMIThZO2bEXxMSIN424Irr/ucg
         5uFIix90Da3cwxizk+RCqUMtlzAlSgEvdm+CGWI5XB4Cp3bnBBg1Nr7xrw1Mk71/TD9J
         eaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684924800; x=1687516800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38iJHpKlIiWZbh1WDjxxGN+0tLET1s1ACGv1lr82oHc=;
        b=EJYkGnLhm05s/6xI/nWQ8uHS5mQeVAO01B1d4+rnPBaXCq7L4pWqKViMxivYBqqBQu
         bwwRmLDF/2N675NTzGp+B37zv13rOFvj8i1gA/Ic9o/v7wDpOMmLcJmia2XaMyIgqgQ9
         LjRomjvASXib71kyDU5MQgmX7piNutBlTUULqXT0/2Bf2c/ALABzs788m9D4GC6+nPdu
         YQ0n75nEc7i+vrxE/JUuIFtY3dyZA/1VP54uKtvZ55UTfGNIuq8aDPCurQIVs0CQymqt
         Mtqip/t9hA7fQOiqDMu5+FIOlD2W9oG9O6tVQ0/PpWdHi3SOF2uu9qA6AzHe6n2fYJG7
         bA/Q==
X-Gm-Message-State: AC+VfDwzkG5U313KGolELLpjDXfCMSCzwuEU2iH3+vwj3kRs8PzAZ/Tc
        0NAlb1uRNbwrg6ukBUO6Z4P6WocVzPRPNnAC2R6fiA==
X-Google-Smtp-Source: ACHHUZ5KEgHn+BODCBjPTJdXE32cq+ah2nLHIvhhJs/3W9A/frhnK+0OzySN5R8OvNNpBRTK6iEwFez2N6pDL6jV+Zo=
X-Received: by 2002:aa7:c6c6:0:b0:50b:cd19:7545 with SMTP id
 b6-20020aa7c6c6000000b0050bcd197545mr1445519eds.33.1684924799684; Wed, 24 May
 2023 03:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230523021943.2406847-1-azeemshaikh38@gmail.com> <202305231021.1AF1342BF@keescook>
In-Reply-To: <202305231021.1AF1342BF@keescook>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Wed, 24 May 2023 16:09:48 +0530
Message-ID: <CAO_48GHjU9nSugzjRqDJVU3_HNQuGx4qnTFqayXECd=mFVk_Jw@mail.gmail.com>
Subject: Re: [PATCH] dma-buf/sw_sync: Replace all non-returning strlcpy with strscpy
To:     Kees Cook <keescook@chromium.org>
Cc:     Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-hardening@vger.kernel.org,
        Gustavo Padovan <gustavo@padovan.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello Azeem,


On Tue, 23 May 2023 at 22:52, Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, May 23, 2023 at 02:19:43AM +0000, Azeem Shaikh wrote:
> > strlcpy() reads the entire source buffer first.
> > This read may exceed the destination size limit.
> > This is both inefficient and can lead to linear read
> > overflows if a source string is not NUL-terminated [1].
> > In an effort to remove strlcpy() completely [2], replace
> > strlcpy() here with strscpy().
> > No return values were used, so direct replacement is safe.
> >
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strl=
cpy
> > [2] https://github.com/KSPP/linux/issues/89
Thank you for the patch; I'll queue it up.
> >
> > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook

Best,
Sumit.

--=20
Thanks and regards,

Sumit Semwal (he / him)
Tech Lead - LCG, Vertical Technologies
Linaro.org =E2=94=82 Open source software for ARM SoCs
