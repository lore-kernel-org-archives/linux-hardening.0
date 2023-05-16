Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B77C7EE23
	for <linux-hardening@archiver.kernel.org>; Tue, 16 May 2023 23:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjEPXha (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 16 May 2023 19:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjEPXh3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 16 May 2023 19:37:29 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAF15259
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 16:37:28 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f37884956bso170e87.1
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 16:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684280247; x=1686872247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3cyjPKDEETW9BoaEFZPFlkSTqObLADNtxINVLQqYFs=;
        b=sfoNUTG7NcUMYKrPlQ6h6W5SKsRa0vmOp8q/513w0aQHfwXABSOgbZ/0flBuGDfj1h
         N6X0KheevQYPN0GIY/kVb74OJEB9MhsqjFzR1HjeFUF8lKQ8fRjyhRdm4EAw/rt6KhJt
         0nKP/X2QE8K9G32zFaoehnKHKpleay3BM12Cu1DJ1HYyME1n30CAeCM02jHQ4nioAqtF
         7foP51GbGpZTbmLKY6Ig5epxmVaYWZ8Pc7OaO9ijoBYYTflGQYlc/GFXyyCWQD23y36I
         xzJplVx0SmcEawjdUrvg2dZjkIVX6jf11/dM8AlTUeuUdwTSud4ElguaP6EPbJmKHi6v
         QYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684280247; x=1686872247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B3cyjPKDEETW9BoaEFZPFlkSTqObLADNtxINVLQqYFs=;
        b=enh99exJx4EkQgBBg0bv+/ycJJzXpTmu6/USxd3NZ6guyzjb9fWUyHwDVG64ZBp7G9
         n9W8XIwZZdD5xrNIel8v11lM5oj1fQQumiheh39Wutf/NK4+UgabA9/0W4SFryWcPB1H
         TTHno6jZCwfR/MD//vc+3MNoOZMzo3EqQwHabEx3680xSN8xyds1fy2NwlXsDQCh4FwQ
         oqiG/Fa6X7tvfwIvBUppjJvh4bGZg4H0PJgMou+093DECQbb+po3vAicn4HeF/KVqccB
         AUd89CH/dzBceEqUwiz8MTcWejm216g3d3fCMKhYFIplzBbt8mFk3s83QfIOGMBYHsJI
         6QYw==
X-Gm-Message-State: AC+VfDwnnUt2fVz+Sl6HQ8Gv+Q/DCSfdn/fwBi8BAFzpmqTnkXFysXCc
        iSqBoCBAvF/XFqtAiIJo+icJPjKq7VFTGdBUuHulkA==
X-Google-Smtp-Source: ACHHUZ7cpmyJObyaViqWzpJRKdk7zMSWg9lLD6ZsxBPhJhsDoJ5qssn7At+CRnjxlB6QS91sb2qEM3QcHU971ozzjBE=
X-Received: by 2002:ac2:4ed8:0:b0:4e8:3f1e:de43 with SMTP id
 p24-20020ac24ed8000000b004e83f1ede43mr25525lfr.7.1684280246758; Tue, 16 May
 2023 16:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230515130553.2311248-1-jeffxu@chromium.org> <20230515130553.2311248-4-jeffxu@chromium.org>
 <78bb0097-7dca-254f-45a6-5cea6baec0c4@intel.com>
In-Reply-To: <78bb0097-7dca-254f-45a6-5cea6baec0c4@intel.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 16 May 2023 16:36:49 -0700
Message-ID: <CALmYWFvC55idHEyRiiuAwDOVv+rjP-3DejCfLW8c0iK8AGoJcw@mail.gmail.com>
Subject: Re: [PATCH 3/6] PKEY: Apply PKEY_ENFORCE_API to mprotect
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     jeffxu@chromium.org, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        sroettger@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 16, 2023 at 4:19=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 5/15/23 06:05, jeffxu@chromium.org wrote:
> >  /*
> >   * pkey=3D=3D-1 when doing a legacy mprotect()
> > + * syscall=3D=3Dtrue if this is called by syscall from userspace.
> > + * Note: this is always true for now, added as a reminder in case that
> > + * do_mprotect_pkey is called directly by kernel in the future.
> > + * Also it is consistent with __do_munmap().
> >   */
> >  static int do_mprotect_pkey(unsigned long start, size_t len,
> > -             unsigned long prot, int pkey)
> > +             unsigned long prot, int pkey, bool syscall)
> >  {
>
> The 'syscall' seems kinda silly (and a bit confusing).  It's easy to
> check if the caller is a kthread or has a current->mm=3D=3DNULL.  If you
> *really* want a warning, I'd check for those rather than plumb a
> apparently unused argument in here.
>
> BTW, this warning is one of those things that will probably cause some
> amount of angst.  I'd move it to the end of the series or just axe it
> completely.

Agreed. syscall is not a good name here.
The intention is to check this at the system call entry point
For example, munmap can get called inside mremap(), but by that time
mremap() should already check that all the memory is writeable.

I will remove "syscall" from do_mprotect_pkey signature, it seems it caused
more confusion than helpful.  I will keep the comments/note in place to rem=
ind
future developer.
