Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7B7C43334
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 23:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbiFMXiJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 19:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbiFMXiI (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 19:38:08 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1669C2D1C1
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 16:38:08 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id o6so6392412plg.2
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 16:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yYnPEs+7/EXNKs1SsvGN2RDxQEUA+G2bdjO5VBujtGw=;
        b=S7zd2SJb98eiuS1hTdsLGxZdBfKOAjfqKZDpEP25H9fmqxQ4rH4DVMb5nxf82fJ6e4
         1I6NmI5I0mMvvSSfdcp9nCgNyzfbAxCVgoBFIvIp/g+v7yI/TMjcjDRg1nqEU+U66dWX
         B5GIIxBluY3wvR9xHtnc5LMyerTTGJHrN46Ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yYnPEs+7/EXNKs1SsvGN2RDxQEUA+G2bdjO5VBujtGw=;
        b=0zeJMXIFQe8wW8Uv4gZxH+m3jdozpcy7SH5r1/NBpKmx0YwZb86240fgBLUcL/f6QB
         fY4Uo+H9uPsHLYDN2DEen7cP/apOMvFpUYy9D5TS5+t3fXJwgj7Y6xqvepa4KyagS+7b
         DzgEskibxvTZ7IOtsSNwLnTkx5/xrGHrLKtbQBfrJRncx3Aef+ZIfubVBRjpV/LBs2f/
         Jykr7BQecDOI0v2Rit/EdQHtbcLOZ+EMOomoLWJwRAHT2k452llqcL054cVWqB8xJzVP
         R79fB3Ys0pfD0nISSig5JcEDKR9YQ+WogVWhYTNKDqsAMjlmD+fbXxXOjMfvhIm8SX+C
         XfjQ==
X-Gm-Message-State: AJIora/ojsNNmfUDqmcsm3rAd8E4eqfGmrrSkxQRnU2FZIsDlYZTdgrg
        LKAAJSzJfe2HL2EBt30quwMgHg==
X-Google-Smtp-Source: AGRyM1swu2ld1DxnRxMPl8aaTtMdbFsCt/DFNKG1CKXGkaGwR9A6TVWvwkIY+y+u84XhPfalzpKLiw==
X-Received: by 2002:a17:90b:4f81:b0:1e8:84b0:6aaf with SMTP id qe1-20020a17090b4f8100b001e884b06aafmr1278603pjb.66.1655163487586;
        Mon, 13 Jun 2022 16:38:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p16-20020a056a000a1000b0050dc76281b4sm6196710pfh.142.2022.06.13.16.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 16:38:07 -0700 (PDT)
Date:   Mon, 13 Jun 2022 16:38:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v4 22/26] arm64: mm: move ro_after_init section into the
 data segment
Message-ID: <202206131630.B6AE6ECEA3@keescook>
References: <20220613144550.3760857-1-ardb@kernel.org>
 <20220613144550.3760857-23-ardb@kernel.org>
 <202206130959.3C01F529@keescook>
 <CAMj1kXG8MsL5NHN61W+58Q2di1o9P3kaxUCNe4D5sXcdLhOkUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXG8MsL5NHN61W+58Q2di1o9P3kaxUCNe4D5sXcdLhOkUQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jun 13, 2022 at 07:16:15PM +0200, Ard Biesheuvel wrote:
> On Mon, 13 Jun 2022 at 19:00, Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Jun 13, 2022 at 04:45:46PM +0200, Ard Biesheuvel wrote:
> > > Currently, the ro_after_init sections sits right in the middle of the
> > > text/rodata/inittext segment, making it difficult to map any of those
> > > non-writable during early boot. So instead, move it to the start of
> > > .data, and update the init sequences so that the section is remapped
> > > read-only once startup completes.
> > >
> > > Note that this moves the entire HYP data section into .data as well -
> > > this likely needs to remain as a single block for now, but could perhaps
> > > split into a .rodata and .data..ro_after_init section later.
> >
> > If I'm reading this correctly, this means that .data..ro_after_init now
> > lives between .data and .rodata?
> >
> 
> No, between .initdata and .data

Ah, doesn't this mean more padding (for segment alignment) used? On other
architectures .data..ro_after_init tried to be near the writable/read-only
boundary so segment padding was only needed on one side (e.g. it could
live at the end of .rodata without segment alignment but before .data
which was segment aligned.) Then when .rodata was made read-only (after
__init), .data..ro_after_init would also get set read-only.

In this case, I think it ends up needing segment alignment both at the
front and the end, since the .initdata and .data are freed and left
writable, respectively?

-- 
Kees Cook
