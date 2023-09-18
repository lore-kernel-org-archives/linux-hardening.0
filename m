Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFBACD37B0
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Sep 2023 18:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjIRSF5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 18 Sep 2023 14:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjIRSF4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 18 Sep 2023 14:05:56 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A3E101
        for <linux-hardening@vger.kernel.org>; Mon, 18 Sep 2023 11:05:51 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bf3f59905so642347866b.3
        for <linux-hardening@vger.kernel.org>; Mon, 18 Sep 2023 11:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695060349; x=1695665149; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q9he4ZTvSFJmzzOtbECfSpps3SrCLJMjInfE6GKKq3k=;
        b=bUVgWHMnkjjX89LpVYBlYAFFxi7k49SUfS7HOxtazHqfaavZYbHJ5mwmm1coywq111
         tGHfxKK31VpOn6AABTT5Xp5Q7VLKplkdPhUdm0OfncABSqD0cnfWMK9ffvYojxqAogwa
         bXHHzKnuiWMh6HMPur4X7IFW2OUut4UM6PXXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695060349; x=1695665149;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9he4ZTvSFJmzzOtbECfSpps3SrCLJMjInfE6GKKq3k=;
        b=wyIuVdGlXX0qeK84zJtvQ2q871jD3A5NovxaYuyAX8zDa9qsxem9YP3IntaxXC1Bj3
         h8NvZaLuhXgabNPicrN/ZLONAm2/12/hmtUJEaluM2xoEMEVqBNSFgmKw7eD1rU0guYa
         HOpnxOnXlcoKyXeMbThHbnpRRW2b05+CLD06kz46591vvM+5UBsepaoOdtDL4i76qI56
         z5rRJOul02ouISEXq4y6n5+7i1dtalaeJXVl8drUbEE2EnFfPKGELTGiHFx86Ft+s3HJ
         Uz/JiuVtavvBwHlo0fkm9weCmNJ8A9/PPW/Cb8d49dHVKhpTeogWPAwsNsc18i68dlPP
         eM/w==
X-Gm-Message-State: AOJu0YwUlRCYLrSSYHutTHOy1SvhOvaKHgeoChdRR5YEHITXiE6XcrCR
        1kBzXeWIwvwOjzWdCytmjfPNMxhLIvid1e3en+u+u7fg
X-Google-Smtp-Source: AGHT+IFNu+U5S6kfW6Gv+38B9hTa3/qMIKNd8ZfLShmnR7oCC5af3B9eM3SnxJN6F69VdNgjYTQ+xA==
X-Received: by 2002:a17:907:2722:b0:9a1:d67c:b4f3 with SMTP id d2-20020a170907272200b009a1d67cb4f3mr6693719ejl.77.1695060349550;
        Mon, 18 Sep 2023 11:05:49 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id c10-20020a170906340a00b009ad854daea6sm6681137ejb.132.2023.09.18.11.05.48
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 11:05:48 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-530ab2d9e89so3413624a12.2
        for <linux-hardening@vger.kernel.org>; Mon, 18 Sep 2023 11:05:48 -0700 (PDT)
X-Received: by 2002:a05:6402:2903:b0:530:d53c:b4d with SMTP id
 ee3-20020a056402290300b00530d53c0b4dmr5507496edb.35.1695060348351; Mon, 18
 Sep 2023 11:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230915105933.495735-1-matteorizzo@google.com>
 <7a4f5128-28fd-3c5f-34c2-1c34f4448174@intel.com> <1d7573c0-ebbc-6ed2-f152-1045eb0542f9@os.amperecomputing.com>
 <CAHKB1w+rVyww0UrHhzeGfPA7FM482Z-7ApzXvekVqLHvTDAV3Q@mail.gmail.com> <ZQiLX0W2Tcr+wdJT@gmail.com>
In-Reply-To: <ZQiLX0W2Tcr+wdJT@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Sep 2023 11:05:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgGzB4u-WZsDpdgjwX1w5=9CLE0gorhaNFD09P1FUGeuQ@mail.gmail.com>
Message-ID: <CAHk-=wgGzB4u-WZsDpdgjwX1w5=9CLE0gorhaNFD09P1FUGeuQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/14] Prevent cross-cache attacks in the SLUB allocator
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Matteo Rizzo <matteorizzo@google.com>,
        "Lameter, Christopher" <cl@os.amperecomputing.com>,
        Dave Hansen <dave.hansen@intel.com>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net, luto@kernel.org,
        peterz@infradead.org, jannh@google.com, evn@google.com,
        poprdi@google.com, jordyzomer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, 18 Sept 2023 at 10:39, Ingo Molnar <mingo@kernel.org> wrote:
>
> What's the split of the increase in overhead due to SLAB_VIRTUAL=y, between
> user-space execution and kernel-space execution?

... and equally importantly, what about DMA?

Or what about the fixed-size slabs (aka kmalloc?) What's the point of
"never re-use the same address for a different slab", when the *same*
slab will contain different kinds of allocations anyway?

I think the whole "make it one single compile-time option" model is
completely and fundamentally broken.

                     Linus
