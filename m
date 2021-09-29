Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3E8C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 29 Sep 2021 21:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7357361504
	for <linux-hardening@archiver.kernel.org>; Wed, 29 Sep 2021 21:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346550AbhI2VMO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 29 Sep 2021 17:12:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37996 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346340AbhI2VMN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 29 Sep 2021 17:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632949831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wIkb/A/ZJJji8jbTcCnkjRo12VXeXRq0QRKfxt1FsB0=;
        b=InPcSY2D/fXJaNzTzx5ekqdpy7HHyYBAAU6tA+bzWTV5ealKUJ65ow3IHSxvXBS3GVm2eZ
        foj9CyOuc6DPq4Tcdmp10aUAK0fM2kiPfs3HSFSbqFyDW4R5Z/N4MiBNVfpr7zQHioXvkD
        YNsQ0GTU5iwOSzXio3JyYvxi8ChDLmE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-i94xkdHYP8Gak3ixJlCBhQ-1; Wed, 29 Sep 2021 17:10:29 -0400
X-MC-Unique: i94xkdHYP8Gak3ixJlCBhQ-1
Received: by mail-qk1-f198.google.com with SMTP id j6-20020a05620a288600b0045e5d85ca17so11047134qkp.16
        for <linux-hardening@vger.kernel.org>; Wed, 29 Sep 2021 14:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wIkb/A/ZJJji8jbTcCnkjRo12VXeXRq0QRKfxt1FsB0=;
        b=hmsNptVsOV37MojeubhydCiR2am2ZcO1/TBNaMjsgQkTssynrPuXI0ocYuM+LZ0OiR
         yQTiNsFXY6zVX9QyIoBGPCv0Lj1hh6gwY5LqlEGUcMIbmQpALoSCrChm392Z+RWJ/+yB
         bH4vpOfevxdno+SiGcTcVf5r+9afYU6Ws96KMIGlHDxwrUBHCs38F24+NK9NMXD2VlSv
         I4A9c+KQDMCPasGcBu9uQUQ5Ko3uKmWpDWFce0Vnutr9waTGWNhG2XHBjXyGv41A7wDC
         7Ja59Mxe8wbcJ/F0N+2sPc3a0TaYovzMbXwj+eIo/kKBcTDAOUuxOmvCBAqZY5K0kZd7
         PEHQ==
X-Gm-Message-State: AOAM531kxYg4nzLvVxWzTZprvVOPABLfJvaWOAfi0sJx+wRTuKOf9zs6
        mg9Iy0MFOeSywH6dImjMEg47rhILcHWZvOYZ/lien2Of6UpLu6YtpxUoG6aTtcOz9lHxCbcADGq
        mI5khAQX4mf5wDCun8bXlkZBukgjK
X-Received: by 2002:a05:620a:22e:: with SMTP id u14mr1806763qkm.101.1632949829290;
        Wed, 29 Sep 2021 14:10:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcgVEpWdM29SW/CX8zRJPEzIxUJPnsb1Fm0pAA0XRfwrFWVYuJzcONjT5C6NUoEyRfY0MPcw==
X-Received: by 2002:a05:620a:22e:: with SMTP id u14mr1806721qkm.101.1632949829055;
        Wed, 29 Sep 2021 14:10:29 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id x10sm569784qtq.45.2021.09.29.14.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 14:10:28 -0700 (PDT)
Date:   Wed, 29 Sep 2021 14:10:23 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Stefan Metzmacher <metze@samba.org>,
        Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Michael =?utf-8?B?V2Vpw58=?= <michael.weiss@aisec.fraunhofer.de>,
        Anand K Mistry <amistry@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] proc: Disable /proc/$pid/wchan
Message-ID: <20210929211023.runlsoqfto7hrl36@treble>
References: <CAG48ez0Rtv5kqHWw368Ym3GkKodPA+JETOAN+=c2KPa3opENSA@mail.gmail.com>
 <20210924002230.sijoedia65hf5bj7@shells.gnugeneration.com>
 <202109231814.FD09DBAD3@keescook>
 <20210924135424.GA33573@C02TD0UTHF1T.local>
 <202109240716.A0792BE46@keescook>
 <20210927090337.GB1131@C02TD0UTHF1T.local>
 <202109271103.4E15FC0@keescook>
 <20210927205056.jjdlkof5w6fs5wzw@treble>
 <202109291152.681444A135@keescook>
 <20210929194026.GA4323@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
In-Reply-To: <20210929194026.GA4323@worktop.programming.kicks-ass.net>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Sep 29, 2021 at 09:40:26PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 29, 2021 at 11:54:55AM -0700, Kees Cook wrote:
> 
> > > > > > > It's supposed to show where a blocked task is blocked; the "wait
> > > > > > > channel".
> 
> > Since I think we're considering get_wchan() to be slow-path, can we just
> > lock the runqueue and use arch_stack_walk_reliable()?
> 
> Funny thing, when a task is blocked it isn't on the runqueue :-)
> 
> So if all we want to do is capture a blocked task and fail otherwise we
> don't need the rq->lock at all.
> 
> Something like:
> 
> 	unsigned long ip = 0;
> 
> 	raw_spin_lock_irq(&p->pi_lock);
> 	state = READ_ONCE(p->__state);
> 	smp_rmb(); /* see try_to_wake_up() */
> 	if (state == TASK_RUNNING || state == TASK_WAKING || p->on_rq)
> 		goto unlock;
> 
> 	ip = /* do actual stack walk on a blocked task */
> unlock:
> 	raw_spin_unlock_irq(&p->pi_lock);
> 
> 	return ip;

Ah, cool :-)

I'd also add that I don't see any reason to use the "reliable" unwinding
variant.  AFAIK, just basic stack_trace_save_tsk() should be sufficient.

-- 
Josh

