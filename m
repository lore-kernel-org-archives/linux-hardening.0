Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D17C6FA82
	for <linux-hardening@archiver.kernel.org>; Fri, 23 Sep 2022 06:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiIWGvW (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 23 Sep 2022 02:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiIWGvV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 23 Sep 2022 02:51:21 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C96C127CB7
        for <linux-hardening@vger.kernel.org>; Thu, 22 Sep 2022 23:51:20 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id z20so13597977ljq.3
        for <linux-hardening@vger.kernel.org>; Thu, 22 Sep 2022 23:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=5n36C2tqfcTCjqcGkGfBQuKpTNAA2BKA5lMbPoJLYUQ=;
        b=fJmGGepxP+6q2bIHI5328Lq4ITyrloOYv1zS43szF3ZREYrzkBnONf42D6jHk+s25l
         RV2QvL/SeyLmojPAck86cTnW+P/VtmvtOTV7cohizBPTykbHHF+0S+z9GfWCWz6Fu4YC
         wwmFQ3wyyOSX2irMzapqbBkQ44KA2MW7ZzaScBU64k4eq6SzYDRtcoPtOp+G8fQaMAT9
         chVIkxfXJALs4DlMhQilRH/ZyGIEdFTyXK+Ty62ay8SkeNa8R+VaEz+OdIsrf+NzsNF9
         5ct8+yG0BbEBt8blD+5XJYs6ASJqofVKx47FlbA5iwaZpeDBeRt8DfVc+BXbdtljP5xb
         DiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5n36C2tqfcTCjqcGkGfBQuKpTNAA2BKA5lMbPoJLYUQ=;
        b=Q/l8x8HSAmxh2aGipoFdYqzM9ZUqlYuIPy9WTZaoqrJDehyQRrI6aWhUxJT2NoDBJd
         e7q+fJUHAH0pg0LjKFV8vqP8d1byO/o7DjmCRfPTFPlP5aeeKaWNAeeIG9cibYY/pU07
         R8UQHf/WH/8GRnmcQ7UiP/aNVKV9krX1Ys8YDftvPXofKiGdTYPrUmK3MIOiAOEPskIQ
         bR8x1i6DRBIRdm6GoXmEMYQBKaVM6oDqGFdvh6sy0me73hyI/TPS38U71TimlvIhpn53
         keCuF6/91AU6vz4bC/c/gPmohYQbw5+5xLMkNkhHjgICkJ0sl6hPLkUxgn8bkIjMEN+e
         t1dg==
X-Gm-Message-State: ACrzQf1yJPQlL9k93Ri9g+gwdsuseeyb3fAYi01WPY4blHOg9Q3MPho7
        CWaOtzkVXAut94oSoVpgNGSk0ZKWCi5cIPKfS7BjxQ==
X-Google-Smtp-Source: AMsMyM4SYRLgKDTQtFAegqm3ErVf2J0G8v6d3X72fLkW2LgxrDp+F7ox3cOfwCkywNJMh76S2LXalTh5KpfVW9XypK8=
X-Received: by 2002:a2e:bf21:0:b0:266:2be3:61e8 with SMTP id
 c33-20020a2ebf21000000b002662be361e8mr2243397ljr.383.1663915878464; Thu, 22
 Sep 2022 23:51:18 -0700 (PDT)
MIME-Version: 1.0
References: <Yyy31OuBza1FJCXP@work>
In-Reply-To: <Yyy31OuBza1FJCXP@work>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Fri, 23 Sep 2022 08:51:07 +0200
Message-ID: <CAMGffEnPaZPw8PKq4HaB-0cbd-XyxDY4Hzrs5GxsoQKQJiCK5Q@mail.gmail.com>
Subject: Re: [PATCH] scsi: pm8001: Replace one-element array with
 flexible-array member
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jack Wang <jinpu.wang@ionos.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 22, 2022 at 9:30 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element array with flexible-array
> member in struct fw_control_info.
>
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
>
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/207
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/scsi/pm8001/pm8001_sas.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
> index c5e3f380a01c..b08f52673889 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.h
> +++ b/drivers/scsi/pm8001/pm8001_sas.h
> @@ -612,7 +612,7 @@ struct fw_control_info {
>         operations.*/
>         u32                     reserved;/* padding required for 64 bit
>         alignment */
> -       u8                      buffer[1];/* Start of buffer */
> +       u8                      buffer[];/* Start of buffer */
>  };
>  struct fw_control_ex {
>         struct fw_control_info *fw_control;
> --
> 2.34.1
>
