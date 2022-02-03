Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD892C433EF
	for <linux-hardening@archiver.kernel.org>; Thu,  3 Feb 2022 20:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbiBCU03 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 3 Feb 2022 15:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238135AbiBCU03 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 3 Feb 2022 15:26:29 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25EBC06173B
        for <linux-hardening@vger.kernel.org>; Thu,  3 Feb 2022 12:26:28 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id u6so8361567lfm.10
        for <linux-hardening@vger.kernel.org>; Thu, 03 Feb 2022 12:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3oi0WT6RtKYSCLVVcErN1iJ2hhuFG+VqgwHQjpgyVFs=;
        b=Mm52phJLNfjcK4ovXq4DsaG3QHiwJomSpW1FBRJS7+EIygSIgR+8+Qt2oh1fIrTcgo
         O9iHBnuNuft30SObwRl7eNJqy6H2fnWlwqO3XdreGjOYOA+YgbOEVnI8OCh2ZN4BlFo4
         mk2AlVTaTVCeIG8ityYF9mthVuflkz6V+ZKCwGFo95FG1yo+Y7pOueVTW+OmEtiQrmth
         zHOob3/aUidTR+XrYAtwwEURcBuTFGTEX3F9sTN3rL+g+cT0rWp1aBLBh8eUfxvReqz6
         Kq23PWEjmuaRyQuz7VLcQCjvtegaTyjP+Irm6fF8CvBl/2S6I5nGVikD0lHaICoiXdKK
         DUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3oi0WT6RtKYSCLVVcErN1iJ2hhuFG+VqgwHQjpgyVFs=;
        b=b2zpW6G/BUysHCA0bvrLDzMp+ULT0SHejAESoxase0oErzGqf7g67Yhexot6NEwPvc
         6feD4MHCP/FWMJ0MPOHyYNHRYZkjYU/ojerRNTDsx2L8tdXwBlmca5e3oNV/QWYvvFoD
         vB/B62JLay/QcwwQtW6O24M3zSyxhRwemKlw19ZDX4YAV+pgSg+DNDR/uBgnK9ZFUzWq
         +Brdg7HW6E4mp5gJ5fsikGpMWgOVcsJ6lwA1hEDZgAQ86g3EeC7pbTNdvXoQDdnFAUL3
         8+8qJAaSSEMUikjqHXu2DxO66RD81G4ZzJlv2IB13vbyZXJOYoOGMQmRptbJpfZxqqkm
         PLPg==
X-Gm-Message-State: AOAM5333RrsZmyTJmq/1j+46gN6rLkJIpA70I2Oa3gXAeFaWUKoGDFnc
        1H+vlb4a0MhOhnmCgA7WW2y2205sv8K4CBBtS05B9g==
X-Google-Smtp-Source: ABdhPJwGX975SvZnco4SUKPWlUpkyOX2+VfEHMxaO8GXGqai82myWhS4bR9uSWdSt+Ib4rMIxpNgB7rcdFzNsoAXY3g=
X-Received: by 2002:a19:6449:: with SMTP id b9mr28110189lfj.82.1643919986917;
 Thu, 03 Feb 2022 12:26:26 -0800 (PST)
MIME-Version: 1.0
References: <20220203173307.1033257-1-keescook@chromium.org> <20220203173307.1033257-3-keescook@chromium.org>
In-Reply-To: <20220203173307.1033257-3-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 3 Feb 2022 12:26:15 -0800
Message-ID: <CAKwvOdkU=5q-7Sb4BKYkRsigy_qYjo_7J+A73ZYKn+xArxUwXg@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] Compiler Attributes: Add __overloadable for Clang
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        George Burgess IV <gbiv@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 3, 2022 at 9:33 AM Kees Cook <keescook@chromium.org> wrote:
>
> In order for FORTIFY_SOURCE to use __pass_object_size on an "inline
> extern" function, as all the fortified string functions are, the functions

s/inline extern/extern inline/

Yes, they're the same thing, but it sounds backwards when I read it.

> must be marked as being overloadable (i.e. different prototypes).
> This allows the __pass_object_size versions to take precedence.

Is this because of the `const` additions to the function signatures?

-- 
Thanks,
~Nick Desaulniers
