Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF858C433FE
	for <linux-hardening@archiver.kernel.org>; Tue, 18 Oct 2022 18:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJRSZa (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 18 Oct 2022 14:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiJRSZN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 18 Oct 2022 14:25:13 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F77326E9
        for <linux-hardening@vger.kernel.org>; Tue, 18 Oct 2022 11:25:05 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id 10so14689919pli.0
        for <linux-hardening@vger.kernel.org>; Tue, 18 Oct 2022 11:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XnD0cUVp+TOTlgr52vU4IJ+UQNYJwnMUoL+t7q45VyE=;
        b=knjecM+JwXsRjmXTN38QTXdo60yLmZbtz3TiWB6dKs1qQ30ZMLuU5uJKsLks+W19SL
         MhCYYnb+l60NN2dFy1uHPJPAONKJjdBvZIKuQ839w8pnHn6FV3rCq6AXDJoeopNRIXa7
         NAdJf2F6f8oMnGxEvBxeISjz0+pS8DGQ57Cvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnD0cUVp+TOTlgr52vU4IJ+UQNYJwnMUoL+t7q45VyE=;
        b=n0+6EleXcddW+46kzR+K/HxwLSbt6XGwDmQn61UJB7MvsUBwgtY/XDrP+pShfWDWWx
         f5j0e1p00KhhUNOQy4GPGLhlxFcxHIm1eHBBkSKg59kkuWFW8wwTY+J8ie2uWTFJ/eQV
         wscf/0aqZoJD+qeSSTKGC/MMU6DDdiN88BiUK2yhAW3dBAdWKejo/lCkFfvzqdBc64sR
         9137PG7/jmainYVm0dsLMGud8mEP7b6XFP42ySt0MZYvJBd3Bz+/tc/XONYxcZFhNiYe
         IzAoVuEoZfp98wIb/VT1A/6PRJQvQGBSVElmu8N3Go+R/Gbg7k79AWqNYyg88yI6ivC3
         ZdYQ==
X-Gm-Message-State: ACrzQf0t2XIqfJgPC81KgtV9jdL8K3jsO0h9K/wRGx4SA5BGg3XXAk1N
        pDmqWb+s9gHmAkrKx9XSWt3paw==
X-Google-Smtp-Source: AMsMyM56wYSQF4d6PdxkC9KXMD1lXxNzi/2pnc/ihUXr+HLyRnxmdbs1/lcrj69ovUsn97pESxrYwQ==
X-Received: by 2002:a17:902:ea85:b0:17f:88c1:7015 with SMTP id x5-20020a170902ea8500b0017f88c17015mr4189852plb.49.1666117504543;
        Tue, 18 Oct 2022 11:25:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m4-20020a170902f64400b00176b84eb29asm8884968plg.301.2022.10.18.11.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:25:03 -0700 (PDT)
Date:   Tue, 18 Oct 2022 11:25:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 6/9] fs: Introduce file_to_perms() helper
Message-ID: <202210181124.73B5B7ECCE@keescook>
References: <20221013222702.never.990-kees@kernel.org>
 <20221013223654.659758-6-keescook@chromium.org>
 <20221018141037.zzpfjzutqbutbpiy@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018141037.zzpfjzutqbutbpiy@wittgenstein>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Oct 18, 2022 at 04:10:37PM +0200, Christian Brauner wrote:
> On Thu, Oct 13, 2022 at 03:36:51PM -0700, Kees Cook wrote:
> > Extract the logic used by LSM file hooks to be able to reconstruct the
> > access mode permissions from an open.
> > 
> > Cc: John Johansen <john.johansen@canonical.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Cc: linux-security-module@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/linux/fs.h               | 22 ++++++++++++++++++++++
> >  security/apparmor/include/file.h | 18 ++++--------------
> >  2 files changed, 26 insertions(+), 14 deletions(-)
> > 
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 9eced4cc286e..814f10d4132e 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -993,6 +993,28 @@ static inline struct file *get_file(struct file *f)
> >  #define get_file_rcu(x) atomic_long_inc_not_zero(&(x)->f_count)
> >  #define file_count(x)	atomic_long_read(&(x)->f_count)
> >  
> > +/* Calculate the basic MAY_* flags needed for a given file. */
> > +static inline u8 file_to_perms(struct file *file)
> 
> As long as there aren't multiple users of this and especially none in
> the vfs proper please don't move this into fs.h. It's overloaded enough
> as it is and we have vague plans on splitting it further in the future.

Sure -- this can live in a security .h file somewhere.

-- 
Kees Cook
