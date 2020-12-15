Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93495C4361B
	for <linux-hardening@archiver.kernel.org>; Tue, 15 Dec 2020 06:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6593120798
	for <linux-hardening@archiver.kernel.org>; Tue, 15 Dec 2020 06:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgLOGKc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 15 Dec 2020 01:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgLOGK0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 15 Dec 2020 01:10:26 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC427C061793
        for <linux-hardening@vger.kernel.org>; Mon, 14 Dec 2020 22:09:45 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id k10so15771447wmi.3
        for <linux-hardening@vger.kernel.org>; Mon, 14 Dec 2020 22:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qTC/ZFdBV4bfFnGdBAMxOiVS8IVB9B7BDasYdtfr3Kk=;
        b=Pe6FVTkSbDl3k1ES+hAL5ydvu6Fd6KWauGwno8sPnJm6uCYVkoVoayxm5VCvNan2Bh
         a7Kf+q5YLohn1ptNHBk0G+9elIzHtHgQ1/l03bFbhI8ae6obbdebOC4hbn/iaU8rszg0
         u9YlDBPaxWMiMmZRaXpKRdOFE9PnJF360OCsShddqZR+KRZ2WKfUcpWnB0R0lt3q8d7d
         F5X1+DY78eMpdrRs9e94ShYE8QNy5VGsKIql+eABk/KsSfjN0joKxZ3bYxGRLUad30Jg
         7frXmqhjXsdfTP9WQs6OJAO8Y6s/1n0jDS94817VsOId2yYJSSgOBoPqWzKZRG8TI4Vo
         7Ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qTC/ZFdBV4bfFnGdBAMxOiVS8IVB9B7BDasYdtfr3Kk=;
        b=JwCyc1uuo8Rh1o6Q47z5k0H3DKEYBl6XCgCade8n9JRGiPF+6IGPaePzTMvra0iNRu
         eBz+DtwoAs9Vq+WQx03pHZVVTPH99P5Kmp0l7WCNh9TnIyjMQMWcyxHY/dEqZ7ikb1wQ
         TVKAOqU+MPgZDPKqVkM5hET/3A/mk5ACwdWv7JzblM9gMYV2OCfRjYZj8Wk/nRM11vny
         fFrpGgpoV37fe9WmcBf9INksOWyxBZRhsUFMrHMW92CaJ7efQ5/H6f5NViIdiosXH7Eh
         j3TjfULx0RXsv/okOgBYa1gYJ8WBBCWfKX3H7R6/nnIHsgSq9jaeKq6u7NLT/NxOWqgI
         EcXg==
X-Gm-Message-State: AOAM532jqtpg2E0iiQY2DK68LLMisx7YhdsbBHpFtIulSPrHeF/XJuR3
        mw1A/7Y+rxSQCos2Q27e0CBME3ZqBoPO4Ghi24M=
X-Google-Smtp-Source: ABdhPJwGbzWHZ05gHw1j32jLgtdFdWbst+7Qdh9hLzKs+B2cmL1gz9UqDF0J2hkj9RmcUASDgSduK19wiId5c5MrGXw=
X-Received: by 2002:a1c:c305:: with SMTP id t5mr31602285wmf.63.1608012582793;
 Mon, 14 Dec 2020 22:09:42 -0800 (PST)
MIME-Version: 1.0
References: <X9UjVOuTgwuQwfFk@mailbox.org>
In-Reply-To: <X9UjVOuTgwuQwfFk@mailbox.org>
From:   Sandy Harris <sandyinchina@gmail.com>
Date:   Tue, 15 Dec 2020 14:09:30 +0800
Message-ID: <CACXcFmnrQmQO38yBXh25eD9QgtvjKHTg=oCtJm8Kq6coK+WspA@mail.gmail.com>
Subject: Re: Kernel complexity
To:     stefan.bavendiek@mailbox.org
Cc:     kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

> I am currently doing a research project that aims to identify risk areas in the kernel by measuring code complexity metrics ...

Another aspect of complexity that might be worth a look is
modularisation, interface definitions for kernel components, etc. One
classic paper is "Ifdef Considered Harmful".
https://www.usenix.org/legacy/publications/library/proceedings/sa92/spencer.pdf
