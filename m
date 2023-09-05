Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC28CA0FF3
	for <linux-hardening@archiver.kernel.org>; Tue,  5 Sep 2023 16:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbjIEQX0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347245AbjIEE1h (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 5 Sep 2023 00:27:37 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458E91B6
        for <linux-hardening@vger.kernel.org>; Mon,  4 Sep 2023 21:27:34 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1d0d3d40124so1777642fac.3
        for <linux-hardening@vger.kernel.org>; Mon, 04 Sep 2023 21:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693888053; x=1694492853; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3F4jq9KwUWrcSg6FlwSKwra3Pf1UGD13i4S70FgA9Lw=;
        b=bC5LvRiGFOuaQpY1bXD2nOL9CazAMIaoAWj4NrsfW8CpbFCkmb2v/YBLag96k42vUR
         fwlHjmy1+duKqkO6hkiD7njggUtXIhzi/U4ZbP3OJp4WqBkUZ6qqzUo6uATGhAI03Zaq
         V8xIkPuhLgbp2FkAelss3Y/T/Aq0/DHxMQcQdx+lqn+24vBkw1WwbISPLtZmVmfNKEWp
         MEn6Gj798JOTKfIssgiI0l41DbVxHegEaEhUWXDAxaFRTwR+lU3mbWnTJm/Iq650HPFw
         o3Z+0wuAzwytpx2gfcASQbmAvtZlzUVRQm23g4pDzdBNnDXfAGG67DXi5UPSQ8t7Nbog
         axgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693888053; x=1694492853;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3F4jq9KwUWrcSg6FlwSKwra3Pf1UGD13i4S70FgA9Lw=;
        b=b1DoJTaKjbB3b/Mksn/klfstQXoQHk9yf3/2cgfe1jyWkGfpjJvOWm5/CnfzKrSjUf
         miSBueb/LkSbU4bY1X/WwBvBzeYXUOEIv3P79OyUwTEF/3XtzTl4ZrUXyBREizQcur+I
         lTFdLslMS0JY2SiKJg8OXz3ki6l0rm7Cugh2t6+J7q55xHU9YwmWqnMljmFjeMklonL0
         sRk2cRoaZuaPcU5BtKY3vxpdW0MyLzvqSEqqwlRkEL6++FtmaWkgV1ailXu3reLGV515
         wCg3aPGtaNSvCaQ8XLZ4bQ36Qr7Z0Jp/YauY1A990ybI/drixBMtTQsZKaQmJkzP6OMP
         krEQ==
X-Gm-Message-State: AOJu0Yy+pvYUt1wW5tTDvsfchpPiw22bNnTVtNAjbS4RxAqFatEQOzS6
        djjyuvHi9smDhlH9mE95p+j3wxEgFBgpUIVKxDCryBmtLwDbiw==
X-Google-Smtp-Source: AGHT+IF3U4hHgPu/FA6vr0+e2wIG1mHSNjp1ebd64tSjKuexdq8XG4SLikKT/CAw8CCx7wybhCsB4FXU3umS3wcIwqY=
X-Received: by 2002:a05:6870:168b:b0:1be:ec3b:3ae1 with SMTP id
 j11-20020a056870168b00b001beec3b3ae1mr15383300oae.50.1693888053241; Mon, 04
 Sep 2023 21:27:33 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Farrell <djfarrell@gmail.com>
Date:   Tue, 5 Sep 2023 14:27:22 +1000
Message-ID: <CAKO8emZtcfPk4PvFXkvV85Jx-cHh0Qq0R8bfpW1a97E+1BQXQg@mail.gmail.com>
Subject: Software based row hammer mitigation for systems with memory error detection
To:     linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi!

As per the subject I have an idea for a software based mitigation for Row
Hammer type attacks, in particular on systems which use ECC or have other error
detection mechanisms.

I was just hoping to get the idea out there to see if there is any interest in
putting it in the kernel.

The idea is pretty simple, although I imagine implementation may be a pain.

ECCploit[1] uses a method of making a single bit error present in a page, and
then causing a read of that page and then observing that reading the page has
higher latency (due to ECC processing).

However, the kernel, upon detecting an ECC error, could copy that physical page
to another region/page, and remap the virtual page to point to the new physical
region/page.

So, further Row Hammering will be off target.

This could also be thought of like how a non-volatile drive will detect faulty
(or nearly faulty) blocks and use the set aside space on the drive for the
block in question.

Anyway, if this is a bad idea that's fine too. Full disclosure I did a noob
thing and initially sent this message to the security mailing list - but I did
get a reply from Linus who I think has reservations about such a technique:

On Tue, 5 Sept 2023 at 03:54, Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> On Mon, 4 Sept 2023 at 00:39, Dan Farrell <djfarrell@gmail.com> wrote:
> >
> > However, the kernel, upon detecting an ECC error, could copy that physical page
> > to another region/page, and remap the virtual page to point to the new physical
> > region/page.
>
> Honestly, any hardware that makes correctable ECC errors synchronous
> is already broken.
>
> ECCploit is just one example of how broken that approach is, but it's
> just broken in general. The kernel doesn't want an immediate "you had
> a correctable error" machine check, and in fact in many situations
> cannot sanely deal with such a thing - very much including doing major
> surgery like moving pages around for it.
>
> Realistically, what we want for rowhammer is *detection* that
> hammering is going on. The exploit will take long enough that once you
> can detect it, the fix is to stop the exploit, not to try to do
> anything fancier.

Please let me know if it would be useful in the kernel. I could probably
eventually implement it (supposing it is implementable), but my only kernel
hacking experience is with drivers so I would be facing a steep learning
curve.

Regards,

Dan Farrell

[1] https://www.vusec.net/projects/eccploit/
