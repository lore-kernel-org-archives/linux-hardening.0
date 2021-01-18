Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840D5C433E0
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Jan 2021 16:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5089B22BE9
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Jan 2021 16:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406248AbhARQOW (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 18 Jan 2021 11:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390800AbhARQAk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 18 Jan 2021 11:00:40 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58A9C061794
        for <linux-hardening@vger.kernel.org>; Mon, 18 Jan 2021 07:59:24 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id m5so10074200pjv.5
        for <linux-hardening@vger.kernel.org>; Mon, 18 Jan 2021 07:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LAO4XVga4Bz+KODODRuxwsHbnVzruwUFdi/GoUQHg8w=;
        b=fim6oswJW+6O9lZtkbJ3cAgrAmx+v+fjNJSbpYvYbDk0wnTLWptVuV6V1SgoqKnhky
         HJS2gRuWFbklP6EC5a7AKKkM5farhWhaFeRihLra5icodH4lHSA5CKITfVJ9f3fwBTYB
         HNRMDMfVvrJzCdWOelw/RNI+PbU/aKnNPs+4EQ+AuUxhIKPbhto4HAvFbIJ1IcotqsEA
         GwJoJAfbAK82OLKpj10TbDDDrM0EVGMHpL9Y8WkVBenZTD2jA2duLctBD6a5i+srg04N
         X7jkBgtWdFRLSmaqAc/U8jsxVypHf2dHn1i/QjV7GGaR9DdVghdIZatBHVua1AJKh+R1
         wPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LAO4XVga4Bz+KODODRuxwsHbnVzruwUFdi/GoUQHg8w=;
        b=Zguaoa8vH1ewQMNE62F+caiM9j3yvMlrkKq/ffxdZaavm0Vgw9NQy1RtTvsTHI1/YF
         WvIqA1mVVvzAlPICxWIZ+s4P8VwjiH56fjUM4NpjPPPRDsFOOGBQq/TSSNamsdcmKzhf
         WNyaFyxkAn3cKIXRbhN9VP0EE5DwIqqD4ZX8KTYsF8ERNN2fH1gUWh1XhRzBDe9EegjR
         Zn1Zk7yFpWUbc2gKyIueV+htOlIT5lV+AOY32TSu29zGoEigUP4k88jWxTpsKKjq/pS7
         ro9m/p3wkdedu0ywhJcUg2z+neyUUL6cjJpsPLO0w9j5uf2McNSpLfBC6cr6bFHKtRoU
         hDuw==
X-Gm-Message-State: AOAM530qDkEQk7uDKa+9JpUNIa2lX8LcSttu1oHjDIVR6xR2Vw5eFeqC
        3ZVLt+LLxHIu/lNYqf14VjDGORY1u9bKgA==
X-Google-Smtp-Source: ABdhPJyfk4Aah6jYIgWPK1hlcBoMOMjjqeFEdeyeGdyyCb7mCaIOz9y0pIHqeS+No3RB1UuSmkyCtg==
X-Received: by 2002:a17:90a:9302:: with SMTP id p2mr9597454pjo.213.1610985564339;
        Mon, 18 Jan 2021 07:59:24 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id mj21sm8442604pjb.12.2021.01.18.07.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 07:59:23 -0800 (PST)
Date:   Mon, 18 Jan 2021 08:59:21 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Sergey Suloev <ssuloev@orpaltech.com>
Cc:     keescook@chromium.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linaro-toolchain@lists.linaro.org
Subject: Re: Compilation issue with Linaro ARM toolchain
Message-ID: <20210118155921.GA462671@xps15>
References: <70249918-0081-aef4-0605-85db700aadc5@orpaltech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70249918-0081-aef4-0605-85db700aadc5@orpaltech.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Adding the Linaro toolchain group mailing list.

On Mon, Jan 18, 2021 at 05:49:39PM +0300, Sergey Suloev wrote:
> Hi, guys,
> 
> I am having an issue builduing kernel 5.11 (rc4) with Linaro ARM toolchain.
> The issue seems to be related to CC plugins sources.
> Here is my build log: https://pastebin.com/DTn7Szax. I have never seen this
> before with versions 5.10 and below.
> 
> Thank you,
> Sergey
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
