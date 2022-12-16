Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98A9C001B2
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Dec 2022 15:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiLPPsC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Dec 2022 10:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiLPPr6 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Dec 2022 10:47:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C6650D6A
        for <linux-hardening@vger.kernel.org>; Fri, 16 Dec 2022 07:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671205626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LxMkecyGYG9dLIpgBNsZUPusnmfyW4vuV2TgoZY8b1I=;
        b=eEnN/C3dhAkjAhYy1VO16rUIUbcRpw3xqv/5yQQlkyS/lBFd0OxWqXlM2jdIfeQ0Ap25qk
        xA0elRbIUFzR8XPZLakSFLKfUq5FOPtL5+mC2EZtJ6M4kl128ojIrXKruQgK52AZzHKlB1
        Xp2Rfsn334KuN+1ayBWijgOIDAbd3ss=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-540-0bpes2wZMWSt-mN64ZsmkQ-1; Fri, 16 Dec 2022 10:47:02 -0500
X-MC-Unique: 0bpes2wZMWSt-mN64ZsmkQ-1
Received: by mail-qt1-f199.google.com with SMTP id bt4-20020ac86904000000b003a96b35e7a8so1770711qtb.8
        for <linux-hardening@vger.kernel.org>; Fri, 16 Dec 2022 07:47:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxMkecyGYG9dLIpgBNsZUPusnmfyW4vuV2TgoZY8b1I=;
        b=Nrh7ak1bmrR4ZqvcfsQFIt7F0zG6i+8UHXa7s2B7cChAyD0gEEf+0tBjSZ+ZSTOyJa
         z4KifjHGFUu4yibvyGknGCnaK6YWFLG0IJYzyIQqvJIAQGfZpBwcHHYdF1snQrWClorY
         aTRPZHWGca8uIm0qVTOa7eR3qhPE13ry6wNiCjCbGFdVyO9sCn92HxIJHS0CV36ooVIF
         5YhvgIDEML8baV7LNPG3/D7vy7hEOhKVOaw1ckCpB44EOHwcVvng+fOhWRPwVl+HPy66
         mRVysvHKzAofZ6W0ty9uXoIiGy+K6cX9cXfCVOYf0tyqOdW/9Zr2/6wNyeN/v22glF8T
         /cjQ==
X-Gm-Message-State: ANoB5pl8o9+jQzztXgzsqQhOHIOBKPAT8MRTx9Z4TaIswADw3a94hp16
        bxcmGNyR8C6MVoInPtWYHXXGJ9bcczff63PeZ+e3X5tq417TJGz2tU0NywW5ykjahl9dizLDKKg
        g3cBRuHezeKdLuWMM4j+urjW11RsG
X-Received: by 2002:a05:622a:40c5:b0:3a5:306f:b124 with SMTP id ch5-20020a05622a40c500b003a5306fb124mr45697429qtb.10.1671205622303;
        Fri, 16 Dec 2022 07:47:02 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5eK8zxu4MtCAROwOHMPjA4TRfLrCS+AsiC6Si+i4v1cyQH5maRZ4RJ3yJvRLlW+Au04FcIJQ==
X-Received: by 2002:a05:622a:40c5:b0:3a5:306f:b124 with SMTP id ch5-20020a05622a40c500b003a5306fb124mr45697411qtb.10.1671205622117;
        Fri, 16 Dec 2022 07:47:02 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-45-70-31-26-132.dsl.bell.ca. [70.31.26.132])
        by smtp.gmail.com with ESMTPSA id a5-20020ac844a5000000b003a68af60591sm1466597qto.70.2022.12.16.07.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 07:47:01 -0800 (PST)
Date:   Fri, 16 Dec 2022 10:46:59 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Jeff Xu <jeffxu@google.com>
Cc:     Kees Cook <keescook@chromium.org>, jeffxu@chromium.org,
        skhan@linuxfoundation.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6 3/6] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
Message-ID: <Y5yS8wCnuYGLHMj4@x1n>
References: <20221207154939.2532830-1-jeffxu@google.com>
 <20221207154939.2532830-4-jeffxu@google.com>
 <202212080821.5AE7EE99@keescook>
 <CALmYWFuKR538vHxqYH1p6mb9iShOohf5bpHZXSfUN4KQHYiwaA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CALmYWFuKR538vHxqYH1p6mb9iShOohf5bpHZXSfUN4KQHYiwaA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi, Jeff,

On Thu, Dec 08, 2022 at 02:55:45PM -0800, Jeff Xu wrote:
> > > +     if (!(flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {

[...]

> > > +             pr_warn_ratelimited(
> > > +                     "memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=%d '%s'\n",
> > > +                     task_pid_nr(current), get_task_comm(comm, current));

This will be frequently dumped right now with mm-unstable.  Is that what it
wanted to achieve?

[   10.822575] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=491 'systemd'
[   10.824743] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=495 '(sd-executor)'
...

If there's already a sane default value (and also knobs for the user to
change the default) not sure whether it's saner to just keep it silent as
before?

-- 
Peter Xu

