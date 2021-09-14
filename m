Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF252C433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 11:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4ACC61166
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 11:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhINLZx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Sep 2021 07:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbhINLZv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Sep 2021 07:25:51 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3C3C061574
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 04:24:34 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id i28so23124928ljm.7
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 04:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cp0SQvp2N+xoe5C9OTNfUx9zbpD4P6j+IayB6VA30bk=;
        b=swnsW5M61hgulyulsIRu3aI3c5JyOHo1hV1BavL7cNd27JSmoAFdOmDyll3HQ+PKwA
         do8l1rDRqZmoPpoMAtu5qvL8wektf5sqsuE7k+qr0J0fVhYytZgixfBXDAmEMq8kAH/F
         pcHIRPN4ZC582Hgq2iITsA2M9JuBwvfDeR1Q03lkXWIvo2higY1eDlridEWIdGpqTrd3
         8wfWcyEXeuT0bhRb/+n2Gcm0SrWajWSw5Ti0eetW0Lw48BaiArItYRrO9I4JQORqbWvB
         6VargJN8dBi0DgoEyHfj/Eq+3Ft3CqUhBf+p0olPNckb4JjFdAcJiI5bnLOnZoaitVFs
         hCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cp0SQvp2N+xoe5C9OTNfUx9zbpD4P6j+IayB6VA30bk=;
        b=dChSxtTfOPX4CrKGqw+ySHDNg5+G3+ZbXNUK41pSve2FJF5TOjmat8K1kqaYn9R1g6
         5lnCfHw6aCcEf03jg+yQxI0DUGipCZwNiEyZ9nnGP8Hi1cR7NGvOLzb78MAAzI17Qfkh
         ebQzD/oeCkOnWNHC8yVhoc/CqDT4/3Oe2C/a60RQeNgIdE5f0OvHE/xgAlV38s2u3JBn
         I/5TNpRdX7Kx2nufWFIZnxgv10H1EUq45a4yoYcg8JxkN0eMVmwl0klft63duqG/r5XZ
         CzyIZcvgJbwmFL3LZjqRmF13QvWDM9N87g4fqTqxu6Chgu1Ygqv7mqOyzNih0YPELTLO
         rmIw==
X-Gm-Message-State: AOAM5331kuGWo4oDXUo6zHSi1zxHL+rTe49+kMvxJ7n1f5T+rHeV4Fs8
        kXX1cl06Sbw2Mw9WQfT7sYUn7KlsPH0cnD3Oved3Cw==
X-Google-Smtp-Source: ABdhPJzf1cZ1haIuWx4qetdhB8fMA2L7nDxmvcpl12S8Bc/zLJ7IB1YUa/nTacFTu/yJmy9Nj89xbQhPxJ3NScN0wIc=
X-Received: by 2002:a2e:b610:: with SMTP id r16mr14814634ljn.367.1631618672323;
 Tue, 14 Sep 2021 04:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210911131933.2089-1-len.baker@gmx.com>
In-Reply-To: <20210911131933.2089-1-len.baker@gmx.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Sep 2021 13:23:55 +0200
Message-ID: <CAPDyKFrmSOWF4CsRApq58PVtp2XDfwsBFCYs4vHDDatQHQAA+g@mail.gmail.com>
Subject: Re: [PATCH] memstick: jmb38x_ms: Prefer struct_size over open coded arithmetic
To:     Len Baker <len.baker@gmx.com>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Kees Cook <keescook@chromium.org>, Tom Rix <trix@redhat.com>,
        linux-hardening@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, 11 Sept 2021 at 15:22, Len Baker <len.baker@gmx.com> wrote:
>
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
>
> So, use the struct_size() helper to do the arithmetic instead of the
> argument "size + count * size" in the kzalloc() function.
>
> [1] https://www.kernel.org/doc/html/v5.14/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
>
> Signed-off-by: Len Baker <len.baker@gmx.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/host/jmb38x_ms.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
> index f9a93b0565e1..a7a0f0caea15 100644
> --- a/drivers/memstick/host/jmb38x_ms.c
> +++ b/drivers/memstick/host/jmb38x_ms.c
> @@ -927,8 +927,7 @@ static int jmb38x_ms_probe(struct pci_dev *pdev,
>                 goto err_out_int;
>         }
>
> -       jm = kzalloc(sizeof(struct jmb38x_ms)
> -                    + cnt * sizeof(struct memstick_host *), GFP_KERNEL);
> +       jm = kzalloc(struct_size(jm, hosts, cnt), GFP_KERNEL);
>         if (!jm) {
>                 rc = -ENOMEM;
>                 goto err_out_int;
> --
> 2.25.1
>
