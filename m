Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D96CCCA480
	for <linux-hardening@archiver.kernel.org>; Wed, 22 Jun 2022 23:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376939AbiFVXGV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 22 Jun 2022 19:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbiFVXGU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 22 Jun 2022 19:06:20 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04DA3F8A7
        for <linux-hardening@vger.kernel.org>; Wed, 22 Jun 2022 16:06:19 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id h9-20020a17090a648900b001ecb8596e43so842856pjj.5
        for <linux-hardening@vger.kernel.org>; Wed, 22 Jun 2022 16:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GWgCOPHVCsSP/TuUu0PCa1rEe1EzPOJErWw/faw3k7I=;
        b=L0KiNlT5/q+Sj8TLlAxInEXBI/jH6Jz0f7JbSB+NX0Lcosq8pVzFAvH7JkCnoNn5C+
         adnyeo5GosxpWS2481vxZy2EwwXfYoTZ0/F7OuZV8L3J7e+VZEaomDxmQB3TzT8h66Um
         iOyOuZJP9jJaS4L1pkWIPCRsl/GJnHWAEWij4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GWgCOPHVCsSP/TuUu0PCa1rEe1EzPOJErWw/faw3k7I=;
        b=FI4czSS7NvzNElIQv7P3mlPExcqZVErXNLtQWcynjUJe+IDKKf+hiwbyjoSJtbqIeb
         oEnpvrQFSdzJ8wypu9dovxtrMnFU1iKfT8IBcBrtWtKJq+mKHk6DPEyKEDIBipAbQol5
         wpAoNeB+T9lmJVTYEK52ecKpARJ+A//nqBLXsid9Q6DUDVF6P79IP33K7dq/kYOAuUFL
         DOmFc6xSCCOMNpuOBxJ5ox6a0H4NIKPc70rsGvXGUHKC/sEscmsC4V+0d8zaEX2+f/Vq
         9ZsMjMIgaCFO6IoNKYPVOfBLerDTaudpbRiNt8cGj5ouKh48DNwNQi2ruAfmJlBVfYl4
         2nxQ==
X-Gm-Message-State: AJIora8KgTWwAMChNNVIh/TfIHlHkovSndnJV1FPkTW1uBhDtn4el7yG
        Nf5HmEba+W78U7BiyaMghXshMg==
X-Google-Smtp-Source: AGRyM1scptqjMQDvR20VQFk7QLPp1/95Q51pPXYIVhnZtGYbJSvPKrk/bb1YlRXyjq3c1JZcwZmcrA==
X-Received: by 2002:a17:90b:4c8f:b0:1ec:cdd0:41b7 with SMTP id my15-20020a17090b4c8f00b001eccdd041b7mr748561pjb.119.1655939179195;
        Wed, 22 Jun 2022 16:06:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x21-20020aa79575000000b005251fff13dfsm7765332pfq.155.2022.06.22.16.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 16:06:18 -0700 (PDT)
Date:   Wed, 22 Jun 2022 16:06:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Muni Sekhar <munisekharrms@gmail.com>
Cc:     linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux: Use-After-Free exploitation
Message-ID: <202206221605.EA67203C58@keescook>
References: <CAHhAz+jSYb6=x89oFin=AHBrNhg_Q61YQvanb=2ZGkZBDiLyiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHhAz+jSYb6=x89oFin=AHBrNhg_Q61YQvanb=2ZGkZBDiLyiw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jun 22, 2022 at 11:38:39AM +0530, Muni Sekhar wrote:
> Use-After-Free bugs result in kernel crashes. If these bugs result in
> kernel crashes then how is it possible to exploit this vulnerability
> for local privilege escalation?

There are many examples of manipulating memory layout in a way that an
attacker can control. For example, see:
https://googleprojectzero.blogspot.com/2021/10/how-simple-linux-kernel-memory.html

-- 
Kees Cook
