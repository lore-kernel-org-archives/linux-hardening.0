Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923EEC7EE29
	for <linux-hardening@archiver.kernel.org>; Wed, 31 May 2023 23:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjEaXCo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 31 May 2023 19:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjEaXCn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 31 May 2023 19:02:43 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AC2107
        for <linux-hardening@vger.kernel.org>; Wed, 31 May 2023 16:02:38 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-ba829e17aacso193061276.0
        for <linux-hardening@vger.kernel.org>; Wed, 31 May 2023 16:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685574158; x=1688166158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nzIRRbGx22h7W4dzVmFren/95lkctbr3Uctdnt7nnU=;
        b=WmPDmQ1h0qMnUeHvgUMsjpTh6VPEpTtOoNQ11MIJWu8Yqw0fd3oAGLpJdpSMotScGS
         spn0YANEwG/lKK1g4Gi1omZBv815jXYv6S6kCYbkEuBs2j/MYKV3FUNEHcvO7f+QbHQM
         Z8eo/LSR+Uy2F4fCrZWf5thKAUw2VrOtPnSl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685574158; x=1688166158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nzIRRbGx22h7W4dzVmFren/95lkctbr3Uctdnt7nnU=;
        b=edoptumf3thPRRsdE0EgBgzJ6VwFH/iR3Yhzz5YPRi2aeeIJ+PKg/+11hgaowOM22u
         y5JJZvw4Suz1Y+pjbL7Fysppo+l/7klSPIWFFuw/nYVrXOxiAoROlBzcujX85j0wuMen
         unLeuJzxlf7EGZSG/dfnjcp9ctPVj4oO8VxYSvfqxdqrS6ukESVFhL2Bsyw177decCFu
         m3OHWHdPNM0d/p76RZTXlvkyMKps5jJlEgcevF3zyIWq3PLJdSxitPDiqMIs4zoRAiCf
         cZ6QdpasBmHkR9clrQL4xjzTM+8Txi3aDOQZp6VtHdLKaUqOSQZWqYI4EongJ94xllLA
         9FjQ==
X-Gm-Message-State: AC+VfDxHjU9X9fxekibcwM5/dzKU6yxBwCm+/BUYjHBDwIULr9PJ3sG7
        3bKHyZZPodw2ucLQ5jIoMI8rqNxkAQptMo27UBlrEA==
X-Google-Smtp-Source: ACHHUZ5hYf4p5U4e13Z1TleOH6isd0dp1HozTXSttchtojblNVlRPE54CQdz6YsI5G/k0FTvb1SR8akrNc+ZPON09N4=
X-Received: by 2002:a25:7303:0:b0:bab:ab4a:83e0 with SMTP id
 o3-20020a257303000000b00babab4a83e0mr7718310ybc.26.1685574158132; Wed, 31 May
 2023 16:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230515130553.2311248-1-jeffxu@chromium.org> <2bcffc9f-9244-0362-2da9-ece230055320@intel.com>
 <CAEAAPHYdRyZEMp97919errF7SDuYBJoSrD5i1wrTx1sMdr_ZdQ@mail.gmail.com>
 <fbe53dcf-6e21-e4cf-c632-4da8369d7e83@intel.com> <CAEAAPHa=zYyjV5RqvPryRsW7VqY9cJC_-CJW6HKczY0iVsy-bg@mail.gmail.com>
 <d8f2d5c2-6650-c2a6-3a20-25583eee579b@intel.com> <CALmYWFsnGjniVseJKuhKO6eet10Onyk_C0=KNe6ZzXoCiBKZOw@mail.gmail.com>
 <b69f6809-b483-158f-8be9-4976fad918d8@intel.com> <CALmYWFs5Vgosz2JUYWkoc4YwDbiB0tT32MFpo-y6aX4kwuoz8Q@mail.gmail.com>
 <2b14036e-aed8-4212-bc0f-51ec4fe5a5c1@intel.com>
In-Reply-To: <2b14036e-aed8-4212-bc0f-51ec4fe5a5c1@intel.com>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Wed, 31 May 2023 16:02:00 -0700
Message-ID: <CABi2SkU9iDqpcXfPpwphEgL0-rBionphfT3+Zscq_Htx=ps+2g@mail.gmail.com>
Subject: Re: [PATCH 0/6] Memory Mapping (VMA) protection using PKU - set 1
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Jeff Xu <jeffxu@google.com>,
        =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>,
        luto@kernel.org, jorgelo@chromium.org, keescook@chromium.org,
        groeck@chromium.org, jannh@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Dave,

Regarding siglongjmp:

On Thu, May 18, 2023 at 8:37=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 5/17/23 16:48, Jeff Xu wrote:
> > However, there are a few challenges I have not yet worked through.
> > First, the code needs to track when the first signaling entry occurs
> > (saving the PKRU register to the thread struct) and when it is last
> > returned (restoring the PKRU register from the thread struct).
>
> Would tracking signal "depth" work in the face of things like siglongjmp?
>
siglongjmp is interesting, thanks for bringing this up.

With siglongjmp, the thread doesn't go back to the place where signal is
raised, indeed, this idea of tracking the first signaling entry
doesn't work well with siglongjmp.

Thanks for your insight!
-Jeff


-Jeff
