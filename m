Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DA0C4332F
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Oct 2021 19:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF43861355
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Oct 2021 19:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhJTTNq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Oct 2021 15:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbhJTTNp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Oct 2021 15:13:45 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4DDC061753
        for <linux-hardening@vger.kernel.org>; Wed, 20 Oct 2021 12:11:30 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so3176041pjb.0
        for <linux-hardening@vger.kernel.org>; Wed, 20 Oct 2021 12:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VT1ZnTWZw0jMkeN3fDOrnC1r/jUp1V3OZwD2nwImWMk=;
        b=nre93T6MzHelf00EfakHYDHtu00QJEKItoSAkKHGP3gUTjHdigzheidpN0Cn+ghvKd
         LKWv2/OIotRWfXs/WCG7an5/vs5KygZtizL39PVLhD9YZOfqaFwrzigVA2RIjTye4bHE
         OWKNrjwp2iiSwr71nYKpU9JH0SPNhhNIbBfEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VT1ZnTWZw0jMkeN3fDOrnC1r/jUp1V3OZwD2nwImWMk=;
        b=XvkCEu5DjR7z3IhcVOoTDqsig4CMXGrtzSXu1M0dEttshn6wKzaLt0V9Tn5NQPMOdu
         TgolTSPVkl3IniGhbuBTfGWJQh0b2rszSUOFZKCoAXgvtTu10Mo5zjWIPjM/uAwn80y9
         xorkO6UV2axB1nTyw/skY2ktAdyJwp5IlklwqBDOHW6rCVYs6wKatDi10olvKiGNLJmA
         19KaE5jlTMf67t0TsRwKKrhP9YqNG5QvBoqr8F7SDIu00/pvJbInvThwniln1ABYjrg8
         BPLWG4ExJhWxTCErRbbBVIqcn0Z27NTLLgiYvgspyzEAGLUcDrgaEpEmHLeByLnI23vM
         bN8Q==
X-Gm-Message-State: AOAM533rGBGZtBryy3m4+PLZdFBoAzQerXSPgkHbxz7+4No7H9MvYpdE
        agTFpOlEcQcqb1lcctPXdCBFaw==
X-Google-Smtp-Source: ABdhPJyVMN7MoPGQBIowKQmEG8vN3pK31aaAQUVHuBVZpxjnw8chkJkUkW744OD0Z5Ryu083zYUf6Q==
X-Received: by 2002:a17:90a:e54d:: with SMTP id ei13mr950751pjb.65.1634757090342;
        Wed, 20 Oct 2021 12:11:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x13sm2869108pge.37.2021.10.20.12.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 12:11:29 -0700 (PDT)
Date:   Wed, 20 Oct 2021 12:11:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Emese Revfy <re.emese@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-hardening@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Dan Li <ashimida@linux.alibaba.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH 2/2] gcc-plugins: Remove cyc_complexity
Message-ID: <202110201210.1F70546@keescook>
References: <20211020173554.38122-1-keescook@chromium.org>
 <20211020173554.38122-3-keescook@chromium.org>
 <CANiq72kveT40jX8GWjs1dy0o3YjowUGtGTddPb+da114sb+4iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72kveT40jX8GWjs1dy0o3YjowUGtGTddPb+da114sb+4iA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 20, 2021 at 07:48:55PM +0200, Miguel Ojeda wrote:
> On Wed, Oct 20, 2021 at 7:35 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > - * Copyright 2011-2016 by Emese Revfy <re.emese@gmail.com>
> 
> Perhaps we should Cc this address to give them notice.

Good point; I'm in the habit of that happening automatically as Emese
was a co-maintainer of the gcc-plugins. Sorry for the oversight here.

> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

-- 
Kees Cook
