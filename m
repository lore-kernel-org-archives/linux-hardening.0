Return-Path: <SRS0=pEkV=DM=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89679C4363A
	for <linux-hardening@archiver.kernel.org>; Mon,  5 Oct 2020 22:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 484382075A
	for <linux-hardening@archiver.kernel.org>; Mon,  5 Oct 2020 22:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RkKssiqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgJEW1T (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 5 Oct 2020 18:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727155AbgJEW1S (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 5 Oct 2020 18:27:18 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654C8C0613CE
        for <linux-hardening@vger.kernel.org>; Mon,  5 Oct 2020 15:27:18 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dt13so5111024ejb.12
        for <linux-hardening@vger.kernel.org>; Mon, 05 Oct 2020 15:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s1mfjLEDGEzWlccxnSMQEr7jNWf7euYCoYzxl2zCems=;
        b=RkKssiqHlG8Ofs/kGT7I6glvfRARgo8371PQIo6lDOxaDBDCLhPpSpudvcMAeYWbk5
         bmOkuzC2IrILpZKOZBXXB3QWraCQ1PEpL6C4EgsNb9TwSC7rAs1sL7KAgW3OH9Vqb04e
         XyRKO3935rMtgweMc7i+Ll3SUo3iyAh2nD+QWfavaK4RO3OZ2yIms5jtXpiiuri4AGj0
         97icN5ESgWsCBKJkFt9cSN5OSn4K9ZCOvxe/Ykv1EfuXMaTHtqO5jLbb5kXDxvFOzpEm
         ZAASmLzmmK3N4k20KmPkF3nZ7hW1Q5lsxFJch7+kx5WqjOUfmlsnfncJinq/XM23NCEf
         TCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s1mfjLEDGEzWlccxnSMQEr7jNWf7euYCoYzxl2zCems=;
        b=Vl08DdgeWCEX61vPUx6NjPWE7iqrN2kC2Q6otYsCBmFTFcCEG2+NqIA4DCAbZW81R2
         xM4Ixk2hBQAN8Aje14k1sY/+9JBoovSFfV15bL5DOyaAUI4DEME/Yn/gaY/wKuA6I08H
         z4vGWsl5jrhWKc3hX86QhGHbqY7i1BVUqqt3W92gwWRu1fYDXfQOzz9kg7YxOgL4fsh5
         CUklMWtCF7oceBhTOBfxvkTE9rL6Eclg9kJuJTCCuD6yFwwkxzEuC74ekhgQ3CIkzqiu
         HiLmMc4PyAj/vvNDiUDXkyjuJF+CjrarSwyckV5Z3c1EXCyA8GXpv1kNYuA/KlII69qs
         DFLQ==
X-Gm-Message-State: AOAM533AwRY89PSSxaICRP+uQ4NQyncNV/ZHYb3eICApiixxMR/lHfeU
        3sqj9tgMMAlung6fG4WtbBNu+p4jDpGF3FYwY3RHoQ==
X-Google-Smtp-Source: ABdhPJyviSfinqf2/Q4zwP/9ZqeAoiARX7ogGuTHGIzGBdPGBlosoYOw9O1TBXzd7Y+CwYLTK/GJ7VI20IR90sLo6j8=
X-Received: by 2002:a17:906:86c3:: with SMTP id j3mr1977865ejy.493.1601936836914;
 Mon, 05 Oct 2020 15:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <202009281907.946FBE7B@keescook> <20200929192517.GA2718@openwall.com>
 <202009291558.04F4D35@keescook> <20200930090232.GA5067@openwall.com>
 <20201005141456.GA6528@openwall.com> <20201005160255.GA4540@mit.edu> <20201005164818.GA6878@openwall.com>
In-Reply-To: <20201005164818.GA6878@openwall.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 6 Oct 2020 00:26:50 +0200
Message-ID: <CAG48ez0MWfA8zPxh5s5i2w9W7F+MxfjMXf6ryvfTqooomg1HUQ@mail.gmail.com>
Subject: Re: Linux-specific kernel hardening
To:     Solar Designer <solar@openwall.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Kees Cook <keescook@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 5, 2020 at 6:48 PM Solar Designer <solar@openwall.com> wrote:
> If 100% of the topics on linux-hardening are supposed to be a subset of
> what was on kernel-hardening, I think it'd be OK for me to provide the
> subscriber list to a vger admin, who would subscribe those people to
> linux-hardening.

(if folks want to go that route, probably easier to subscribe the list
linux-hardening@ itself to kernel-hardening@ instead of syncing
subscriber lists?)
