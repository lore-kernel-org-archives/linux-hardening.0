Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E141C433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Sep 2021 01:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D37161029
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Sep 2021 01:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243708AbhIXBRv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 23 Sep 2021 21:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243676AbhIXBRv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 23 Sep 2021 21:17:51 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E29C061756
        for <linux-hardening@vger.kernel.org>; Thu, 23 Sep 2021 18:16:18 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id v19so5705264pjh.2
        for <linux-hardening@vger.kernel.org>; Thu, 23 Sep 2021 18:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w5B8w4boy04cb2C9FnPWt5iQ9AQtwNvlUApWzI3TT6E=;
        b=fk/zXO6APsjQP2fh5wykxBplb9piOvz3CNMHFIPkMPwFt20Rurof4KpK+RCED8KfWg
         awr2VaO0bwCNMi6PCTnWMa1XeV3bxdLEGfMljXtedJWuUaehsap1a9+fq0dBtHOHqhrd
         VG1ySMWoZXdd4KZu0XVMzt+HO6rkK8NokbFFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w5B8w4boy04cb2C9FnPWt5iQ9AQtwNvlUApWzI3TT6E=;
        b=XrYBITH5Zzd/eZz4WYgh3nRgL0bbJcCUjPGmeqNrwG4BEGaSkr/slpnDyNkcxLqdsL
         5u8g4zzenxwDiAWTeWO6ENpafrTCX3GetxJaRP2nSUYF0HQi0P0g+FCirEzqyrXGAk8D
         AwMyZ/EjSSgZuj1lR1WoLldPQKaDYwZDwC1GQzn+usFpGVVVoxYzvza0bP6hS5hA6x7L
         wY7OdWihzF5r4EYHwc0hyA9neS6EeMdRubqu82KL/ZhzFrBG66YmBUMqYZ+FcvGhv+Sw
         senfKok3KAqTifSNfTuU6bd56ELOjbS5Qz09eDXgpI7PBnIn80txpIC1FKEXRXA8Ijuk
         LhVg==
X-Gm-Message-State: AOAM5334cwaL1nmubAb0W9sSpTY0M5TJawtnQm2IHMoE3gpzX/5hPziD
        T5fiY2pTR3bB5rFjCjiOuoyp9w==
X-Google-Smtp-Source: ABdhPJxoF8k/yHeE9qADjZViLo/daJ+jbNYuOpCagSw2t25LlmK7gyi40AMK5wwRJHKxrmnGmfYBDw==
X-Received: by 2002:a17:902:e153:b0:13b:63ba:7288 with SMTP id d19-20020a170902e15300b0013b63ba7288mr6270393pla.33.1632446178067;
        Thu, 23 Sep 2021 18:16:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e14sm6519648pfv.127.2021.09.23.18.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 18:16:17 -0700 (PDT)
Date:   Thu, 23 Sep 2021 18:16:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vito Caputo <vcaputo@pengaru.com>
Cc:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefan Metzmacher <metze@samba.org>,
        Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Michael =?iso-8859-1?Q?Wei=DF?= 
        <michael.weiss@aisec.fraunhofer.de>,
        Anand K Mistry <amistry@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] proc: Disable /proc/$pid/wchan
Message-ID: <202109231814.FD09DBAD3@keescook>
References: <20210923233105.4045080-1-keescook@chromium.org>
 <20210923234917.pqrxwoq7yqnvfpwu@shells.gnugeneration.com>
 <CAG48ez0Rtv5kqHWw368Ym3GkKodPA+JETOAN+=c2KPa3opENSA@mail.gmail.com>
 <20210924002230.sijoedia65hf5bj7@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924002230.sijoedia65hf5bj7@shells.gnugeneration.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 23, 2021 at 05:22:30PM -0700, Vito Caputo wrote:
> Instead of unwinding stacks maybe the kernel should be sticking an
> entrypoint address in the current task struct for get_wchan() to
> access, whenever userspace enters the kernel?

wchan is supposed to show where the kernel is at the instant the
get_wchan() happens. (i.e. recording it at syscall entry would just
always show syscall entry.)

-- 
Kees Cook
