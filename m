Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C261BC433ED
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Apr 2021 20:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9934A60BBB
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Apr 2021 20:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbhDAUtg (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Apr 2021 16:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbhDAUtc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Apr 2021 16:49:32 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7D7C0613E6
        for <linux-hardening@vger.kernel.org>; Thu,  1 Apr 2021 13:49:29 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id u2so3195494ilk.1
        for <linux-hardening@vger.kernel.org>; Thu, 01 Apr 2021 13:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=503hKwYrluHe7rzXvvTuO5Ds7xU9ZtmkFmCuve3OUwI=;
        b=T+UhdWF4aqmg2ZylQFMRDPXW6aPssKlkaLIRlDgDIbcXPhWS3AvGnIgN8VLU+nMswb
         jrhHY/ImGHHednYV6WZxP2eWyCOovosMi2/X3wmU/gsIyGxtNxOoVXsCVJu6h6Lzwg8F
         mNCJx1C0WoSt30h/RjB3TnqJAN/sO5lL81s+HL6SdGxi5N8di3dC3+c1H7MB9NrSBczr
         4xy5YP0RC61uJduxc44JciCIY/WxvtlWt2gRjuTwdmgrzhsT2Xx6poSQK947WoBRpbwl
         YA9luqXYH6pNIwB9tloz9mDSSeodQKMg7WmXE2vLy5ykI6Gi8NiiKjZkt0BEp2DI/rG3
         AkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=503hKwYrluHe7rzXvvTuO5Ds7xU9ZtmkFmCuve3OUwI=;
        b=LjjbC9xsq3FKdOYa1hmCSwTWQ6F/lg4J68dLIj2YZ1SUSdAwWlhjxt4LGjnuBe3DV9
         Kf5fuRabwoSzHdfUHfUYlWLVcyAH7qikMe9r4Ua1QwXVR04stJaS1kWhakjVhmRB/dlD
         kZtaX+e499LKLF1ooxHGY23u4QvMc3jmnHjFNUCUkMbEvGrG1nMy4i9oL9gu5CUH9b96
         VbWmxPzDD6kHYCLpB8iJH19PDehBlU7rG3dDdvMmXvB4Xra0uNr5o72AjkyjZxuKY1h+
         Yjvq+N9r0JQAGXw/65ECOzluqmxzsgvg8HUaC/d1cU+jfEvS0YtEsU/6s7nAQ8pV6USe
         r4+g==
X-Gm-Message-State: AOAM53126EYy72tINwEJ48sYYdjMqd0XAlqdmjbMEhI3mbikJoWbP4tR
        VnTdq3ZCMME7zNWKr+43fh0QUNpR3wadMiALNxNawA==
X-Google-Smtp-Source: ABdhPJwg40rT7G5Nev6xmTZThDkud37ci7jhp5fZnJbhUfhKp7HZqv6FgQreyfCV7eEd4yY7eS94HcoA72xjvq9350w=
X-Received: by 2002:a05:6e02:eed:: with SMTP id j13mr8514330ilk.76.1617310169073;
 Thu, 01 Apr 2021 13:49:29 -0700 (PDT)
MIME-Version: 1.0
From:   Roy Yang <royyang@google.com>
Date:   Thu, 1 Apr 2021 13:49:17 -0700
Message-ID: <CANemeMjOw4sOzMxjdjJcWKD315u+KRn19h687GMbkQdP5Jc_kQ@mail.gmail.com>
Subject: [PATCH v8 0/6] Optionally randomize kernel stack offset each syscall
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, keescook@chromium.org,
        akpm@linux-foundation.org, alex.popov@linux.com,
        ard.biesheuvel@linaro.org, catalin.marinas@arm.com, corbet@lwn.net,
        david@redhat.com, elena.reshetova@intel.com,
        Alexander Potapenko <glider@google.com>,
        Jann Horn <jannh@google.com>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com,
        peterz@infradead.org, rdunlap@infradead.org, rppt@linux.ibm.com,
        tglx@linutronix.de, vbabka@suse.cz, will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Thanks Ted, Casey and Al Viro. I am sorry for the inconvenience.

I tried to follow the instructions listed under
https://lore.kernel.org/lkml/20210330205750.428816-1-keescook@chromium.org/
using git-send-email

Thought that will reply to the original thread with the original
subject . Let me know what I can do to correct this to avoid
confusion.


- Roy


On Thu, Apr 1, 2021 at 1:13 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Thu, Apr 01, 2021 at 07:48:30PM +0000, Al Viro wrote:
> > On Thu, Apr 01, 2021 at 12:17:44PM -0700, Roy Yang wrote:
> > > Both Android and Chrome OS really want this feature; For Container-Optimized OS, we have customers
> > > interested in the defense too.
> > >
> > > Thank you very much.
> > >
> > > Change-Id: I1eb1b726007aa8f9c374b934cc1c690fb4924aa3
> >
> >       You forgot to tell what patch you are refering to.  Your
> > Change-Id (whatever the hell that is) doesn't help at all.  Don't
> > assume that keys in your internal database make sense for the
> > rest of the world, especially when they appear to contain a hash
> > of something...
>
> The Change-Id fails to have any direct search hits at lore.kernel.org.
> However, it turn up Roy's original patch, and clicking on the
> message-Id in the "In-Reply-Field", it apperas Roy was replying to
> this message:
>
> https://lore.kernel.org/lkml/20210330205750.428816-1-keescook@chromium.org/
>
> which is the head of this patch series:
>
> Subject: [PATCH v8 0/6] Optionally randomize kernel stack offset each syscall
>
> That being said, it would have been better if the original subject
> line had been preserved, and it's yet another example of how the
> lore.kernel.org URL is infinitely better than the Change-Id.  :-)
>
>                                               - Ted
