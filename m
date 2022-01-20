Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D6EC433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 20 Jan 2022 23:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348021AbiATXdR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 20 Jan 2022 18:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347876AbiATXdQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 20 Jan 2022 18:33:16 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F15C06173F
        for <linux-hardening@vger.kernel.org>; Thu, 20 Jan 2022 15:33:16 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id t32so6706239pgm.7
        for <linux-hardening@vger.kernel.org>; Thu, 20 Jan 2022 15:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6MVnd0IKMjHWYEmmxJTDcJXHRZaug6BXKl0q4y+4uMI=;
        b=M9ya/H2QbKv+DT6FgaakqIC7dPcTc7oBL8mueaQ0XgNOxObwAaAKgcB0lyUZLXBG7u
         KI3aBLqztwvYNviAd8c3qHAA2Ci7JceCJf/EeToAOEi1/gmk55Vz6LuYrtq83sfONgnA
         2zL8A2asbnOXokDvljLlJqjWxiODlniiTpBhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6MVnd0IKMjHWYEmmxJTDcJXHRZaug6BXKl0q4y+4uMI=;
        b=IgYSADq+Iu0iggryM1i4wf52DtMUhG7g9bgX44bGUqQ2b4uUF4aZWWbP1OniLJTR6S
         +PMYoy1MgHk99CcNBqAEMmpjZlPrvVrqLEBTkQZ4TMLLL9Vc8JJqyMsiyCTCuVrLPSNp
         KZPQdElp4+g7f6Le6XXTuuFnEFMJBW9W8bUm7rFvJ2vDIF7hexy9WMjECo1c7Ez1lefz
         bc1fQDsi5TbLZjmmLeZEah4llk1PvvMhI0HLbTZrAPn6TNKMLftxy+wU3/nWqbvbq5vL
         9f3mPQBC/0kr/2GlNOyK6xItIzSiNufl1txXpf3LpXLOcBRE/3kudC+2gQbBGL2R4Hp6
         Uvmg==
X-Gm-Message-State: AOAM5302ReL7kDldwmIdqoX8GvbIRqv4iSTNAZ9vq7B5VgM+Pt4kBbLt
        TAWqi/mc3QS3T+0bBtJcfdOQeoO2Zdfd0Q==
X-Google-Smtp-Source: ABdhPJwASg0kPCe1MkR2JePEm9F4SawZKuWOOIcp69MU41InM7haztXd7PayUp+v6dppVLa6KqOrYg==
X-Received: by 2002:a65:5a8c:: with SMTP id c12mr923567pgt.54.1642721596146;
        Thu, 20 Jan 2022 15:33:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bt6sm5274341pjb.3.2022.01.20.15.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 15:33:15 -0800 (PST)
Date:   Thu, 20 Jan 2022 15:33:14 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] iio: hw_consumer: Use struct_size() helper in
 kzalloc()
Message-ID: <202201201532.1F9C5BD@keescook>
References: <20220120225243.GA37225@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120225243.GA37225@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jan 20, 2022 at 04:52:43PM -0600, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worst scenario, could lead to heap overflows.
> 
> Also, address the following sparse warnings:
> drivers/iio/buffer/industrialio-hw-consumer.c:63:23: warning: using sizeof on a flexible structure
> 
> Link: https://github.com/KSPP/linux/issues/174
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks good to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
