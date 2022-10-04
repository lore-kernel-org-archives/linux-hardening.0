Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED67FC433FE
	for <linux-hardening@archiver.kernel.org>; Tue,  4 Oct 2022 14:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJDOhB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 4 Oct 2022 10:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiJDOg7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 4 Oct 2022 10:36:59 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFAA61718
        for <linux-hardening@vger.kernel.org>; Tue,  4 Oct 2022 07:36:58 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c24so12846198plo.3
        for <linux-hardening@vger.kernel.org>; Tue, 04 Oct 2022 07:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date;
        bh=G8HC/qdsdkCz+7nlQ+/5nMVixHm7s58AKwQk+/RzHE8=;
        b=LYQKdrQ0Jqy6tX7oRGZ9vSrT2Jm0TF3Jh5uqOznz4wYL4XHGchcbWu2fBwM+kZPqsI
         Dckj5FmcQO5rTtjuVrGv6TIVY6QSRvBRDxQdUGedBkj8JWyfo8VRldN3Few/qfYgSrZU
         48a20g1oNbkllVVfCO4inz6cg8RObiLO/Us+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=G8HC/qdsdkCz+7nlQ+/5nMVixHm7s58AKwQk+/RzHE8=;
        b=4gT4+nKZsqkwC+Di3l10YU41c3K/3asXRcJvQqdTIPyGla9rk10tQ906SYXL0mMNN9
         UXMO2UI7FdipJo+QS+Hf5wDCxQpX4ijHPv0La6u6PhPLQfLl/ZFTNUUDnnbbYtO02OjJ
         0d3KLCC+zXWvzUdOYl04mWI/tgGtM2zv+zmYa4CJPxswGVPeApMfyAb3tNrG8A5I3XtA
         OiRYqUxKCG18W9qsY1JZOuq4QmVF61xnAxTmksS9f41zPQRpTeeGDPexDOA70hexho4Q
         hyJ3rhkpGRUTQIY2LNC95jNC/aUmLoHpjBIePFxOjMsiC3/ACjeq3z5uoSqHh1LyRDdM
         QYbg==
X-Gm-Message-State: ACrzQf2Ur1zykNTLu1jOQ+bUOGXeA3XhvgAQVzmIwgEF2IeB0SZeodaq
        ZCepbPA8EaNuFxlTZ4RK8+XfEZnHNyu28A==
X-Google-Smtp-Source: AMsMyM4wbJ+ie7ot867nR4SuDtNWyvqfBc+uKwrli/A4yP9ItGLF1K7sJhlc9+CMWYcwmUfspjVLqQ==
X-Received: by 2002:a17:902:768c:b0:17a:ec9:51da with SMTP id m12-20020a170902768c00b0017a0ec951damr27738002pll.159.1664894218120;
        Tue, 04 Oct 2022 07:36:58 -0700 (PDT)
Received: from [127.0.0.1] (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i7-20020a63b307000000b0042aca53b4cesm8646731pgf.70.2022.10.04.07.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 07:36:57 -0700 (PDT)
Date:   Tue, 04 Oct 2022 07:36:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+3a080099974c271cd7e9@syzkaller.appspotmail.com>
CC:     bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        fw@strlen.de, harshit.m.mogalapalli@oracle.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        linux-hardening@vger.kernel.org
Subject: Re: [syzbot] upstream boot error: WARNING in netlink_ack
User-Agent: K-9 Mail for Android
In-Reply-To: <CACT4Y+a8b-knajrXWs8OnF1ijCansRxEicU=YJz6PRk-JuSKvg@mail.gmail.com>
References: <000000000000a793cc05ea313b87@google.com> <CACT4Y+a8b-knajrXWs8OnF1ijCansRxEicU=YJz6PRk-JuSKvg@mail.gmail.com>
Message-ID: <F58E0701-8F53-46FE-8324-4DEA7A806C20@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On October 4, 2022 1:33:30 AM PDT, Dmitry Vyukov <dvyukov@google=2Ecom> wr=
ote:
>On Tue, 4 Oct 2022 at 10:27, syzbot
><syzbot+3a080099974c271cd7e9@syzkaller=2Eappspotmail=2Ecom> wrote:
>>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    725737e7c21d Merge tag 'statx-dioalign-for-linus' of gi=
t:/=2E=2E
>> git tree:       upstream
>> console output: https://syzkaller=2Eappspot=2Ecom/x/log=2Etxt?x=3D10257=
034880000
>> kernel config:  https://syzkaller=2Eappspot=2Ecom/x/=2Econfig?x=3D486af=
5e221f55835
>> dashboard link: https://syzkaller=2Eappspot=2Ecom/bug?extid=3D3a0800999=
74c271cd7e9
>> compiler:       gcc (Debian 10=2E2=2E1-6) 10=2E2=2E1 20210110, GNU ld (=
GNU Binutils for Debian) 2=2E35=2E2
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
>> Reported-by: syzbot+3a080099974c271cd7e9@syzkaller=2Eappspotmail=2Ecom
>
>+linux-hardening
>
>> ------------[ cut here ]------------
>> memcpy: detected field-spanning write (size 28) of single field "&errms=
g->msg" at net/netlink/af_netlink=2Ec:2447 (size 16)

This is fixed in the pending netdev tree coming for the merge window=2E

--=20
Kees Cook
