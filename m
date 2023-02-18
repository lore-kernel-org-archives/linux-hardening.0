Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C7FC05027
	for <linux-hardening@archiver.kernel.org>; Sat, 18 Feb 2023 00:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjBRANI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 17 Feb 2023 19:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjBRANH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 17 Feb 2023 19:13:07 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2933B23E
        for <linux-hardening@vger.kernel.org>; Fri, 17 Feb 2023 16:13:06 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id s4-20020a17090a764400b002349a303ca5so2911105pjl.4
        for <linux-hardening@vger.kernel.org>; Fri, 17 Feb 2023 16:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QMelb1MnDD6swE/8CM85xQAKKs5hVr859DAyzVGp7Mc=;
        b=DKnkY30Bpzy7biEAGQieBHufMzJSRVjgkN4WiZk2hYeL446IpnrkMUUcor3l4aQ3sy
         S1mAuAwCqfNb+dqo7hy7udepJak1w8xXcuKJ8gaJ8OU5d4kIqSluJK3LpeQfhDvdBH4b
         go0lmvq7wNql5rT1G4PjgkSylcD2KS93eYoHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMelb1MnDD6swE/8CM85xQAKKs5hVr859DAyzVGp7Mc=;
        b=tq9qEOBpaeeV6stc0af5a+GNNbTQ52qKDYdYjWzbM2vZVYB4uQqqTjNJcxAZk76iF7
         b0oOhJ+eU/gVzsGph0Kv9T0ho/vL9Mi6wVmQL6o/dlu5XKvsEfchZFNMH70T1sRtSOc2
         0dE4TT6Ue/X9A0EFmaD7NdKUDNmjfIFn9M5jU4gtYNdo+jlXDHTM6xgrLYhKKelYPAn+
         +YMxQT1k1dcXoAYgecIIebHASorj94RrGKXb4DR78UngZp32co4RRZVRTAMpD8qESsak
         fGCJT3qPqOhRHn1SEQXyxKYK7fMWpQElan6Xpe7Gpdmiq/fDOCzB+ABca2r/siL9xs05
         J1Ww==
X-Gm-Message-State: AO0yUKW13GNq/5DlPlpcZpkCjuUpy3U7wANUxSt9t2WwoWjH9ZOQKIy+
        VLQNDZD/umZOhqRvCT1q9pcRJg==
X-Google-Smtp-Source: AK7set/h4bG49uL8qy+abJ0R63Qu7+miyWPJjJW+xK6sdj1ETCTFul1V16PMsEoEoieJb+H0rwRDHQ==
X-Received: by 2002:a17:902:cf0c:b0:199:5111:9987 with SMTP id i12-20020a170902cf0c00b0019951119987mr6501283plg.32.1676679185524;
        Fri, 17 Feb 2023 16:13:05 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a23-20020a170902b59700b0019a82ff8c38sm3661564pls.29.2023.02.17.16.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 16:13:04 -0800 (PST)
Message-ID: <63f01810.170a0220.110a8.6fe1@mx.google.com>
X-Google-Original-Message-ID: <202302171554.@keescook>
Date:   Fri, 17 Feb 2023 16:13:03 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        samba-technical@lists.samba.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] smb3: Replace smb2pdu 1-element arrays with
 flex-arrays
References: <20230214232928.gonna.714-kees@kernel.org>
 <CAKYAXd-fcukmXfdwiAxOxe+5c+Y6vvaoQ3ff-5sK+Zis0HgC5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKYAXd-fcukmXfdwiAxOxe+5c+Y6vvaoQ3ff-5sK+Zis0HgC5A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 16, 2023 at 11:25:01PM +0900, Namjae Jeon wrote:
> Hi Kees,
> 
> >  /* Read flags */
> > @@ -730,7 +730,7 @@ struct smb2_read_rsp {
> >  	__le32 DataLength;
> >  	__le32 DataRemaining;
> >  	__le32 Flags;
> > -	__u8   Buffer[1];
> > +	__u8   Buffer[];
> >  } __packed;
> >
> 
> You seem to have missed -1 removal in the code below.

Ah; thanks for this heads-up. I will need a v3.

> ./fs/cifs/smb2ops.c:5632:       .read_rsp_size = sizeof(struct
> smb2_read_rsp) - 1,
> ./fs/cifs/smb2ops.c:5654:       .read_rsp_size = sizeof(struct
> smb2_read_rsp) - 1,
...

These are interesting -- they don't show up at all in the code. What I
mean is that they're data-only changes. I'll add that to my before/after
build sanity checks.

Thanks!

-Kees

-- 
Kees Cook
