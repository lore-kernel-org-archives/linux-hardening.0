Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACA3C77B7A
	for <linux-hardening@archiver.kernel.org>; Wed, 31 May 2023 00:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbjEaAle (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 May 2023 20:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjEaAld (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 May 2023 20:41:33 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7E1115
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 17:41:02 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d3e5e5980so5963700b3a.2
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 17:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685493661; x=1688085661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hdGugcn5c2JbfD3Z/D2lhqlqML+TkkwlsJOLG2bXoh8=;
        b=Y5plRcLGLfqdQbw1UCKZWDoHUbZNcvVwqz2tAS84QoUFIX61CaS013NTvJ/l+TcnRL
         uQBOKbUzrfPkieJ8GvjW/G0Hg3GswjuPNFXEwDtNQYUzUHX1+t8nV6YftMloja+Nuw1k
         Bzhj1i5IB7rhPSpiBllVKoSGl4T2LkbkVqiSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685493661; x=1688085661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdGugcn5c2JbfD3Z/D2lhqlqML+TkkwlsJOLG2bXoh8=;
        b=Kg77UHBhUalZvB/4JBmtoybuvA2jpKNNqVKiNkejeqfkeE0kLn1O35S4AamxBEqwuL
         mfywNy3zH7oIe5Hi4m0mYGXcH6ZUXA+TyLH9u7yl9U8xGlOoq9RJwnWRGmWnc9t7T7Rs
         gCtsws+zGuUn6bdMWeYhsKvkK2ezkF246O6ahHxpktH802mB9Zkkg1IS9AUWUQqIQAD7
         oZi31xsEVfYizUohY0ODVyviR3+99Vozglb1sAqoGeAyCtT0GbP+GLt1aMv1Uuqi/I2q
         ZHWlzYK9qFKbNlGn7O+oaJdFIzt4LXVs1hCB2TUAXEep0g7RB9ImslhdZOYuebA44TWM
         Nlnw==
X-Gm-Message-State: AC+VfDxUFDFDnPj+L3Tgs+ESmA6P24zMR4rgXbWlSr/4U1Hdgk3tHz93
        gTqsB6me2H9XavHrubmijs/1aQ==
X-Google-Smtp-Source: ACHHUZ6o1TQD/LukUZ04g3mHlB+kzTrtMEcpfvB36LePlbV5OsZ8XYnic1rrkt7epqhp0cNM6nA69Q==
X-Received: by 2002:a05:6a00:1a51:b0:64f:4812:8c7e with SMTP id h17-20020a056a001a5100b0064f48128c7emr4233724pfv.19.1685493660885;
        Tue, 30 May 2023 17:41:00 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j15-20020a62b60f000000b0064559b58eb8sm2141155pff.154.2023.05.30.17.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 17:41:00 -0700 (PDT)
Date:   Tue, 30 May 2023 17:40:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] checkpatch: Check for 0-length and 1-element arrays
Message-ID: <202305301738.92C6DE1D@keescook>
References: <20230527020929.give.261-kees@kernel.org>
 <75851e1185821084c0a1b7e5aaf60e9f38e0f792.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75851e1185821084c0a1b7e5aaf60e9f38e0f792.camel@perches.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 26, 2023 at 09:31:39PM -0700, Joe Perches wrote:
> On Fri, 2023-05-26 at 19:09 -0700, Kees Cook wrote:
> > Fake flexible arrays have been deprecated since last millennium. Proper
> > C99 flexible arrays must be used throughout the kernel so
> > CONFIG_FORTIFY_SOURCE and CONFIG_UBSAN_BOUNDS can provide proper array
> > bounds checking.
> 
> Hi again.
> 
> 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -7430,6 +7430,21 @@ sub process {
> >  			}
> >  		}
> >  
> > +# check for array definition/declarations that should use flexible arrays instead
> > +		if ($sline =~ /^[\+ ]\s*}\s*;\s*$/ &&
> > +		    $prevline =~ /^\+\s*(?:\}|$Type)\s*$Ident\s*\[\s*(0|1)\s*\]\s*;\s*$/) {
> 
> Ahh, now I see why you want to use (?:\}|$Type) to find
> struct arrays defined as the last object in another struct.

Yeah -- this has been a place where past "[1]"s have snuck in before. :)

> grepping for some existing variants, perhaps the $sline test should
> be extended to something like:
> 
> 		if ($sline =~ /^[\+ ]\s*}\s*(?:__packed|__attribute__\s*$balanced_parens)?\s*;\s*$/ &&

Ugh, I forgot attributes. Hmmm. I don't need this check to be _perfect_
either. :P Really only "__packed" has come up in other conversions.

> > +			if ($1 == '0') {
> > +				if (ERROR("ZERO_LENGTH_ARRAY",
> > +					  "Use C99 flexible arrays instead of zero-length arrays - see https://github.com/KSPP/linux/issues/78\n" . $hereprev) &&
> 
> Instead of github links, how about using:
> https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays

Yeah, though the issues have a bit more detail. Probably better to be
self-referential. :)

> 
> 
> Why not combine both of these into a single ERROR?
> What's the value in separate types?

Yup, with the same URL (instead of separate URLs), it gets cleaner too.

Thanks!

-Kees

-- 
Kees Cook
