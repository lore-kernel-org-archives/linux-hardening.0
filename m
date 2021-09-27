Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286ECC433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 27 Sep 2021 20:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08DAC61052
	for <linux-hardening@archiver.kernel.org>; Mon, 27 Sep 2021 20:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbhI0Uwp (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 27 Sep 2021 16:52:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56379 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236868AbhI0Uwo (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 27 Sep 2021 16:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632775865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JD0mT4ckkienFPXQ/dMglnBNojQj5rBrrYdubpyF/sM=;
        b=bZDPz0YAzDhsoVLaw1IeVgGM20g7qN5ft5MeeLLD+PVcGOXlm3fm3h0GePwRic6mUVD7E1
        +DZzD2U3cFs3GoeK+7FZ0gGCAYnEFI8oTnb50RX1IRAj8L/EHCd7KcBmCKeHKyDY5z1xlR
        lkeAayRB7lBA8zeA7mjKrsCk8QlEVCg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-efyIvZYdN4yHqefWwmjo_Q-1; Mon, 27 Sep 2021 16:51:02 -0400
X-MC-Unique: efyIvZYdN4yHqefWwmjo_Q-1
Received: by mail-qk1-f198.google.com with SMTP id x3-20020a05620a448300b0045e3e24de82so5117954qkp.3
        for <linux-hardening@vger.kernel.org>; Mon, 27 Sep 2021 13:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JD0mT4ckkienFPXQ/dMglnBNojQj5rBrrYdubpyF/sM=;
        b=C4ut13JrNV2ZQUhqyqqyZDmurfuFIR4vPw5Ogq1zcrnOdY90UytmWsWolXsziCCaKP
         mQGukXMjkEHVixAGagcM1dKx1vpmVrLZxe1A58Qq9DlkheRsmkdv1g4cauijHUDeKFjU
         Y6PfZT7Bc8/PVpqk76v9Du6yFEsuVpleXCDazfE1U70YjeJxkmK/Pd9tSNgiKQXIrySQ
         K9DWgegNPMQyvc10wR8DjfHn+tTUE1Ej3ybgcVUJkE8KDsTjkAOMhlk/tocK4AhnsPiw
         /Pxu4XIyTJeOmdDIFP09aoSgW2WEV0y1OVto0K8cQ+ZC1NHgShUMHSL3jqYY47M9gX/G
         fsAQ==
X-Gm-Message-State: AOAM533cr8WQrVWRIq9JY1ZpYzgkxIganPTd2yHSU3cVxa3Y3Upok4IJ
        Y5RoFLdYoJMlvEDTqgTt2cfbAT7suRDjHERL14vj2TnYa/1y95TeSPw463unGdKigeNTEFWimVT
        LDPK5wofRoGnwOB2O93Uk3O0unOs7
X-Received: by 2002:ac8:5a4a:: with SMTP id o10mr1965117qta.61.1632775862131;
        Mon, 27 Sep 2021 13:51:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTRBkkAbh0TQhbT5DxVcLFqQZvP8ZJBSTBJtCeQmJMCWaVvaksY4R32FfJrYe6wg6cp394wQ==
X-Received: by 2002:ac8:5a4a:: with SMTP id o10mr1965099qta.61.1632775861872;
        Mon, 27 Sep 2021 13:51:01 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id h17sm1019186qtp.13.2021.09.27.13.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 13:51:01 -0700 (PDT)
Date:   Mon, 27 Sep 2021 13:50:56 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20210927205056.jjdlkof5w6fs5wzw@treble>
References: <20210923233105.4045080-1-keescook@chromium.org>
 <20210923234917.pqrxwoq7yqnvfpwu@shells.gnugeneration.com>
 <CAG48ez0Rtv5kqHWw368Ym3GkKodPA+JETOAN+=c2KPa3opENSA@mail.gmail.com>
 <20210924002230.sijoedia65hf5bj7@shells.gnugeneration.com>
 <202109231814.FD09DBAD3@keescook>
 <20210924135424.GA33573@C02TD0UTHF1T.local>
 <202109240716.A0792BE46@keescook>
 <20210927090337.GB1131@C02TD0UTHF1T.local>
 <202109271103.4E15FC0@keescook>
MIME-Version: 1.0
In-Reply-To: <202109271103.4E15FC0@keescook>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 27, 2021 at 11:07:27AM -0700, Kees Cook wrote:
> On Mon, Sep 27, 2021 at 10:03:51AM +0100, Mark Rutland wrote:
> > On Fri, Sep 24, 2021 at 07:26:22AM -0700, Kees Cook wrote:
> > > On Fri, Sep 24, 2021 at 02:54:24PM +0100, Mark Rutland wrote:
> > > > On Thu, Sep 23, 2021 at 06:16:16PM -0700, Kees Cook wrote:
> > > > > On Thu, Sep 23, 2021 at 05:22:30PM -0700, Vito Caputo wrote:
> > > > > > Instead of unwinding stacks maybe the kernel should be sticking an
> > > > > > entrypoint address in the current task struct for get_wchan() to
> > > > > > access, whenever userspace enters the kernel?
> > > > > 
> > > > > wchan is supposed to show where the kernel is at the instant the
> > > > > get_wchan() happens. (i.e. recording it at syscall entry would just
> > > > > always show syscall entry.)
> > > > 
> > > > It's supposed to show where a blocked task is blocked; the "wait
> > > > channel".
> > > > 
> > > > I'd wanted to remove get_wchan since it requires cross-task stack
> > > > walking, which is generally painful.
> > > 
> > > Right -- this is the "fragile" part I'm worried about.
> 
> I'd like to clarify this concern first -- is the proposed fix actually
> fragile? Because I think we'd be better off just restoring behavior than
> trying to invent new behavior...
> 
> i.e. Josh, Jann, do you see any issues with Qi Zheng's fix here:
> https://lore.kernel.org/all/20210924062006.231699-4-keescook@chromium.org/

Even with that patch, it doesn't lock the task's runqueue before reading
the stack, so there's still the possibility of the task running on
another CPU and the unwinder going off the rails a bit, which might be
used by an attacker in creative ways similar to the /proc/<pid>/stack
vulnerability Jann mentioned earlier.

-- 
Josh

