Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B22C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 17 Nov 2021 18:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4AE461BD3
	for <linux-hardening@archiver.kernel.org>; Wed, 17 Nov 2021 18:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240209AbhKQSu3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 17 Nov 2021 13:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240184AbhKQSu3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 17 Nov 2021 13:50:29 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D8AC061766
        for <linux-hardening@vger.kernel.org>; Wed, 17 Nov 2021 10:47:30 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id b15so15435857edd.7
        for <linux-hardening@vger.kernel.org>; Wed, 17 Nov 2021 10:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2GQP2tRGysNgPEKNCjI+dwty2vanWOhkRb6VoLXLY6c=;
        b=cwihSbWXg/XvJyyox4hBavRvB43vlOFqjx0Ds7R7QUBkVvFBWqFdGsRVpbdaqduTXV
         lWY/xgnS2OvmtgH0WOAYFCikajlVm8p7uWcpv/7XvH7YVsRymkbcLTFNZhoMH0OkFNib
         x61xgU0vbY/zNqkzXCo3Wcdgl/mo2Dc+R/xPntSCtRJmojF9TQ/2taROZZJBYzLvHDlG
         Ua4m3kTdCLHG4QSdfXIk/EfcdIYLaEpoQkQdYKY4GPayfIKKDcMzsPtUmVfgsoZJc0Jy
         f5Pwr4cJV70tcrnPJXyRXfmym7oh/x1Ug7FP2E5gm1tDNXuGrayTDOMDF7tcZ5secqag
         Q6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2GQP2tRGysNgPEKNCjI+dwty2vanWOhkRb6VoLXLY6c=;
        b=M6C3du983CUakwBoxNKWWotBb3YPZKt7FvIsLO4l87zHJS+TVQ/kfG3afSXC3WdE/p
         U/qEY67bBvrzmTZhP2FIo7/2spl/Mvn0xQ4yr0EsEPtOUmihVdBPEz6cl9Q9HtLu9cuU
         8Oyrg7/hPlGdrtvT4rgmCHemUX45G5zQ85Quq9HBI2ocyzTS2M4zBV93zNA9coNgaH9A
         PM+wyYQrQCy02GfwAhLH3FM4PyUa+4zsZ56dHc3feT0FPpYiItFG6LLd8a50Pi/erzoF
         No+rfNCjzu1/6J7A3yzg+uhQi0sn1WddbudOaR96y0YjDi7yVDIbKo1unyhdYWGuy0lZ
         7m7g==
X-Gm-Message-State: AOAM5333VlCa+KEhOBJlA5orhYZ05X0Zt0MXEZxiTJXs+ntUic1gE2eq
        MS23PW2bob+6z/hgBRKGuiuhIw2tUnsaAfxGq4Rtog==
X-Google-Smtp-Source: ABdhPJzzVIVN1wyydH6f4f7OlGu6N3bX8zKWGU3H6C2rPo0t+oyEeAHFI/swWYHkGFU26QqJA7D3qJ52L+jOiMsxclQ=
X-Received: by 2002:a17:906:140b:: with SMTP id p11mr24492849ejc.116.1637174848825;
 Wed, 17 Nov 2021 10:47:28 -0800 (PST)
MIME-Version: 1.0
From:   Kyle Huey <me@kylehuey.com>
Date:   Wed, 17 Nov 2021 10:47:13 -0800
Message-ID: <CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com>
Subject: [REGRESSION] 5.16rc1: SA_IMMUTABLE breaks debuggers
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrea Righi <andrea.righi@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

rr, a userspace record and replay debugger[0], is completely broken on
5.16rc1. I bisected this to 00b06da29cf9dc633cdba87acd3f57f4df3fd5c7.

That patch makes two changes, it blocks sigaction from changing signal
handlers once the kernel has decided to force the program to take a
signal and it also stops notifying ptracers of the signal in the same
circumstances. The latter behavior is just wrong. There's no reason
that ptrace should not be able to observe and even change
(non-SIGKILL) forced signals.  It should be reverted.

This behavior change is also observable in gdb. If you take a program
that sets SIGSYS to SIG_IGN and then raises a SIGSYS via
SECCOMP_RET_TRAP and run it under gdb on a good kernel gdb will stop
when the SIGSYS is raised, let you inspect program state, etc. After
the SA_IMMUTABLE change gdb won't stop until the program has already
died of SIGSYS.

- Kyle

[0] https://rr-project.org/
