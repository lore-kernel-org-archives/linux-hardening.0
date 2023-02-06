Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF5FC05027
	for <linux-hardening@archiver.kernel.org>; Mon,  6 Feb 2023 18:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjBFSds (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 6 Feb 2023 13:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBFSdr (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 6 Feb 2023 13:33:47 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545F92943A
        for <linux-hardening@vger.kernel.org>; Mon,  6 Feb 2023 10:33:46 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id u9so8832253plf.3
        for <linux-hardening@vger.kernel.org>; Mon, 06 Feb 2023 10:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nsA2UVbKCTYlnuVnGq05GHQ3hw+n0oCMRqJ/EEYmCkY=;
        b=a8JT7ViEx13ThcmUiyF2xIGmZel1FmMIdSxh9b0Ym1e2KCNGIjq3ebNFJPPKMOI95u
         GhBDm+LkD10tN/iUWquKpJbNLSNFJnBNO/D8osbz+qYNr+WpSQujzATCtuMNGVszNeHg
         oHN3nHQrwjq9vUmrCl7Ubj/+xvglHlx+BzeCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsA2UVbKCTYlnuVnGq05GHQ3hw+n0oCMRqJ/EEYmCkY=;
        b=XUnUGp7zJWsl9CpReDb4fNSbQE221S5KmGFv0efkjg5k2nO17aky4SEXuYSyWU8z/W
         LA9T4JV5TAHOOfNJ+WWApCMdiCoFbhm0RO7e9NKDn1ulOoTKj83oP4a3aYsDXIiRYf4G
         ZyPD+qZJNDUypnibORZ425wmpmPxvuTdJtMReHIJpkt2s29eA1kvF3uNyV3RBOBks/cu
         tI5ukLex7v6e+NWBb61FotqpW1kmuEwfQ/yu2SRXmzINFqh/9cR0Clulv3iI4l7TiX3v
         /VvQhOG42ONq4k9cZzrwXiCRrH9nNbMInmp22dVPBXZKS2UWWZ3joSNWLHiVxk4BLS61
         5o1A==
X-Gm-Message-State: AO0yUKXN9Ee4zx9jGGxulnLvO7DmsYT3wnmf4nkTmY0IVkHFnlfjO2hd
        mG34jaBjWQOLRmzN5plB1RUEbA==
X-Google-Smtp-Source: AK7set9CifVfSRS5Qx9jbb4Jap5R1rgc3MgAYSMbbYEKryXVkG5v6CbaQv+jxsMKlO/VLsbwWLKAdg==
X-Received: by 2002:a17:90a:1d2:b0:22c:1613:1656 with SMTP id 18-20020a17090a01d200b0022c16131656mr592787pjd.26.1675708425833;
        Mon, 06 Feb 2023 10:33:45 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090a154100b0022bfa25dd88sm9995655pja.40.2023.02.06.10.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 10:33:45 -0800 (PST)
Message-ID: <63e14809.170a0220.7fcb2.150b@mx.google.com>
X-Google-Original-Message-ID: <202302061032.@keescook>
Date:   Mon, 6 Feb 2023 10:33:44 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] USB: ene_usb6250: Allocate enough memory for full object
References: <20230204183546.never.849-kees@kernel.org>
 <Y961c1/JIkDUqMbC@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y961c1/JIkDUqMbC@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Feb 04, 2023 at 02:43:47PM -0500, Alan Stern wrote:
> On Sat, Feb 04, 2023 at 10:35:46AM -0800, Kees Cook wrote:
> > The allocation of PageBuffer is 512 bytes in size, but the dereferencing
> > of struct ms_bootblock_idi (also size 512) happens at a calculated offset
> > within the allocation, which means the object could potentially extend
> > beyond the end of the allocation. Avoid this case by just allocating
> > enough space to catch any accesses beyond the end. Seen with GCC 13:
> 
> In principle, it would be better to add a runtime check for overflow.  
> Doing it this way means that the code could read an invalid value.
> 
> In fact, I get the impression that this code tries to load a data 
> structure which might straddle a page boundary by reading in just the 
> first page.  Either that, or else EntryOffset is always a multiple of 
> 512 so the error cannot arise.

Yeah, I couldn't figure it out. It seems like it might move in
non-512-byte steps too sometimes? Doubling the allocation (and zero-fill
it) seemed the safest way to cover it.

-Kees

-- 
Kees Cook
