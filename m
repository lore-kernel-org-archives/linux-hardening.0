Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF13C05027
	for <linux-hardening@archiver.kernel.org>; Mon,  6 Feb 2023 18:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjBFShX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 6 Feb 2023 13:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBFShQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 6 Feb 2023 13:37:16 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55BD2B09B
        for <linux-hardening@vger.kernel.org>; Mon,  6 Feb 2023 10:37:14 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id o16-20020a17090ad25000b00230759a8c06so9297128pjw.2
        for <linux-hardening@vger.kernel.org>; Mon, 06 Feb 2023 10:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KLC/XkXNzAEy7VypcsOB1BhiDn5tCJJ6z4r2FO96gZ4=;
        b=Z6Xobl+ifCTmy3tuXbCb4/T7KQuqh1+ELYFMFncOG8gjGjYWHYVKBkKWf/hs7705kQ
         U9pBsHYgyI4LBsQZ4svp9ACnySmMw1lzFGzLx+r5Z3R6I6fYbCXXJfRBQAJhTeaJt2Rd
         DZ+n9H0FNUIhVcUTh+hGz3QzvSZi2ZTAZCEBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLC/XkXNzAEy7VypcsOB1BhiDn5tCJJ6z4r2FO96gZ4=;
        b=WKLk9FQXbDvGAyvOg4Vl5bSTxLYZRgQErvQ4TSlcylmQhS+WUizPm8a582xilIe4e9
         2/rDScitysiY17I9sh58hyqCiJhyp3qjTJxn+s3OxrnUGQtcJw4x30dP0gqaqFBMJtVI
         ACklGDPVtEdtk1eQfchdNNqw6yKaG0Tz1kXjd7mNYsqhiXqiIvX/eKmJd7zcQ4Xa+8Vn
         oStqL/ru+H5DPIpk26/YoxfWkD2IydYSMcPtcb8fQw4Dcb6ue0PHQvEzmeHJeZMiw8DH
         QqYzjL7JAvRg7EvR2eAIKiH6u8DDtLlQbsQYui57E333RVpcV1Jk4ocol7dLY6UbAb7j
         0TBQ==
X-Gm-Message-State: AO0yUKUagHxDzMpjZxZcF8G2qTSR+6ITf7uFBZ9WUqjpovfIlpNp0OHT
        08rXMfGgkNz9NEAowZE+2VDVxGepIPQtWUxz
X-Google-Smtp-Source: AK7set/Rzubn+NGDwIh+RLUe/eGNYmHcdSo19eILBU6BpKaPvO08yVnkIMQkb7RsLOZ4nQQiabKtPQ==
X-Received: by 2002:a17:902:e749:b0:196:68ee:f363 with SMTP id p9-20020a170902e74900b0019668eef363mr27185847plf.69.1675708634329;
        Mon, 06 Feb 2023 10:37:14 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090264cf00b001967580f60fsm7204461pli.260.2023.02.06.10.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 10:37:13 -0800 (PST)
Message-ID: <63e148d9.170a0220.20379.b4a7@mx.google.com>
X-Google-Original-Message-ID: <202302061035.@keescook>
Date:   Mon, 6 Feb 2023 10:37:13 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] btrfs: sysfs: Handle NULL return values
References: <20230204183510.never.909-kees@kernel.org>
 <Y99XGrFvXBL32cOO@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y99XGrFvXBL32cOO@kroah.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Feb 05, 2023 at 08:13:30AM +0100, Greg KH wrote:
> On Sat, Feb 04, 2023 at 10:35:10AM -0800, Kees Cook wrote:
> > Each of to_fs_info(), discard_to_fs_info(), and to_space_info() can
> > return NULL values.
> 
> The code says it could, but I really do not think that is possible at
> all, especially based on the fact that there have never been any crashes
> reported here.

I'm not sure that's a useful measure if we're trying to improve
robustness under memory corruption, but at least one of those helpers is
performing a type check, not just a simple container_of(), etc.

Regardless, yeah, if this can be done without NULL returns, sure, let's
do it. I just don't know this code well enough to say what's possible.
:)

-- 
Kees Cook
