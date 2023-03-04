Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451BBC6FA99
	for <linux-hardening@archiver.kernel.org>; Sat,  4 Mar 2023 04:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjCDEgT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 3 Mar 2023 23:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjCDEgS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 3 Mar 2023 23:36:18 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7251ACC9
        for <linux-hardening@vger.kernel.org>; Fri,  3 Mar 2023 20:36:16 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id v10-20020a056602058a00b007076e06ba3dso2464475iox.20
        for <linux-hardening@vger.kernel.org>; Fri, 03 Mar 2023 20:36:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBM8f3nfkQPiCUxCkC/1jIKN/CSWO63Mv0FZdwLHa7w=;
        b=WkG3Lp5cJVi5MP6OylisznAJCW3kp0M35t0lowacSZpzYZZZUF8E3E8uZZcUSeQXFu
         8LX4q04qG6Oef65o5hXJZdXQNuuydYgeeHewmRhw5jLn5a/TL5QKqjj2aBk3L6ANghWW
         X4S6R5olb2lX4K4vB7l93yEZYW+9XVpHMXYMGTWdYvV/SfdA+n2akqfVlfKBCJ0WcaP/
         dyeSetqq4ZegLigh8I99V6SZHaXmcUtWIqffE0aVtOWWwyUiYG8zIOSoIsUTpoL6vW8/
         BRoH2H0JEL80LejTwH9wn+PHaGBKi9TdLDMvJ4xf30BJ5rAiPEON7aZ885maRBe7vI+k
         DIsg==
X-Gm-Message-State: AO0yUKW6uuCNtmbB/bPlwtEi0xIAoiyZqstwI5oFjVTfK/CsSKpDhQhi
        rH4Vntatu8Yw6oWbMjEo+DY5esdotmq88QeAHiwtMrP7RD/e
X-Google-Smtp-Source: AK7set9ivc7a0hTa59+MlzQADnVR9rVesqaUQ/nvWX6Tgg9CYI6nEEqLldZZLLoEwGD8VgHEij9xXEv9mpDaSxPxdEDomAm6DdMV
MIME-Version: 1.0
X-Received: by 2002:a02:94cd:0:b0:3e1:fb3d:4dce with SMTP id
 x71-20020a0294cd000000b003e1fb3d4dcemr1851215jah.0.1677904576128; Fri, 03 Mar
 2023 20:36:16 -0800 (PST)
Date:   Fri, 03 Mar 2023 20:36:16 -0800
In-Reply-To: <0000000000001d1fb505f605c295@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a2e5e05f60b9aff@google.com>
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in con_font_op
From:   syzbot <syzbot+3af17071816b61e807ed@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, daniel@ffwll.ch, deller@gmx.de,
        dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, keescook@chromium.org,
        linux-fbdev@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        samuel.thibault@ens-lyon.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

syzbot has bisected this issue to:

commit 24d69384bcd34b9dcaf5dab744bf7096e84d1abd
Author: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date:   Thu Jan 19 15:19:16 2023 +0000

    VT: Add KD_FONT_OP_SET/GET_TALL operations

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=120b3232c80000
start commit:   2eb29d59ddf0 Merge tag 'drm-next-2023-03-03-1' of git://an..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=110b3232c80000
console output: https://syzkaller.appspot.com/x/log.txt?x=160b3232c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cab35c936731a347
dashboard link: https://syzkaller.appspot.com/bug?extid=3af17071816b61e807ed
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b71504c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f02d9cc80000

Reported-by: syzbot+3af17071816b61e807ed@syzkaller.appspotmail.com
Fixes: 24d69384bcd3 ("VT: Add KD_FONT_OP_SET/GET_TALL operations")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
