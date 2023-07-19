Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1659EB64DA
	for <linux-hardening@archiver.kernel.org>; Wed, 19 Jul 2023 15:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjGSPbQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 19 Jul 2023 11:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjGSPbP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 19 Jul 2023 11:31:15 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25716132
        for <linux-hardening@vger.kernel.org>; Wed, 19 Jul 2023 08:31:11 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b8b2b60731so40185135ad.2
        for <linux-hardening@vger.kernel.org>; Wed, 19 Jul 2023 08:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689780670; x=1690385470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=76niNhHGhP25frfuWEqV5QNEgyLBCNjhHXOoO/mvUpA=;
        b=C2tE11QNyHEdr8f5HlDoKFZ9tYJiWeCUkV8xRIniZ9FmpGbVVIRIzXRdTPPJhhyT3L
         hkB1C1kqZ/BowWDR4FAH9ugKoHk2U78rjNGfy/Dc1jLIEj6kn90ktG/3KepI8Ji3fbih
         G2etcPHNxryDzGo7JhXv5mB7Ej18QL/3AhNd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689780670; x=1690385470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76niNhHGhP25frfuWEqV5QNEgyLBCNjhHXOoO/mvUpA=;
        b=Lxn8RnGfSsyuGwHtdtstoA9WtSeQGpknVHkOjbpPX2ETycgfvzA3bERcV5nQXmPQHj
         rBC8I72UZzPXdNb6JcS0f1EKJpircJGO+M4rj2F+7h3Qe2fblMEQvp+07QIQIwWnOhpP
         F52w6dVo3sTPBiMp7YwUMI3NhcjBsVzu472Vd53/KdvhXiBvSskow91sQehfPUWhVV4n
         2FsZOBXTKui10K6j03vedPOlk4ycW+dSkEHYeLwHNVJZn2D96IXVDXdfTZ3E9lyW8f8h
         nObviKCGr9ErlDNUxtcTo7mN/6/Nkg5O7V03nGXYJCiNf3nD0vyaARGPhvaSYIbPawAz
         zVXg==
X-Gm-Message-State: ABy/qLZI2mnPKJ1ESjxa9I+I42LnyzWQI59UZE7YNB+64LHq4X8vv7cn
        d/7/KGrUwQQG+VHJm0+uJk1JXg==
X-Google-Smtp-Source: APBJJlGv4HGF7AIGRr3yuCuB0YYhnkdfqpHIuTTgrUd4HRnveGCAWjZJyxe55MMTiWCnCPBN5ZvyMg==
X-Received: by 2002:a17:90a:9307:b0:263:f7ce:335e with SMTP id p7-20020a17090a930700b00263f7ce335emr15559754pjo.43.1689780670377;
        Wed, 19 Jul 2023 08:31:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902d48100b001b896d0eb3dsm4151122plg.8.2023.07.19.08.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 08:31:09 -0700 (PDT)
Date:   Wed, 19 Jul 2023 08:31:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: Crash in VirtualBox virtual machines running kernel 6.5
Message-ID: <202307190823.086EFD42D9@keescook>
References: <ab3a70e9-60ed-0f13-e3d4-8866eaccc8c1@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab3a70e9-60ed-0f13-e3d4-8866eaccc8c1@lwfinger.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jul 19, 2023 at 10:02:36AM -0500, Larry Finger wrote:
> Hi,
> 
> When I try to start a VirtualBox virtual machine running kernel 6.5-rc2, it
> gets a kernel bug as follows while trying to mount a vboxsf-shared mount:
> 
> Jul 19 08:48:19 localhost kernel: detected buffer overflow in strscpy
> Jul 19 08:48:19 localhost kernel: ------------[ cut here ]------------
> Jul 19 08:48:19 localhost kernel: kernel BUG at lib/string_helpers.c:1031!
> [...]
> Jul 19 08:48:19 localhost kernel: Call Trace:
> [...]
> Jul 19 08:48:19 localhost kernel:  vboxsf_fill_super+0x3bc/0x3c0 [vboxsf 447dff7257fbc53f0b47ed873d2b02eb4773401c]
> [...]
> 
> The traceback points to the strscpy() added in commit 883f8fe87686d, which
> ironically was submitted to avoid buffer overflows using strlcpy(); however,
> I do not think that is the problem. My suspicion is that it comes from
> struct shfl_string, and the definition of the variable-length arrays in the
> union, and that their lengths are confusing the kernel's string handling
> routines.

Ah, hm, I think this may still warn with 883f8fe87686d reverted, as it
seems the issue is the fake flexible arrays in struct shfl_string. Likely
the patch manifesting the false positive is df8fc4e934c1 ("kbuild:
Enable -fstrict-flex-arrays=3"), if you're building with GCC 13.

> I will be happy to test any proposed patches.

Thank! Can you see if this fixes it?

diff --git a/fs/vboxsf/shfl_hostintf.h b/fs/vboxsf/shfl_hostintf.h
index aca829062c12..243d1b91bb45 100644
--- a/fs/vboxsf/shfl_hostintf.h
+++ b/fs/vboxsf/shfl_hostintf.h
@@ -68,9 +68,8 @@ struct shfl_string {
 
 	/** UTF-8 or UTF-16 string. Nul terminated. */
 	union {
-		u8 utf8[2];
-		u16 utf16[1];
-		u16 ucs2[1]; /* misnomer, use utf16. */
+		DECLARE_FLEX_ARRAY(u8, utf8);
+		DECLARE_FLEX_ARRAY(u16, utf16);
 	} string;
 };
 VMMDEV_ASSERT_SIZE(shfl_string, 6);


(I note that "ucs" is used in the kernel source, and contains a comment
that it shouldn't be used, so I removed it.)

-- 
Kees Cook
