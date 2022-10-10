Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E4AC433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 10 Oct 2022 22:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiJJWfa (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 10 Oct 2022 18:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiJJWf2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 10 Oct 2022 18:35:28 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FFC61DA6
        for <linux-hardening@vger.kernel.org>; Mon, 10 Oct 2022 15:35:26 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 129so11353194pgc.5
        for <linux-hardening@vger.kernel.org>; Mon, 10 Oct 2022 15:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oCUzlbX4lI+qBxINl7LzHl5RgJSkmrssEexCv70Q4K4=;
        b=HM2tl0TU+MT7+bFfNZ9o/foworkGDJQP+Nm06zNe83ukdGK6tywrs+HFpdwv11aRFO
         Izx9WfvTjPJ97W1SVuhaB/4HEPQancj6vN2alxJAt77JtV5TWmyZzwE+Vq2rITO05azr
         OVkgb6aYOkyB9kuGPVPNLzJydIFeLHO99sxwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCUzlbX4lI+qBxINl7LzHl5RgJSkmrssEexCv70Q4K4=;
        b=AZvogzrx/qcOSxWhXxufgd8AScfGgUPqB979nSdoBah72mfLy3D7KQr9+ZtjaMonxO
         qZaG+61gZrOeNNs1AufZfmGmVgBYulldhYlqowmJi9Xchx7oQP7iFOCdXmv6DrBUSuZy
         vcvFdtDSHE8E0WyroiJFWGS+aW+q4NdsaEfMPg3iWK3E/0/tBY2Znk6qAjDCyHbYmfgp
         Bdw4afC9RbvLwo3leZoK1jQQnH+xnskN3PBPsYmrqlESh0TUtSRdArAFCbej3djdMCf7
         Cbb66wEutwlIVwKCKorL4batWc3JHnu5QnNbIIIbklhu4EdxYS6Cyx+Bny71ZZT3ySF5
         jxBg==
X-Gm-Message-State: ACrzQf2LdlnA/7gSl5WSQsW/f1HTwVx97AmClbxbRjujiIf7fkDv6ByN
        Hx6wJR8ITv2vD5iiG3XvfY5e7g==
X-Google-Smtp-Source: AMsMyM60Ou9Efab64ujpBY0XfNTnxeOS7Gm7nER2LiLQbw09k18Z7G7kUFmUOCkRUr6Sh+imlj6BhQ==
X-Received: by 2002:a63:1d1:0:b0:43a:348b:63fd with SMTP id 200-20020a6301d1000000b0043a348b63fdmr19192959pgb.52.1665441325926;
        Mon, 10 Oct 2022 15:35:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 65-20020a630244000000b0045913a96837sm6707422pgc.24.2022.10.10.15.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 15:35:24 -0700 (PDT)
Date:   Mon, 10 Oct 2022 15:35:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Teigland <teigland@redhat.com>
Cc:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Christine Caulfield <ccaulfie@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] dlm: Replace one-element array with
 flexible-array member
Message-ID: <202210101534.BA51029@keescook>
References: <Y0IFEUjwXGZFf7bB@mail.google.com>
 <378C6BDE-0A68-4938-86CD-495BD5F35BE6@chromium.org>
 <Y0IsXXYnS4DnWkMW@mail.google.com>
 <202210082044.51106145BD@keescook>
 <20221010210039.GA30273@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010210039.GA30273@redhat.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 10, 2022 at 04:00:39PM -0500, David Teigland wrote:
> On Sat, Oct 08, 2022 at 09:03:28PM -0700, Kees Cook wrote:
> > On Sun, Oct 09, 2022 at 03:05:17PM +1300, Paulo Miguel Almeida wrote:
> > > On Sat, Oct 08, 2022 at 05:18:35PM -0700, Kees Cook wrote:
> > > > This is allocating 1 more byte than before, since the struct size didn't change. But this has always allocated too much space, due to the struct padding. For a "no binary changes" patch, the above "+ 1" needs to be left off.
> > > 
> > > That's true. I agree that leaving "+ 1" would work and produce a
> > > no-binary-changes patch due to the existing padding that the structure
> > > has. OTOH, I thought that relying on that space could bite us in the
> > > future if anyone tweaks the struct again...so my reaction was to ensure 
> > > that the NUL-terminator space was always guaranteed to be there.
> > > Hence, the change on c693 (objdump above).
> > > 
> > > What do you think? Should we keep or leave the above
> > > "+ 1" after the rationale above?
> > 
> > I think it depends on what's expected from this allocation. Christine or
> > David, can you speak to this?
> 
> Hi, thanks for picking through that.  Most likely the intention was to
> allow up to 64 (DLM_LOCKSPACE_LEN) character names, and then use the
> ls_name[1] for the terminating byte.  I'd be happy to take the patch

Should this just use:

	char			ls_name[DLM_LOCKSPACE_LEN + 1];

instead, or is the byte savings worth keeping it dynamically sized?

-- 
Kees Cook
