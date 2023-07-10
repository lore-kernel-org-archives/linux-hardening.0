Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB7CEB64D9
	for <linux-hardening@archiver.kernel.org>; Mon, 10 Jul 2023 07:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjGJHoB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 10 Jul 2023 03:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjGJHnz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 10 Jul 2023 03:43:55 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8894AE51
        for <linux-hardening@vger.kernel.org>; Mon, 10 Jul 2023 00:43:50 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f14865fcc0so3005e87.0
        for <linux-hardening@vger.kernel.org>; Mon, 10 Jul 2023 00:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688975029; x=1691567029;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nS9m98kU7hDON5ryRvZOg6LMxfmYBsr98C/Sd1A13CI=;
        b=RRqBnnb//nW6t3nRLasnJxQx/GuIxdAwXp2wOP+BcyAvcthgWgkd+sTtfie/kr9sAd
         GEA+ScniPM6o+JkXSqNJOQPrsNrlUwGtSErq4Ck12+nVA1sryxW0D9j2QH2+W0Osm37g
         wWZ41cJxErNPAQerVielB8/hlK1eqCAna5mAUYY1dO3atmeeNXzMNhTCbb2V12JU+rhO
         VXztVnfWWTLxZRc43VtumJ69UvXhYIeU4FvO62r+Qk7YG3h679bl3vSofsRls4sGjdhb
         hQ9Nbyuq5rvLS3xQB2FtQOB4lM9k+CkCX9t940ApquPV0ZZfzq+i5NLGjwJvT9hbo8jm
         TpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688975029; x=1691567029;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nS9m98kU7hDON5ryRvZOg6LMxfmYBsr98C/Sd1A13CI=;
        b=iN2086+GSyOY/6InDLLnv49b9wV5OglUJ+c+Dno/C7cd1WuCJ2Ovl1VG/8oOuFUi6h
         p5LQ2dUQSWu8+VqLYLD+9/ABYt69l7UPf8phzv6fDBb5Uc/oX46TopGEJBDM5K8uqqLD
         utd3e509vIQOxZhDG8sjIqa1cKOgKO14zCr1dGn2vKLPYEOjIGBe+DHVfHbBMoFpfIKw
         hD7v8KYnnzsXlHyy4f5wiTIMiNG8dTDkyDUap9fxQxzl/18wILg0zOmfvLYsDHDHiXxJ
         4Lj5T1crHA/y6s/Vg2a2olYeMRqbSibbnJEUOb10JxjwaBfs95WaCl8AZVqgo7wJvlmn
         6PFg==
X-Gm-Message-State: ABy/qLanni9qn/Hsy+GA9HEgQHqJyuqmakjeRbksbLsFw8Zh6vQ9KP2t
        8S0wJWMg/S3/rDeU3dDmldTXxXOXz/hLSrX14FYKAg==
X-Google-Smtp-Source: APBJJlG5VAfVRlULynbvxJ7b5YEii6Bpwwntm0JXdb0Ee51roYMqD4NIWeivc+EFp+fX/qxqkVDlqpnoKHZ0tC3zfmY=
X-Received: by 2002:a05:6512:480d:b0:4ec:5157:bb37 with SMTP id
 eo13-20020a056512480d00b004ec5157bb37mr66299lfb.2.1688975028537; Mon, 10 Jul
 2023 00:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000002373f005ff843b58@google.com> <1bb83e9d-6d7e-3c80-12f6-847bf2dc865e@google.com>
 <CACT4Y+akPvTGG0WdPdSuUFU6ZuQkRbVZByiROzqwyPVd8Pz8fQ@mail.gmail.com> <61032955-4200-662b-ace8-bad47d337cdc@os.amperecomputing.com>
In-Reply-To: <61032955-4200-662b-ace8-bad47d337cdc@os.amperecomputing.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 10 Jul 2023 09:43:36 +0200
Message-ID: <CACT4Y+YAyK02ORyzS79ub+XOK6x5LV8_2k4aztwzjP=0dm--RQ@mail.gmail.com>
Subject: Re: [syzbot] [mm?] [reiserfs?] kernel panic: stack is corrupted in ___slab_alloc
To:     "Lameter, Christopher" <cl@os.amperecomputing.com>
Cc:     David Rientjes <rientjes@google.com>,
        syzbot <syzbot+cf0693aee9ea61dda749@syzkaller.appspotmail.com>,
        42.hyeyoo@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        iamjoonsoo.kim@lge.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        penberg@kernel.org, reiserfs-devel@vger.kernel.org,
        roman.gushchin@linux.dev, syzkaller-bugs@googlegroups.com,
        Vlastimil Babka <vbabka@suse.cz>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 6 Jul 2023 at 20:33, Lameter, Christopher
<cl@os.amperecomputing.com> wrote:
>
> On Mon, 3 Jul 2023, Dmitry Vyukov wrote:
>
> >> This is happening during while mounting reiserfs, so I'm inclined to think
> >> it's more of a reisterfs issue than a slab allocator issue :/
>
> Have you tried to run with the "slub_debug" kernel option to figure out
> what got corrupted?

Can slub_debug detect anything that KASAN can't?
I would assume KASAN can detect more bugs (e.g. stack/globals) and
report way better. And it was already enabled in the config.
