Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137C4C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Oct 2021 08:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3639610D0
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Oct 2021 08:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhJUIns (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 21 Oct 2021 04:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhJUIns (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 21 Oct 2021 04:43:48 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13257C061749
        for <linux-hardening@vger.kernel.org>; Thu, 21 Oct 2021 01:41:33 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y7so5264290pfg.8
        for <linux-hardening@vger.kernel.org>; Thu, 21 Oct 2021 01:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2szSRJSYc8e5G8aReqvAdlYT615SY5Xyth2O0S9i5EA=;
        b=R/JFIIO71DC4B8FZT8SFlh35ESr/rDqgqIK6hU47HaqbrWmM/nlRmVrw1TliFJaQGp
         yiLgscqGcddHyPxF2hDyQyG0PnwyOc/NOGVUOzkeiiki0GFxNvps5YgUTC7bFxHAmz9o
         RENSzgGLKiClC4kSVQcVmr146m4MfifdzsQ+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2szSRJSYc8e5G8aReqvAdlYT615SY5Xyth2O0S9i5EA=;
        b=Iwml7sXH5UMccNucSLcu0fUoGJppSTv3aj+TYZMcfL2fzeApJBZ13RFkM6RacMB8tw
         iCvWnD0XUCXdOmlRJK0lsAEgHlJQYdmEmnjk50dt0oIMamOcWM+Cw+/NxsrgrElsMtBH
         BZd/oYX0BtbIGycUfo+zb5DCxF00cg6ylmWyKQ0EbhggQdb5ciqiCpkzzBdp/2cbEEIT
         Wwdj3h9spIVxb/WbvxDszlZZhGU1NF8T8XwZnwRi9NKwCssvV79snsWHf8NISfsYbKSq
         Yg+eMD1yraz9WByXuWg/oyItXyD7FJ5i2sptOXPHC3dvbTxCP2f90GwZJc2hqhKo2jLO
         b2+w==
X-Gm-Message-State: AOAM533JjI7ic49iXeCRu9Q3Xc+nu8n5KDZEb/aTKkmhARLKL1n9gU/J
        199SfWtPa2YzIE/gX3BxGMrDgQ==
X-Google-Smtp-Source: ABdhPJzZ0IduZ0HmTOr2ADCd2Oyhef9o1xjVVfDk02WNxKb9rfMRhGXQNRmXtjIPZWN7AdZYyRQUMA==
X-Received: by 2002:a63:d60a:: with SMTP id q10mr3402711pgg.335.1634805692575;
        Thu, 21 Oct 2021 01:41:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h13sm4441922pgf.14.2021.10.21.01.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 01:41:32 -0700 (PDT)
Date:   Thu, 21 Oct 2021 01:41:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Masahiro Yamada <masahiroy@kernel.org>, llvm@lists.linux.dev,
        Ard Biesheuvel <ardb@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] compiler-gcc.h: Define __SANITIZE_ADDRESS__ under
 hwaddress sanitizer
Message-ID: <202110210140.D42185CAC@keescook>
References: <20211020200039.170424-1-keescook@chromium.org>
 <CANiq72ncBda6WE6ZTF9WDssHkMmM+JC5q8vkdNwiXFXTsSrnwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72ncBda6WE6ZTF9WDssHkMmM+JC5q8vkdNwiXFXTsSrnwA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 21, 2021 at 12:45:02AM +0200, Miguel Ojeda wrote:
> On Wed, Oct 20, 2021 at 10:00 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > I'm intending to take this via my overflow series, since that is what introduces
> > the compile-test regression tests (which found this legitimate bug). :)
> 
> Not sure if there is a particular reason I was in the `To` field
> (please let me know if so), but the patch sounds good to me!

Well, I didn't want the "To" to be me, and IIRC, you had sent a review
for Arnd's prior version.


> Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

-- 
Kees Cook
