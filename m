Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E441AC77B7A
	for <linux-hardening@archiver.kernel.org>; Tue, 30 May 2023 14:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjE3Oo5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 May 2023 10:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjE3Oot (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 May 2023 10:44:49 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5366FE
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 07:44:47 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-4d9b2045e1cso12266a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 07:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685457886; x=1688049886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+t5dTE8kSUxjA4+aUdL/P2lX5zwmHCfFiqOu5qhUdY=;
        b=yw5ljc9t+qw8qp9m8RjQ71WrnyGtmNel4ldkFtv8NgwQ1lFcOiGyM5Y03pdzODVReB
         XyA5LjDDtSrpAlzcw1kSC1vp6NoPzPenOhFIgzKlHd5tK/DGsWmxxLtS2zmVns88oEZZ
         QHZfYe0C2eXuG9BCcrzZ2ZQru7H9GN5RdesPqnhapoaBWpzy10rxs0zca7JQXlqagULZ
         jXE4wNcdiezkrXnejvIocjwvEuMNRuApA3uiDinisBkxhDDdkGa1UzHa8a+BMZl4cW4W
         L6Y6HFlfGJORz6N3HHTzZU6UmOdER60ImpOy2QZHQCfOUUvpg/jMtsDa4n61z5DAMdIM
         7JQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685457886; x=1688049886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+t5dTE8kSUxjA4+aUdL/P2lX5zwmHCfFiqOu5qhUdY=;
        b=iKvgU30CoN8goZLQ41zXbTAEBbrRO9osA06CGfhvX2JytGblseGYIVuCGQXPxHp+tX
         HvMuKscLyoNxIUDEFlYZ2mqXh29Iist6QkMsmjh+fo3EuDuFlqtECzy/AeVvf4DMhIv3
         ZkvM/8tKWQXHz9Ui2aJXZSNKN9AoOdNTy8tnl044Nodrp4boULzDrjXHDN7eOwCvHFGW
         npVxmCgYOROF/2JqQEcwqRSf8r3GOS6f+uKLMmtUQecEUCjkkqd44TzoQY2uWWc3EZRx
         eG/p+J4tdrph+lic1XtLr2p7zIA00nV2BMVkvOa32KHOK2OENAaN+icsuFlJUU0zp3B+
         FFzA==
X-Gm-Message-State: AC+VfDyvXY/4YmlUDpKZvcc1loEDY/l3UJmyGlJeDxJfIT5CwpI7iimv
        iejUM8Z2WaPA2r0QR1ghjs1bZLYhH/wFq1b9WpLHpg==
X-Google-Smtp-Source: ACHHUZ4Lgy3noCUYRa49sMjUxhZy3XuJzFJvHTwdNMNfQRVP8eoz3gaoIpD8RTQf3zd55SfsnQjpmhiQug5cjIozG+s=
X-Received: by 2002:a50:d55d:0:b0:50b:c48c:8a25 with SMTP id
 f29-20020a50d55d000000b0050bc48c8a25mr84565edj.6.1685457885886; Tue, 30 May
 2023 07:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230517225838.never.965-kees@kernel.org> <20230518-jemand-ehrte-80f8b538ca03@brauner>
In-Reply-To: <20230518-jemand-ehrte-80f8b538ca03@brauner>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 30 May 2023 07:44:09 -0700
Message-ID: <CALmYWFt6F6h+NQR+BdrsjP53naS=Ps99Cpxmr4vpHM82=0-JSQ@mail.gmail.com>
Subject: Re: [PATCH] pid: Replace struct pid 1-element array with flex-array
To:     Christian Brauner <brauner@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Jan Kara <jack@suse.cz>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        syzbot+ac3b41786a2d0565b6d5@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, May 18, 2023 at 8:07=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, 17 May 2023 15:58:42 -0700, Kees Cook wrote:
> > For pid namespaces, struct pid uses a dynamically sized array member,
> > "numbers". This was implemented using the ancient 1-element fake flexib=
le
> > array, which has been deprecated for decades. Replace it with a C99
> > flexible array, refactor the array size calculations to use struct_size=
(),
> > and address elements via indexes. Note that the static initializer (whi=
ch
> > defines a single element) works as-is, and requires no special handling=
.
> >
> > [...]
>
> Applied to the kernel.fork branch of the brauner/linux.git tree.
> Patches in the kernel.fork branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
Acked-by: Jeff Xu <jeffxu@google.com>


> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
> branch: kernel.fork
>
> [1/1] pid: Replace struct pid 1-element array with flex-array
>       https://git.kernel.org/brauner/linux/c/ad0ff58dc959
