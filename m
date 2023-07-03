Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0A8EB64DC
	for <linux-hardening@archiver.kernel.org>; Mon,  3 Jul 2023 23:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjGCXJb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 3 Jul 2023 19:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjGCXJa (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 3 Jul 2023 19:09:30 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0CDE6
        for <linux-hardening@vger.kernel.org>; Mon,  3 Jul 2023 16:09:29 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b80b3431d2so24850215ad.1
        for <linux-hardening@vger.kernel.org>; Mon, 03 Jul 2023 16:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688425769; x=1691017769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pCViWeoaoIqREKt5VQUB2Bo7LBAEFHy3aH/YsBHaAQs=;
        b=dCdJNt2Xiw23cB9tFdmwx5uKIJ4qvUZvheuWdeuGCD43+kPE10UNTwc4n5mCkpY9/a
         8+OzFkYA2wSAUk4FRuP3lsJZEGTFYbr+r4VWNdQlgUbYWiIzMf5ejNEAejGfIUxVxFJN
         F8eekGEpb1gmebjrsQgqzwfzeeIkrSg3Gyx80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688425769; x=1691017769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCViWeoaoIqREKt5VQUB2Bo7LBAEFHy3aH/YsBHaAQs=;
        b=DZM4EIaeLyC4bi4ba9DP+yW6K4T///Fz+7mmqfpGQ2q+cy89vy2ToJBZWBtM+v2RKV
         FnMceH2yEgkYSPJX/VNfnpbUHqvO5Kpp348NlVrLZYwRE1x2zaPtrp2coV2QJCsMgkcd
         mYRYIe/Ru32bZOv0J2LF72t/AiCKhCZoAJS70KHyWZfppomDQU2v4i90lkkNd4aTm/qG
         MI0PvYe2kCd0NH1iRWEOuq1aYNbGM2mu/tjOatqCdNv01NeVs62bhRx3/uYo6qzQZDik
         a9g5I+EeW8MKacLGabMMRPF9fdz3IpHuKoBou8VRpY9vd4l+K/CA9jqvxs/kxwjjbseA
         ahOA==
X-Gm-Message-State: ABy/qLZYoSOnvl/LYQXzf41vviMHxPW0aodb1fmyFdRb0p5glGBeS6K8
        0YjeZfbuhko7mguSR09ZyTDF/A==
X-Google-Smtp-Source: APBJJlFh3LnVeIXMnt5LxB32yJcfVGC7UQ9seGjEUnsN/8mDc5cnwDrU21T2jUshyhoTuvYSsMA5qA==
X-Received: by 2002:a17:903:2446:b0:1b8:1c4f:4f72 with SMTP id l6-20020a170903244600b001b81c4f4f72mr11153985pls.61.1688425768750;
        Mon, 03 Jul 2023 16:09:28 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j23-20020a170902759700b001b53953f306sm15768832pll.178.2023.07.03.16.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 16:09:28 -0700 (PDT)
Date:   Mon, 3 Jul 2023 16:09:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LLVM <llvm@lists.linux.dev>,
        linux-kbuild@vger.kernel.org,
        Linux Regressions <regressions@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [CRASH][BISECTED] 6.4.1 crash in boot
Message-ID: <202307031606.3FD9D0D@keescook>
References: <9a8e34ad-8a8b-3830-4878-3c2c82e69dd9@alu.unizg.hr>
 <ZKIoBVzrjZ+Ybxy9@debian.me>
 <202307022018.B26F5795@keescook>
 <625e951e-9922-d15d-5520-e8cd5eba1995@roeck-us.net>
 <4fa56264-f188-46f9-cc77-117b469b3328@roeck-us.net>
 <2b1a4f49-ba18-0246-af09-4e4133814411@alu.unizg.hr>
 <202307022230.6121D6896@keescook>
 <ed3e4315-b149-2f9e-70d4-45d7f83b9922@alu.unizg.hr>
 <202307031149.823F9A3@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202307031149.823F9A3@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jul 03, 2023 at 12:03:23PM -0700, Kees Cook wrote:
> Cool. xhci-hub is in your backtrace, and the above patch was made for
> something very similar (though, again, I don't see why you're getting a
> _crash_, it should _warn_ and continue normally). And, actually, also
> include this patch:
> https://lore.kernel.org/lkml/20230614181307.gonna.256-kees@kernel.org/

This is now in Linus's tree:
09b69dd4378b ("usb: ch9: Replace 1-element array with flexible array")

Please also still try with the first patch I mentioned, which is very similar:
https://lore.kernel.org/lkml/20230629190900.never.787-kees@kernel.org/

-Kees

-- 
Kees Cook
