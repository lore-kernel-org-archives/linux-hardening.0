Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A0CC433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Dec 2021 20:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239977AbhLMUwZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Dec 2021 15:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbhLMUwY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Dec 2021 15:52:24 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E18C061574
        for <linux-hardening@vger.kernel.org>; Mon, 13 Dec 2021 12:52:24 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id m15so15573218pgu.11
        for <linux-hardening@vger.kernel.org>; Mon, 13 Dec 2021 12:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xd/geVV5iQZ5RVngLXS6r5C3mfATRLEGJeN13+1gw/Y=;
        b=lSc4MhfIu3ZEGZIItN2Cb6Cp0ngHuHp+l/DCoO2i44pddwyh9Hl+dKJNNkETA8Y+x2
         Up5Q3dT5UzA43Gjb/vrWmZhv3DFLeyA64LCHWVWeLr8Of4O1VxhSym6E/4V0FE4LodCo
         rRon3cDIUgbDENqL8XHRQIC7mGMMb8fWInyyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xd/geVV5iQZ5RVngLXS6r5C3mfATRLEGJeN13+1gw/Y=;
        b=D3OD2+2WaJT32Oz1ZRugLCNLmpAnelbeJHNg9CVlRtq/Yi9oNt5DHTOEJ2sqpf5O5F
         eSTTnFDi7m1vPwgGL/qmF1YDyMRnAw0xo12yDDHPlfVsIcHdHYGujMFxnh7Hg71bSZKy
         wztgu60MUOTYuUpviRHBzzZ/fU6kUFnh5ljJsMUnVL2JTLExYfsAsSzkAuOJmaUuR2ft
         0pl7qQv0SKUubQUL4VdlX5R82svAlIu6BVWOseLdFukFEWPrSvH6MnGNyM23xK5AOS9l
         70n60iaemCj/e2mILrkGTARLHHKOnShVZpVoEfQNNizASJZrRYFX/zhMIflvZ2B1h96c
         GCJw==
X-Gm-Message-State: AOAM533mk6EnqwOgRm9t5ZSNGi3xxKoSDzwblpvIV0HReY369ueWJ6J6
        w+X47tRKZPncSZZSou/aeiTeYQ==
X-Google-Smtp-Source: ABdhPJxhD7H8nLemaUTpuRLA3pBFqI73tNkb+g2OGw9uWsnY9HaH4gY0e2W45p+EShkX3RiSIF9Rbw==
X-Received: by 2002:a63:4b0e:: with SMTP id y14mr748109pga.8.1639428743647;
        Mon, 13 Dec 2021 12:52:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c6sm13810817pfv.54.2021.12.13.12.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 12:52:23 -0800 (PST)
Date:   Mon, 13 Dec 2021 12:52:22 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mm/usercopy: Detect compound page overruns
Message-ID: <202112131249.0D2A4A2C7@keescook>
References: <20211213142703.3066590-1-willy@infradead.org>
 <20211213142703.3066590-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213142703.3066590-4-willy@infradead.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Dec 13, 2021 at 02:27:03PM +0000, Matthew Wilcox (Oracle) wrote:
> Move the compound page overrun detection out of
> CONFIG_HARDENED_USERCOPY_PAGESPAN so it's enabled for more people.

I'd argue that everything else enabled by USERCOPY_PAGESPAN could be
removed now too. Do you want to add a 4th patch to rip that out?

https://github.com/KSPP/linux/issues/163

Thanks!

-Kees

-- 
Kees Cook
