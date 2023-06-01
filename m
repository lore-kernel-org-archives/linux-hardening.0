Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCD1C77B7E
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Jun 2023 20:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjFAUbj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Jun 2023 16:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjFAUbi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Jun 2023 16:31:38 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684E819D
        for <linux-hardening@vger.kernel.org>; Thu,  1 Jun 2023 13:31:35 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b025d26f4fso11592925ad.1
        for <linux-hardening@vger.kernel.org>; Thu, 01 Jun 2023 13:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685651495; x=1688243495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+wqcyp4CmxpgYeEHc8GcJ0HoG2EXsHPzXMFxXDEfLsg=;
        b=Q94S1yLY0nWcPU4aftdIP7iFZ+0tnpeB5SKyv2cGl8gHz9JYvwaxOfVnDgn9M0tLwG
         OK17SGHZ99X1XonVvgWbZPqVibIBYqYvGjn/tEKmQBiXW1GG6v7poNVXrOMC3K/Sxi93
         G6DXrPSnRO8r/dgFxY+kV5vZa6c1fWXnC4Mrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685651495; x=1688243495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wqcyp4CmxpgYeEHc8GcJ0HoG2EXsHPzXMFxXDEfLsg=;
        b=WINvpPdZqJzGV6bNuh9nXxLu0tYAHHLDYo27B/bIyRPGK6wJw52K6xGWQ/VSV+nt4f
         /io0JbOlmysk6UAnd//v293oor381ugliDb1Gsg9ky2jilc0EPnlJfZq0llYr25IEEpK
         N/I0mgUSOGrD8qnDLcL6+Xpfmb1l2rRFwxDW46CDmKdPma/UffaabkbxiDwSbn5s4lB+
         F51YXcswCR6FCKfsGLXvCf5rZulcXKhk7GXRUKd9v9ewAGJlYmmL0iWsIzoa/qA0vMpG
         4sRSFoAFT0vA6Otr7AIjXeuZrNXyWtuoX2w1iKB3FDqzosEhwLUaNHhrjI/cko5CDQrK
         IL3Q==
X-Gm-Message-State: AC+VfDz/tI78TKC+jUk1ciZ88YrGQ/ZnIj+foa5lYa8JJO2RFexvLVHW
        wpoyOMaZQ5EHkdEtNbGhormupA==
X-Google-Smtp-Source: ACHHUZ50FytdpQsyv66+VN0G5nKzPNryGrQhcvOnlh+7piyIN35if31vm6o+E+x5MGd1aTr+6gJlWA==
X-Received: by 2002:a17:903:2352:b0:1ab:253e:6906 with SMTP id c18-20020a170903235200b001ab253e6906mr357438plh.67.1685651494889;
        Thu, 01 Jun 2023 13:31:34 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o7-20020a170902bcc700b001aaed55aff3sm3888464pls.137.2023.06.01.13.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 13:31:34 -0700 (PDT)
Date:   Thu, 1 Jun 2023 13:31:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, gustavoars@kernel.org,
        linux@leemhuis.info, heiko.stuebner@vrull.eu,
        linux-hardening@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, joanbrugueram@gmail.com,
        masahiroy@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        ajones@ventanamicro.com, hi@alyssa.is
Subject: Re: [PATCH v2] riscv/purgatory: Do not use fortified string functions
Message-ID: <202306011331.880AF01743@keescook>
References: <168564402237.2891605.1600418987887898293.b4-ty@chromium.org>
 <mhng-8c6309b5-4ba9-4276-a8e6-2864426e77f0@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-8c6309b5-4ba9-4276-a8e6-2864426e77f0@palmer-ri-x1c9a>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jun 01, 2023 at 01:17:03PM -0700, Palmer Dabbelt wrote:
> On Thu, 01 Jun 2023 11:27:03 PDT (-0700), keescook@chromium.org wrote:
> > On Thu, 1 Jun 2023 09:00:28 -0700, Kees Cook wrote:
> > > With the addition of -fstrict-flex-arrays=3, struct sha256_state's
> > > trailing array is no longer ignored by CONFIG_FORTIFY_SOURCE:
> > > 
> > > struct sha256_state {
> > >         u32 state[SHA256_DIGEST_SIZE / 4];
> > >         u64 count;
> > >         u8 buf[SHA256_BLOCK_SIZE];
> > > };
> > > 
> > > [...]
> > 
> > Applied to for-next/hardening, thanks!
> > 
> > [1/1] riscv/purgatory: Do not use fortified string functions
> >       https://git.kernel.org/kees/c/ca2ca08f479d
> 
> Sorry, I'd just applied this to riscv/fixes as well.  I can drop it if you
> want?  I was going to send a PR tomorrow, just LMK.

I'm fine either way. I was carrying each arch's fix just since it was
related to the -fstrict-flex-arrays=3 patch in the hardening tree.

-- 
Kees Cook
