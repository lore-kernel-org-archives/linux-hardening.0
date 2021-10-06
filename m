Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7897C433F5
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 16:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8109610EA
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 16:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239280AbhJFQUt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238116AbhJFQUn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 6 Oct 2021 12:20:43 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA95C061753
        for <linux-hardening@vger.kernel.org>; Wed,  6 Oct 2021 09:18:51 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id s64so6617478yba.11
        for <linux-hardening@vger.kernel.org>; Wed, 06 Oct 2021 09:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0xSr56/FvBezCYYGx3+o4d+Zu6KknfVugxQiabr0PAg=;
        b=ROWUzPTJH5eoyrWzGpzD7/tmiI6BjNNDx+jUOWos5LDC0tL8up07naBJtCsz5ivk0X
         F8L/uHQwWrQuDaHUiSDKs/bwW8f8ZQm5K/ZNN40lum6ukHkm7KrgCijjRJEP4BLRvwqW
         aMbTXrFtVzgqAlRBpb0RDUfsVFPBbs1LsAKU3nbnnSX+3qp+eE+svWeq0pGbjbu/Opxd
         F57y7R1W/xzLvElYGKLUSG2v6MvaJvmsHN/qcWfRi/0oirWSiWe+AMqMe2HsyB8+myh2
         5Ru4r4fKWVyhq1YT+uaJVAjrbfvJbkMfILqXuywBdk/I1rmUEFHauNLPCzFBpCgNPWRJ
         TGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0xSr56/FvBezCYYGx3+o4d+Zu6KknfVugxQiabr0PAg=;
        b=m1KK7rgFQ14yfgVPszlkz5/nXzpRJ0ugG3Ea+zwP3W5l9jNplJBSJjLwJxQAI0t+7V
         TSFUjNUdlzneQaPFpYwO8DGL7n5uReUVqEpEH3A1TZvtcf7W4jwPBKt2fpnItjdOv+X+
         8zv0Cq0ysQ/tR3ZhZniTlxfhkdkHxdLTNEzGc8HNQiD9moMVnBFqvHjedi9iiOoKB4pT
         GaSTFxOimedWvZ4XoKf8FWqFFurZdBP0b4Z1Zt224AUiy8mvtAmvwoHNLFR7LbOyrNZH
         sXl8q2wK1pa0KiI5lRbfcqMzcrECORXcivggM6dw0crXD9UgKQeRhz4QpkIRLJTWhj9h
         AQbQ==
X-Gm-Message-State: AOAM531zkT/9fvsM0DkK2W8QnYzyScmrIQd7LN3dUbMMI/7jgPYVn3V5
        m50EcEMRidioOeKbRfP4KIo209CSnZiEw2rLydNqZw==
X-Google-Smtp-Source: ABdhPJwemM49g4lurr2EVbGRS4V8hk9Z0Hc4uossGIWkyIbYn2O+YuiWfVtEhLR9ekPnQWZPIVa+q1GjhT3duHORo6s=
X-Received: by 2002:a25:1c45:: with SMTP id c66mr31679935ybc.133.1633537129410;
 Wed, 06 Oct 2021 09:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
 <20210930180531.1190642-2-samitolvanen@google.com> <20211006033626.hfjke5jrvvzxhc67@treble>
In-Reply-To: <20211006033626.hfjke5jrvvzxhc67@treble>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 6 Oct 2021 09:18:38 -0700
Message-ID: <CABCJKufSX7yoZ5qcDjQcsg4P=soP+q9Yrf2Qiaa2JHdsn=s8_w@mail.gmail.com>
Subject: Re: [PATCH v4 01/15] objtool: Add CONFIG_CFI_CLANG support
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Oct 5, 2021 at 8:36 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Thu, Sep 30, 2021 at 11:05:17AM -0700, Sami Tolvanen wrote:
> > With CONFIG_CFI_CLANG, the compiler replaces function references with
> > references to the CFI jump table, which confuses objtool. This change,
> > based on Josh's initial patch [1], goes through the list of relocations
> > and replaces jump table symbols with the actual function symbols.
> >
> > [1] https://lore.kernel.org/r/d743f4b36e120c06506567a9f87a062ae03da47f.1611263462.git.jpoimboe@redhat.com/
>
> I found the original patch description to be much more useful than this
> one ;-)

Sure, I'll just copy that for the next version.

Sami
