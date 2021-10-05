Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F52CC433F5
	for <linux-hardening@archiver.kernel.org>; Tue,  5 Oct 2021 08:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22AA66128A
	for <linux-hardening@archiver.kernel.org>; Tue,  5 Oct 2021 08:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhJEIam (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 5 Oct 2021 04:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhJEIal (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 5 Oct 2021 04:30:41 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C504CC061745;
        Tue,  5 Oct 2021 01:28:51 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id d11so21044309ilc.8;
        Tue, 05 Oct 2021 01:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxntDmAn7pyc+6bbfF1hzJvhGPEpkzavUN7ynxK4EDM=;
        b=d0VG/7IwzKhSeSVkEXyX8+vqtEaNLONPlemle0rf98iFOOGAT1E/b6MIx1eAkCmuZC
         OH3gwqGQwe3RhST5ewUzbkE9JZ1/womyxeYComV+do2cteAaq8eGLjs8Yz5zt1+fTNrN
         CX5aqkWAetjmhTKa/bJzPWFK2bc9mvX/cVbMBcjBWJsPTQMjKNPQJc3AWKnDyGma1p26
         LxtuarShq+XOwuQFS1F7eWLtxMxye3pZDXaoTNsAuWSbc/pc+gqezUnVCB054uoPeQYt
         UpAIXzorrIo6vf0Oq7OAkUsO1oIqtQd8Q+te3kkwko5wpLj0kHJKJrXc0FcXZBdpIGQg
         1l3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxntDmAn7pyc+6bbfF1hzJvhGPEpkzavUN7ynxK4EDM=;
        b=V+MJQWakWfFoIdvx1KXDsa1qsFP0woTpWctOyhfg+J/hHth6N6J1wGX3n6ms1mlXN7
         RsSNagSA5DeHdtwD/ezsBzDMUdQItVKb81yN9+QjjCBy8joAGopbHGKRdbmJydGKJQck
         k4HJ4YISa8Mt9T5H6LCwwDZMfS3trBfgpKeO4hWLwNWALcHM5GPVrPlJqtNWJGCeH+qR
         PVrLE3MsnPp/QIs0nTV8rQPu/g5kywZ6C4VAP9n/iZ1Ru/jqj4FwUOO7A89WjpdlF8fr
         JI99FVnxjds+bqDYHGec7Pq8Jqm6wCIUcll/01vO7aqFve/wISTeXx5RlkVceQ5exnab
         3wdA==
X-Gm-Message-State: AOAM530LHCoT8PIznnlplenEChAY2N2UyyK5yBqM3hvSlxFsTMQi9bri
        /8oxiuQ1ItjLI+bw2EgR62mZqHgY6caRTrcMOUo=
X-Google-Smtp-Source: ABdhPJzHm6OHvKeXKD6v6d9vbtQDlLspmnLKVdoMZNAsJtn10HUY8fIMcH41bal7yxgpl0eUvlbYPEn6fvMvsrg8HwI=
X-Received: by 2002:a05:6e02:1d86:: with SMTP id h6mr2164806ila.5.1633422531046;
 Tue, 05 Oct 2021 01:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210930235754.2635912-1-keescook@chromium.org> <87h7dw75gh.fsf@meer.lwn.net>
In-Reply-To: <87h7dw75gh.fsf@meer.lwn.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 5 Oct 2021 10:28:40 +0200
Message-ID: <CANiq72mTmYCJ4_7KVRMMKCDTMrnE9wCXBKViCMzkW1ErpdZKHg@mail.gmail.com>
Subject: Re: [PATCH v4] docs: Explain the desired position of function attributes
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Oct 5, 2021 at 1:57 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> In this case I think we're as close as to consensus as things get.  In
> the absence of a strong reason to the contrary, I'll apply this before
> too long.

No strong reason, but there was the question about the `__malloc` in a
separate line in the second example which seems to contradict the
declaration and it is not explained otherwise (+ clang-format does it
differently).

Cheers,
Miguel
