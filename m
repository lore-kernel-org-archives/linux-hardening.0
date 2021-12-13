Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AC9C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Dec 2021 20:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242441AbhLMUsA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Dec 2021 15:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbhLMUr7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Dec 2021 15:47:59 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9659CC061574
        for <linux-hardening@vger.kernel.org>; Mon, 13 Dec 2021 12:47:59 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 8so16000368pfo.4
        for <linux-hardening@vger.kernel.org>; Mon, 13 Dec 2021 12:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eqk7jFNpc/SH/qINtrLZmX7rz6WzU7wy/i8GODHyph8=;
        b=gtoDoj7zftTSDacSWlLcucF0Y+x7ZVprYxu1SmOcS4rpu3wp6LiBOFaWaajY15N9aE
         x6p2zW31go3m7OPw9ne5sS3i5ffP6srY61uF9CMT9EYirXJf1k8Ap2LrIGvN4biZiyFY
         gVWE/FgpVDj2rj+kcO8IjQ/Hm2OdnBZaOk0pQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eqk7jFNpc/SH/qINtrLZmX7rz6WzU7wy/i8GODHyph8=;
        b=GgIBKsS9ARlZhVer1w8YIx7M2tvG4X3/d8wu8v8o8n8HrgIX3woWPKXA0aDX1FPYDD
         ZrvCCEZa34IZ+klqUos0uC9Y6MzU96fnF8w3EMFbANtjf+rof3KYw64B3cZ4LTTUPr9/
         TTK+GzeIEs3HKjLUynCE6jLNfhydNWyVkn4fOpEcMRtZgsuTv4/tz/5TVSK+sTksKkd7
         hVtlHDNM6e2WHmqFIQZYBAKXy0GL6LLREmIUYUQbCllEpsBRNJDX4O4sLozb83LSeR0A
         zw+GmR+fQohNTPvlClmx6+Qn0dUSGF8R2yoYrQZqnfuo26Gk7TZ2ZQlWQyFauwv0jIwG
         lL1Q==
X-Gm-Message-State: AOAM532biJh4QLDacxi4CsnfGb5fi+p/oE0YUkHyk+e/m87LrFtyKVXI
        6yQhh1WltTz+YVj3GOcAOi1+Qg==
X-Google-Smtp-Source: ABdhPJy3cTRWZARtl258fW/RQaHnimDEQQIDDVMQwTVVZe7Xv5B8uFrvjs0/l64nBo/NkYTztu75Ug==
X-Received: by 2002:a05:6a00:124d:b0:4ad:574d:4d2f with SMTP id u13-20020a056a00124d00b004ad574d4d2fmr460593pfi.24.1639428479163;
        Mon, 13 Dec 2021 12:47:59 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lb4sm31923pjb.18.2021.12.13.12.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 12:47:58 -0800 (PST)
Date:   Mon, 13 Dec 2021 12:47:58 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     William Kucharski <william.kucharski@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] Assorted improvements to usercopy
Message-ID: <202112131246.4BBFBA69A@keescook>
References: <20211213142703.3066590-1-willy@infradead.org>
 <196BFB9E-9A72-48B1-863E-021DE0B162A7@oracle.com>
 <YbesvmxAI3P5UFnv@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbesvmxAI3P5UFnv@casper.infradead.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Dec 13, 2021 at 08:27:42PM +0000, Matthew Wilcox wrote:
> On Mon, Dec 13, 2021 at 07:18:57PM +0000, William Kucharski wrote:
> > I like these, but a quick question:
> > 
> > Since the usercopy_abort() calls are all because the offset exceeds the page
> > size, is there a reason why you don't specifically state that via the detail
> > parameter rather than just supply a NULL pointer?
> 
> Hmm ... I'd defer to Kees on this, because I'm not familiar with
> usercopy_abort() usage, but the only places which use the detail
> parameter today are slab/slub, which use it to pass the name of
> the slab.  I think the user is supposed to infer that we overran the
> end of the page based on the offset & length values.

I agree that leaving it NULL is best here. The "detail" is really about
adding more information about which thing it was, which for slab makes
sense, but most other stuff there isn't really anything to quickly
distinguish one from another (i.e. vmap is all vmap).

-- 
Kees Cook
