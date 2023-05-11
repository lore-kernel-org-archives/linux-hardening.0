Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09FAC7EE22
	for <linux-hardening@archiver.kernel.org>; Thu, 11 May 2023 19:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjEKTHy (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 11 May 2023 15:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239062AbjEKTHn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 11 May 2023 15:07:43 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277475BA6
        for <linux-hardening@vger.kernel.org>; Thu, 11 May 2023 12:07:42 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64115eef620so60142261b3a.1
        for <linux-hardening@vger.kernel.org>; Thu, 11 May 2023 12:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683832061; x=1686424061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BQWcZP56mRpv21XSp3mAh6/oFkWbzx9zBnR5fexEFcE=;
        b=CMSgfMDqTVnZr9kbo0RfFWiLTyc/ZAK5aKFsvdUaOrxg1ETzlJlgcyTibi60ZRNN0a
         /rOB9iTY7Ee9ik1/8GaSgqc1DSvS3wJnc+2uoNypk6Tf/ZPXYldIr4WJIcyD/BiiN3vR
         DiVHtfB5vylMMmqSvZm+ePPqn3ubHmwvpCgCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683832061; x=1686424061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQWcZP56mRpv21XSp3mAh6/oFkWbzx9zBnR5fexEFcE=;
        b=Hwz4CmcHGv+eO5HG3T9kGQ6YtK4mcmVJTvj3X1U7PuTloILCq4tc0flq8cx1SK7AAt
         yFV3vk/VRF3jO+lHtr3IieUGBZ+ZJcLlX2TsiT/wWWMr9QbS2zawvmZG77GFWp8ac5Ma
         kJioohvk4LUuiwmrJiUqG4czMznTGgO8EMmevdQwYL8UoJDtkzP8R6YYfkgZcHWhosyN
         EPLFS8oI2u39P5oqlr5ubN1BhYxPUPZNjJmxHc/XzJ9O65g/ATyWPF/MmodSBO4cWJaw
         THym3fZqBg74L0gN6qNTuIZU9jIcyXJuIzqcCxpQr+DAfBkmV0jUWxDEDL741mx05NQG
         b6kw==
X-Gm-Message-State: AC+VfDxqpLeTEZXNS6Pd7KXQcl0sLfNf1QJkLDchRqdT8sNULdDz8IR+
        YGAqW0mLnPECB8WuQHVFFGEZgA==
X-Google-Smtp-Source: ACHHUZ4w/bmg/Fb6BPdd9vBe7MRp7/HQR8TzAlPAcT7ognmeiYRxRnTu9kFmUbZcNUVWcG3DvurkDA==
X-Received: by 2002:a17:90a:bb05:b0:250:af6d:bd7b with SMTP id u5-20020a17090abb0500b00250af6dbd7bmr10810154pjr.24.1683832061246;
        Thu, 11 May 2023 12:07:41 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id cl2-20020a17090af68200b002465a7fc0cfsm15756738pjb.44.2023.05.11.12.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 12:07:40 -0700 (PDT)
Date:   Thu, 11 May 2023 12:07:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     GCC <gcc@gcc.gnu.org>, Alejandro Colomar <alx@nginx.com>,
        Andrew Clayton <a.clayton@nginx.com>,
        Andrew Clayton <andrew@digital-domain.net>,
        linux-hardening@vger.kernel.org
Subject: Re: [wish] Flexible array members in unions
Message-ID: <202305111158.C78642624@keescook>
References: <ac2550e0-2f5c-3680-08e6-0c224d043036@gmail.com>
 <44940599-7b43-99f6-5b09-4f050d645c7b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44940599-7b43-99f6-5b09-4f050d645c7b@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, May 11, 2023 at 06:29:10PM +0200, Alejandro Colomar wrote:
> On 5/11/23 18:07, Alejandro Colomar wrote:
> [...]
> > Would you allow flexible array members in unions?  Is there any
> > strong reason to disallow them?

Yes please!! And alone in a struct, too.

AFAICT, there is no mechanical/architectural reason to disallow them
(especially since they _can_ be constructed with some fancy tricks,
and they behave as expected.) My understanding is that it's disallowed
due to an overly strict reading of the very terse language that created
flexible arrays in C99.

> [...]
> Currently, the Linux kernel has to go through some hoops due to this
> restriction:
> 
> 
> $ grepc -tm __DECLARE_FLEX_ARRAY *
> include/uapi/linux/stddef.h:42:
> #define __DECLARE_FLEX_ARRAY(TYPE, NAME)	\
> 	struct { \
> 		struct { } __empty_ ## NAME; \
> 		TYPE NAME[]; \
> 	}

Yes, we've had to do this as we eradicate all the fake flexible arrays
in the kernel which cause endless bugs[1]. Additionally, we'll be
using -fstrict-flex-arrays=3 soon to let existing array bounds checking
mitigations gain coverage over trailing arrays. All of this means that
we're converting a lot of code that is happily using dynamically sized
arrays in unions, etc.

[1] https://people.kernel.org/kees/bounded-flexible-arrays-in-c

-- 
Kees Cook
