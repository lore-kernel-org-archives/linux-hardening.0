Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD03FC77B7A
	for <linux-hardening@archiver.kernel.org>; Sat, 27 May 2023 02:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjE0CBK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 26 May 2023 22:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjE0CBJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 26 May 2023 22:01:09 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7394135
        for <linux-hardening@vger.kernel.org>; Fri, 26 May 2023 19:01:04 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ae4baa77b2so9434625ad.2
        for <linux-hardening@vger.kernel.org>; Fri, 26 May 2023 19:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685152864; x=1687744864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3YbAt9JjfLvKqD7ym0b4r1+hkDKL9O0I3I3mZ5235s=;
        b=PG4NLHltyMPfbb4jzVRi5VCXYGRdpjmbMDYTsTkw5J6vyg/XRr1KresINXxLI57xOO
         vEtUdQjRy08+0IVetoNywf0g0V/k4oRGaCgwquyCUMv3f1YX1nTYanjDTjG/TX51BfLM
         RQxV+o8OUIxaPnp6aNMHIavpJB3O/xTixFbHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685152864; x=1687744864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3YbAt9JjfLvKqD7ym0b4r1+hkDKL9O0I3I3mZ5235s=;
        b=MxAACHjDFMI3uSjcr1gjE9SpQt4d7dE/9G0mSxXO94CAk1rikliFfVCniH6YllMWSZ
         hv9HbjQtsbFQ2Jr4QEKICocx8Ye/sVp0okHn1Rfhq+KwhJI/h0W/XRqECCCgFS7qYon1
         6HoDX5lEU+V0HY6LFCYaXvr8Mk/jbdzeu+6wnaio5dbXYNDAR13AHgHxBLKEuflY/nUu
         iUOO5UpowDpFkHU/XoyRqnZ8o392k4At0LrHnAVOvvM2oOVMxi6GxX4Qz0qWPi0j4qws
         +j9JhhhIabSLogLHyTXlHom/HlpeBOnhalEcdJz0uZyQxQt3kLzQbeif6yv/5mobHpaH
         KjoA==
X-Gm-Message-State: AC+VfDykbvvDO/vSYzl3a0YZ5GjpvsfpndjRIeJq9fxwd5qRWitRBiP7
        cqBW+BHwcNufmQjnYQoUkac5tA==
X-Google-Smtp-Source: ACHHUZ4MlU0pdFRrWT9QBhsuI4cYeLR3QxRmEAF73ZxP7YcwsNZO8xecUtsC5xjwVTfHUJpTsK4kZg==
X-Received: by 2002:a17:902:c40c:b0:1af:f8a8:5bab with SMTP id k12-20020a170902c40c00b001aff8a85babmr4522123plk.52.1685152863998;
        Fri, 26 May 2023 19:01:03 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jj15-20020a170903048f00b001a922d43779sm3851246plb.27.2023.05.26.19.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 19:01:03 -0700 (PDT)
Date:   Fri, 26 May 2023 19:01:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] checkpatch: Warn about 0-length and 1-element arrays
Message-ID: <202305261859.310EB2972A@keescook>
References: <20230526173921.gonna.349-kees@kernel.org>
 <c65be7a615f5cfa300289a6f251d97286c8d81e9.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c65be7a615f5cfa300289a6f251d97286c8d81e9.camel@perches.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 26, 2023 at 06:38:27PM -0700, Joe Perches wrote:
> On Fri, 2023-05-26 at 10:39 -0700, Kees Cook wrote:
> > Fake flexible arrays have been deprecated since last millennium. Proper
> > C99 flexible arrays must be used throughout the kernel so
> > CONFIG_FORTIFY_SOURCE and CONFIG_UBSAN_BOUNDS can provide proper array
> > bounds checking.
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > @@ -7430,6 +7430,21 @@ sub process {
> >  			}
> >  		}
> >  
> > +# check for array definition/declarations that should use flexible arrays instead
> > +		if ($sline =~ /^[\+ ]\s*}\s*;\s*$/ &&
> > +		    $prevline =~ /^\+\s*(?:(?:struct|union|enum)\s+$Ident|\}|$Type)\s*$Ident\s*\[\s*(0|1)\s*\]\s*;\s*$/) {
> 
> I think this is overly complicated and not necessary
> 
> 		    $prevline =~ /^\+\s*$Type\s*$Ident\s*\[\s*(0|1)\s*\]\s*;\s*$/) {
> 
> should work no?
> 
> ($Type already includes this from @typeList):
> 	qr{struct\s+$Ident},
> 	qr{union\s+$Ident},
> 	qr{enum\s+$Ident},

Hm, I didn't when I originally tried it. I will double-check.

> 
> > +			if ($1 == '0') {
> > +				if (WARN("ZERO_LENGTH_ARRAY",
> > +					 "Use C99 flexible arrays instead of zero-length arrays - see https://github.com/KSPP/linux/issues/78\n" . $hereprev) &&
> > +				    $fix) {
> > +					$fixed[$fixlinenr - 1] =~ s/\[0\]/[]/g;
> 
> And this $fix doesn't work if the line is struct foo bar[ 0 ];
> and the use of /g is odd.

Thanks!

> Because the message is a WARN and not an ERR, please use
> "Prefer/over" and not "Use/instead of"

I will change to ERR, then. We must not use [0]-sized arrays ever.

> 
> 					$fixed[$fixlinenr - 1] =~ s/\[\s*0\s*\]/[]/;
> > +				}
> > +			} else {
> > +				WARN("ONE_ELEMENT_ARRAY",
> > +				     "Use C99 flexible arrays instead of one-element arrays - see https://github.com/KSPP/linux/issues/79\n" . $hereprev);
> > +			}
> 
> And this could have a $fix change too
> 
> 				if (WARN("ONE_ELEMENT_ARRAY",
> 					 ...) &&
> 				    $fix) {
> 					$fixed[$fixlinenr - 1] =~ s/\[\s*1\s*\]/[]/;

Almost never is it possible to only fix the struct when it's a 1-element
array (due to the impact of the size changes that be present in other
code), so I left it out.

I'll send a v3.

-Kees

-- 
Kees Cook
