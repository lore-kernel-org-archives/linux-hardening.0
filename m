Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D089C54EBE
	for <linux-hardening@archiver.kernel.org>; Thu, 12 Jan 2023 22:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240327AbjALWow (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 12 Jan 2023 17:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240147AbjALWou (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 12 Jan 2023 17:44:50 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBAD5E0B5
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 14:44:49 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id s3so12367381pfd.12
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 14:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EeqsYbPpxfJWvTt+bhcGbc3dFC6Uvdv57wMBIqHRb9o=;
        b=Sy/u1uw8JnqTqWOwChROVISdeBeRBaaUY/OivQqU1XTV7J28WUkJKdFqN2sCdgkcih
         yk4v7LtmwUNy1+ITlQHTHvnSObkiTyj476fvIBfa0QhdRBCPO62+fX3OP+Md346nJwAr
         Z2Z+XlIx2c2Loru9BU9MmSj4tZJ8FGANiRwRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeqsYbPpxfJWvTt+bhcGbc3dFC6Uvdv57wMBIqHRb9o=;
        b=4J8T3v++z52NFHqvXZ+CRWgqGzVUlZrdoe+LiclaT++PcbTZuMQ+v7ohS7jVgs9ydy
         eKza1PRNalY6XPFYtrKclf/ILdDnU+MCO6zSDenup+/LAarh3Ara8D5Ny3TahGlYGhYw
         C459cLQHkw2uoWzf4zduhuL9viJ8+dCUWxZFJ9SqiMDKFuM56PzwoPeqwphri60vwd1N
         pjkgTALNvfgIzqhVXZPPnMfRIBlcZtxSeWC60SljE17Ff/ogoYYleVJZBLxUAM7begMR
         NG/ZsQcwx+cppdVOTk7Dr1xGT19RN8IblEXGFyjXQwlZhLk7ne0gV73xrFZMd3o4a926
         cNpw==
X-Gm-Message-State: AFqh2koiwfX8NXixzIsD42By0h50FN6fzfOTfmIJNSJTsWT95IRrDQZG
        U+cXaouEEXuQe02KSGmLLMSIAQ==
X-Google-Smtp-Source: AMrXdXuT6rw2c83a5xiZbmvnFGz+zmKFF8iBdpkkGnPrrbiGWwgVglCbXrz8h/CXWglWWgcIVXcaXA==
X-Received: by 2002:a05:6a00:993:b0:581:c2d3:dc5e with SMTP id u19-20020a056a00099300b00581c2d3dc5emr66641575pfg.11.1673563489013;
        Thu, 12 Jan 2023 14:44:49 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 4-20020a620404000000b00576ee69c130sm12308549pfe.4.2023.01.12.14.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 14:44:48 -0800 (PST)
Date:   Thu, 12 Jan 2023 14:44:47 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Replace 0-length arrays with flexible arrays
Message-ID: <202301121444.104E492D@keescook>
References: <20230105190548.never.323-kees@kernel.org>
 <Y7xPSEMOWqz+3kgD@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7xPSEMOWqz+3kgD@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jan 09, 2023 at 05:30:48PM +0000, Sean Christopherson wrote:
> On Thu, Jan 05, 2023, Kees Cook wrote:
> > Zero-length arrays are deprecated[1]. Replace struct kvm_nested_state's
> > "data" union 0-length arrays with flexible arrays. (How are the
> > sizes of these arrays verified?)
> 
> It's not really interpreted as an array, it's a mandatory single-entry "array".
[...]
> >  
> >  	/*
> > -	 * Define data region as 0 bytes to preserve backwards-compatability
> > +	 * Define union of flexible arrays to preserve backwards-compatability
> 
> I think I'd actually prefer the "as 0 bytes" comment.  The important part is that
> the size of "data" be zero, how that happens is immaterial.

Oh, dur, I can read the comment. :)

It has to stay the old size -- this was a way to add an optional extra
struct to the end. Got it!

-- 
Kees Cook
